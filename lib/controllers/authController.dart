import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/controllers/searchController.dart';
import 'package:cashfuse/models/userModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/otpVerificationScreen.dart';
import 'package:cashfuse/widget/customLoader.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();
  String coutryCode;
  var otp = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  var contactNo = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  int seconds = 60;
  Timer timer;
  String status;

  UserCredential userCredential;
  OAuthProvider provider = OAuthProvider("apple.com");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  GoogleSignIn googleSignIn = GoogleSignIn();

  SearchController searchController = Get.put(SearchController());

  @override
  void onInit() async {
    coutryCode = global.appInfo.countryCode != null &&
            global.appInfo.countryCode.isNotEmpty
        ? global.appInfo.countryCode
        : '+91';
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      sharedPreferences.remove("user_token");
      sharedPreferences.remove("user_id");
      sharedPreferences.remove("user_name");
      sharedPreferences.remove("user_email");
      sharedPreferences.remove("user_phone");
      global.sp.remove('currentUser');
      global.currentUser = new UserModel();
      contactNo.clear();
      googleSignIn.signOut();

      update();
    } catch (e) {
      print("Exception - authController.dart - logout():" + e.toString());
    }
  }

  Future loginOrRegister(bool fromMenu) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (contactNo.text.isNotEmpty) {
          if (contactNo.text.length >= 7) {
            Get.dialog(CustomLoader(), barrierDismissible: false);
            await apiHelper
                .loginOrRegister(coutryCode + contactNo.text)
                .then((response) async {
              if (response.statusCode == 200) {
                await sendOTP(fromMenu);
              } else {
                Get.back();
                showCustomSnackBar(response.message);
              }
            });
          } else {
            showCustomSnackBar('Please enter valid number.');
          }
        } else {
          showCustomSnackBar('Please enter number.');
        }
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }

      update();
    } catch (e) {
      Get.back();
      print("Exception - authController.dart - loginOrRegister():" +
          e.toString());
    }
  }

  Future sendEmail(bool fromMenu) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (email.text.isNotEmpty) {
          Get.dialog(CustomLoader(), barrierDismissible: false);
          await apiHelper.loginWithEmail(email.text).then((response) async {
            if (response.statusCode == 200) {
              startTimer();
              if (global.getPlatFrom()) {
                Get.dialog(Dialog(
                  child: SizedBox(
                      width: Get.width / 3,
                      child: OtpVerificationScreen(
                        fromMenu: fromMenu,
                      )
                      // LoginOrSignUpScreen(
                      //   fromMenu: true,
                      // ),
                      ),
                ));
              } else {
                Get.to(() => OtpVerificationScreen(
                      fromMenu: fromMenu,
                    ));
              }
            } else {
              Get.back();
              showCustomSnackBar(response.message);
            }
          });
        } else {
          showCustomSnackBar('Please enter email.');
        }
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }

      update();
    } catch (e) {
      Get.back();
      print("Exception - authController.dart - sendEmail():" + e.toString());
    }
  }

  Future sendOTP(bool fromMenu) async {
    try {
      otp.clear();
      if (global.getPlatFrom()) {
        FirebaseAuth auth = FirebaseAuth.instance;
        Get.back();
        ConfirmationResult confirmationResult =
            await auth.signInWithPhoneNumber(coutryCode + contactNo.text);
        if (confirmationResult.verificationId != null) {
          Get.dialog(Dialog(
            child: SizedBox(
              width: Get.width / 3,
              child: OtpVerificationScreen(
                verificationCode: confirmationResult.verificationId,
                fromMenu: fromMenu,
              ),
            ),
          ));
        }
      } else {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: coutryCode + contactNo.text,
          verificationCompleted: (PhoneAuthCredential credential) {
            otp.text = credential.smsCode;
            update();
          },
          verificationFailed: (FirebaseAuthException e) {
            Get.back();
            showCustomSnackBar(e.message.toString());
            log(e.message.toString());
          },
          codeSent: (String verificationId, int resendToken) async {
            Get.back();
            startTimer();

            Get.to(
              () => OtpVerificationScreen(
                verificationCode: verificationId,
                fromMenu: fromMenu,
              ),
              routeName: 'verifyOtp',
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } catch (e) {
      Get.back();
      print("Exception - authController.dart - sendOTP():" + e.toString());
    }
  }

  Future<void> googleSignInFun(bool fromMenu) async {
    try {
      googleSignIn.signOut();

      UserModel _user = new UserModel();

      GoogleSignInAccount googleUSer = await googleSignIn.signIn();
      if (googleUSer != null) {
        var user = googleUSer;
        final googleCred = await user.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleCred.accessToken, idToken: googleCred.idToken);
        userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        log(userCredential.toString());

        _user.loginType = 'google';
        _user.socialId = userCredential.user.uid;
        _user.name = userCredential.user.displayName;
        _user.userImage = userCredential.user.photoURL;

        _user.email = userCredential.user.email;

        Get.dialog(CustomLoader(), barrierDismissible: false);

        await apiHelper.socialLogin(_user).then((response) async {
          Get.back();
          if (response.statusCode == 200) {
            global.currentUser = response.data;

            global.sp.setString(
                'currentUser', json.encode(global.currentUser.toJson()));
            Get.to(() => BottomNavigationBarScreen(), routeName: 'home');
            await getProfile();
            if (fromMenu) {
              await Get.find<HomeController>().getClick();
              await getProfile();
              await searchController.allInOneSearch();
              if (!GetPlatform.isWeb) {
                await global.referAndEarn();
              }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
        // update();
        // global.showOnlyLoaderDialog(Get.context);
        // await signIn();
        // global.hideLoader();
        // global.getCurrentUser();
        // if (global.currentUser!.fristName != null && global.currentUser!.fristName != "") {
        //   Get.off(() => BottomNavigationWidget(
        //         a: a,
        //         o: o,
        //       ));
        // } else {
        //   Get.off(() => EditProfileScreen());
        // }
        // await signupController.checkEmailContact(userCredential!.user!.email!, signupController.cPhone.text, callId: 3);

        // if (!signupController.isUserExist) {
        //   Get.bottomSheet(inputContactWidget(email: userCredential!.user!.email!));
        // }

        //}
      }
    } catch (e) {
      print("Exception - authController.dart - googleSignInFun():" +
          e.toString());
    }
  }

  // Future facebookLogin(bool fromMenu) async {
  //   print("FaceBook");
  //   // global.showOnlyLoaderDialog(Get.context);
  //   try {
  //     final result =
  //         await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
  //     if (result.status == LoginStatus.success) {
  //       final OAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential(result.accessToken.token);
  //       // global.hideLoader();
  //       // var userData = await FacebookAuth.i.getUserData();
  //       // print(userData);
  //       // print(userData["email"]);
  //       //user secrate
  //       // ignore: prefer_typing_uninitialized_variables
  //       var cred;
  //       if (facebookAuthCredential.accessToken != null) {
  //         cred = await FirebaseAuth.instance
  //             .signInWithCredential(facebookAuthCredential);
  //         // oAuthAccessToken = facebookAuthCredential.accessToken;
  //         // oAuthProviderName = 'facebook';
  //         // oAuthUserId = cred.user!.uid;
  //         // oAuthUserName = cred.user!.displayName;
  //         // oAuthUserPicUrl = cred.user!.photoURL;
  //         // isOAuth = true;
  //       }
  //       // await signupController.checkEmailContact(cred.user.providerData[0].email, null, callId: 3);
  //       // cEmail.text = cred.user.providerData[0].email;
  //       update();
  //       // global.showOnlyLoaderDialog(Get.context);
  //       // await signIn();
  //       // global.hideLoader();
  //       // global.getCurrentUser();
  //       // if (global.currentUser!.fristName != null && global.currentUser!.fristName != "") {
  //       //   Get.off(() => BottomNavigationWidget(
  //       //         a: a,
  //       //         o: o,
  //       //       ));
  //       // } else {
  //       //   Get.off(() => EditProfileScreen());
  //       // }
  //       // await signupController.checkEmailContact(cred.user.providerData[0].email, signupController.cPhone.text, callId: 3);
  //     }
  //   } catch (e) {
  //     print('Exception in facebookLogin:$e');
  //   }
  // }

  // Future signInWithApple() async {
  //   try {
  //     // global.showOnlyLoaderDialog(Get.context);
  //     String generateNonce([int length = 32]) {
  //       const charset =
  //           '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //       final random = math.Random.secure();
  //       return List.generate(
  //           length, (_) => charset[random.nextInt(charset.length)]).join();
  //     }

  //     String sha256ofString(String input) {
  //       final bytes = utf8.encode(input);
  //       final digest = sha.sha256.convert(bytes);
  //       return digest.toString();
  //     }

  //     final rawNonce = generateNonce();
  //     final nonce = sha256ofString(rawNonce);
  //     final credential = await SignInWithApple.getAppleIDCredential(scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName
  //     ], nonce: nonce)
  //         .catchError((e) {
  //       print("error $e");
  //     });

  //     final oauthCredential = provider.credential(
  //         idToken: credential.identityToken, rawNonce: rawNonce);
  //     final authResult = await _auth
  //         .signInWithCredential(oauthCredential)
  //         .onError((error, stackTrace) {
  //       print("error ${error.toString()}");
  //       return user;
  //     }).catchError((e) {
  //       // global.hideLoader();
  //       print("error ${e.toString()}");
  //     });
  //     print('Auth cred ${authResult.user.uid}'); //usersecrate
  //     print(
  //         '--------------------------------------------------------------------------------');
  //     print(
  //         'cred authCode ${credential.authorizationCode} email ${credential.email} givenName ${credential.givenName}  familyname ${credential.familyName} identytToken ${credential.identityToken}');

  //     if (credential.authorizationCode != '') {
  //       // oAuthProviderName = 'apple';
  //       // oAuthUserId = authResult.user!.uid;
  //       // oAuthUserName = credential.givenName;
  //       // oAuthUserPicUrl = null;
  //       // isOAuth = true;
  //       // cEmail.text = credential.email!;
  //       // update();
  //       // global.showOnlyLoaderDialog(Get.context);
  //       // await signIn();
  //       // global.hideLoader();
  //       // global.getCurrentUser();
  //       // if (global.currentUser!.fristName != null && global.currentUser!.fristName != "") {
  //       //   Get.off(() => BottomNavigationWidget(
  //       //         a: a,
  //       //         o: o,
  //       //       ));
  //       // } else {
  //       //   Get.off(() => EditProfileScreen());
  //       // }
  //       // await signupController.checkEmailContact(credential.email, signupController.cPhone.text, callId: 3);
  //     }
  //   } catch (e) {
  //     print(
  //         "Exception - sign_in_controller.dart - signInWithApple(): ${e.toString()}");
  //     return null;
  //   }
  // }

  // Future sendEmailOTP() async {
  //   try {
  //     // emailAuth.sessionName = 'Cashfuse';
  //     // // emailAuth.config(data);
  //     // bool result = await emailAuth.sendOtp(recipientMail: email.text);
  //     // emailAuth = new EmailAuth(sessionName: 'Cashfuse');
  //     // bool result =
  //     //     await emailAuth.sendOtp(recipientMail: email.text, otpLength: 6);
  //     // print(result);
  //
  //     emailOTP.setConfig(
  //       appEmail: 'codefuse.org@gmail.com',
  //       userEmail: email.text,
  //       otpLength: 6,
  //       otpType: OTPType.digitsOnly,
  //       appName: global.appName,
  //     );
  //
  //     // // emailOTP.sendOTP();
  //
  //     if (await emailOTP.sendOTP() == true) {
  //       startTimer();
  //       // global.hideLoader();
  //       //  global.showToast(message: "OTP has been sent");
  //       //  signupController.timer();
  //       Get.to(() => OtpVerificationScreen(
  //           // phoneNumber: settingsController.cNewEmail.text,
  //           // verificationId: "",
  //           // callId: 2,
  //           ));
  //     } else {
  //       // global.hideLoader();
  //       // global.showToast(message: "Oops, OTP send failed");
  //       showCustomSnackBar("Oops, OTP send failed");
  //     }
  //   } catch (e) {
  //     print("Exception - otp_verification_screen.dart - _sendEmailOTP():" +
  //         e.toString());
  //   }
  // }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (timerVal) {
        if (seconds == 0) {
          timer.cancel();
          timerVal.cancel();
          update();
        } else {
          seconds--;
          update();
        }
      },
    );
    update();
  }

  void stopTimer() {
    seconds = 60;
    timer?.cancel();
    update();
  }

  Future checkOTP(String verificationCode, bool fromMenu) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        FirebaseAuth auth = FirebaseAuth.instance;
        var _credential = PhoneAuthProvider.credential(
            verificationId: verificationCode, smsCode: otp.text.trim());
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await auth.signInWithCredential(_credential).then((result) {
          Get.back();
          status = 'success';
          verifyOtp(status, fromMenu);
        }).catchError((e) {
          status = 'failed';
          Get.back();
          verifyOtp(status, fromMenu);
        }).onError((error, stackTrace) {
          showCustomSnackBar(error.toString());
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - authController.dart - checkOTP():" + e.toString());
    }
  }

  Future verifyOtp(String status, bool fromMenu) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper
            .verifyOtp(coutryCode + contactNo.text, status)
            .then((response) async {
          Get.back();
          if (response != null) {
            if (response.statusCode == 200) {
              global.currentUser = response.data;
              contactNo.clear();
              otp.clear();

              global.sp.setString(
                  'currentUser', json.encode(global.currentUser.toJson()));
              Get.to(() => BottomNavigationBarScreen(), routeName: 'home');
              await getProfile();
              if (fromMenu) {
                await Get.find<HomeController>().getClick();
                await getProfile();
                await searchController.allInOneSearch();
                if (!GetPlatform.isWeb) {
                  await global.referAndEarn();
                }
              }
            } else {
              showCustomSnackBar(response.message);
            }
          } else {
            showCustomSnackBar('Something went Wrong.');
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }

      update();
    } catch (e) {
      print("Exception - authController.dart - verifyOtp():" + e.toString());
    }
  }

  Future verifyEmail(bool fromMenu) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper
            .verifyEmail(email.text, otp.text)
            .then((response) async {
          Get.back();
          if (response != null) {
            if (response.statusCode == 200) {
              email.clear();
              otp.clear();
              global.currentUser = response.data;

              global.sp.setString(
                  'currentUser', json.encode(global.currentUser.toJson()));
              Get.to(() => BottomNavigationBarScreen(), routeName: 'home');
              await getProfile();
              if (fromMenu) {
                await Get.find<HomeController>().getClick();
                await getProfile();
                await searchController.allInOneSearch();
                if (!GetPlatform.isWeb) {
                  await global.referAndEarn();
                }
              }
            } else {
              showCustomSnackBar(response.message);
            }
          } else {
            showCustomSnackBar('Something went Wrong.');
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }

      update();
    } catch (e) {
      print("Exception - authController.dart - verifyEmail():" + e.toString());
    }
  }

  Future resendOtp() async {
    try {
      stopTimer();
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth
          .verifyPhoneNumber(
        phoneNumber: coutryCode + contactNo.text,
        verificationCompleted: (AuthCredential authCredential) async {},
        verificationFailed: (e) {
          showCustomSnackBar(e.message.toString());
          log(e.message.toString());
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          startTimer();
          Navigator.of(Get.context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                verificationCode: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
      )
          .onError((error, stackTrace) {
        showCustomSnackBar(error.message.toString());
        log(error.message.toString());
      });
    } catch (e) {
      print("Exception - authController.dart - resendOtp():" + e.toString());
    }
  }

  Future updateProfile(File userImage) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (email.text.trim().isNotEmpty) {
          Get.dialog(CustomLoader(), barrierDismissible: false);
          await apiHelper
              .updateProfile(name.text.trim(), contactNo.text,
                  email.text.trim(), userImage)
              .then((response) async {
            Get.back();
            if (response != null) {
              if (response.statusCode == 200) {
                showCustomSnackBar(response.message, isError: false);
                await getProfile();
              } else {
                showCustomSnackBar(response.message);
              }
            } else {
              showCustomSnackBar('Email has been already taken');
            }
          });
        } else {
          showCustomSnackBar('Please enter Email.');
        }
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }

      update();
    } catch (e) {
      print(
          "Exception - authController.dart - updateProfile():" + e.toString());
    }
  }

  Future getProfile() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.myProfile().then((response) {
          if (response.statusCode == 200) {
            String _token = global.currentUser.token;
            global.currentUser = response.data;
            global.currentUser.token = _token;
            global.sp.setString(
                'currentUser', json.encode(global.currentUser.toJson()));
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }

      update();
    } catch (e) {
      print("Exception - authController.dart - getProfile():" + e.toString());
    }
  }

  Future removeUserfromDb() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.removeUserfromDb().then((response) async {
          if (response.statusCode == 200) {
            if (global.getPlatFrom()) {
              Get.offAll(
                () => BottomNavigationBarScreen(),
                routeName: 'home',
              );
            } else {
              Get.to(
                () => BottomNavigationBarScreen(
                  pageIndex: 4,
                ),
                routeName: 'profile',
              );
            }

            await logout();
            showCustomSnackBar(response.data);
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }

      update();
    } catch (e) {
      print("Exception - authController.dart - removeUserfromDb():" +
          e.toString());
    }
  }
}
