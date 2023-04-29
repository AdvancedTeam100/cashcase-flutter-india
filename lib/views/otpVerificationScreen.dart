import 'package:cashfuse/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String verificationCode;
  final bool fromMenu;

  OtpVerificationScreen({this.verificationCode, this.fromMenu});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        backgroundColor: Color(0xffFEF9F3),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  AppLocalizations.of(context).otp_title,
                  textAlign: TextAlign.left,
                  style: Get.theme.primaryTextTheme.displaySmall.copyWith(
                    height: 1.2,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      authController.contactNo.text != null &&
                              authController.contactNo.text.isNotEmpty
                          ? '${AppLocalizations.of(context).otp_subtitle} ${authController.coutryCode} ${authController.contactNo.text}'
                          : '${AppLocalizations.of(context).otp_subtitle} ${authController.email.text}',
                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: global.getPlatFrom()
                    ? EdgeInsets.symmetric(horizontal: 30)
                    : const EdgeInsets.only(
                        top: 20, left: 20, bottom: 10, right: 20),
                child: SizedBox(
                  child: PinCodeTextField(
                    enablePinAutofill: true,
                    controller: authController.otp,
                    appContext: context,
                    length: 6,
                    onChanged: (code) async {
                      if (code.length == 6) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (authController.contactNo.text != null &&
                            authController.contactNo.text.isNotEmpty) {
                          await authController.checkOTP(
                              verificationCode, fromMenu);
                        } else {
                          await authController.verifyEmail(fromMenu);
                        }
                      }
                    },
                    scrollPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.transparent,
                    pinTheme: PinTheme(
                      fieldHeight: 50,
                      fieldWidth: 50,
                      fieldOuterPadding: EdgeInsets.zero,
                      disabledColor: Colors.white,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderWidth: 1.5,
                      shape: PinCodeFieldShape.box,
                      inactiveColor: Colors.grey[350],
                      activeColor: Colors.black,
                      selectedColor: Colors.grey[350],
                    ),
                  ),
                ),
              ),
              authController.seconds != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Wait 00 : ${authController.seconds}",
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        if (authController.contactNo != null &&
                            authController.contactNo.text.isNotEmpty) {
                          await authController.resendOtp();
                        } else {
                          await authController.sendEmail(fromMenu);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context).otp_not_receive,
                            style:
                                Get.theme.primaryTextTheme.titleSmall.copyWith(
                              letterSpacing: -0.2,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ${AppLocalizations.of(context).resend}',
                                style: Get.theme.primaryTextTheme.titleSmall
                                    .copyWith(
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () async {
            if (authController.contactNo.text != null &&
                authController.contactNo.text.isNotEmpty) {
              await authController.checkOTP(verificationCode, fromMenu);
            } else {
              await authController.verifyEmail(fromMenu);
            }
          },
          child: Container(
            width: Get.width,
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            decoration: BoxDecoration(
              color: Get.theme.secondaryHeaderColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context).conti,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    });
  }
}
