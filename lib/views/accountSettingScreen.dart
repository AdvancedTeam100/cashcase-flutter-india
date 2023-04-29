// ignore_for_file: must_be_immutable

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/controllers/imageController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/widget/confirmationDialog.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/drawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingScreen extends StatelessWidget {
  final fnameFocus = new FocusNode();
  final femailFocus = new FocusNode();
  final fnumberFocus = new FocusNode();
  final cPasswordFocus = new FocusNode();
  final newPasswordFocus = new FocusNode();
  final conPasswordFocus = new FocusNode();

  AuthController authController = Get.find<AuthController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (auth) {
      return GetBuilder<ImageControlller>(builder: (imageControlller) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: global.getPlatFrom() ? DrawerWidget() : null,
          appBar: global.getPlatFrom()
              ? WebTopBarWidget(
                  scaffoldKey: scaffoldKey,
                )
              : AppBar(
                  elevation: 0,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  title: Text(
                    AppLocalizations.of(context).account_settings,
                    style: Get.theme.primaryTextTheme.titleLarge
                        .copyWith(color: Colors.white),
                  ),
                ),
          body: Center(
            child: Container(
              alignment: Alignment.topCenter,
              color: global.getPlatFrom() ? Colors.white : Colors.transparent,
              width: global.getPlatFrom()
                  ? AppConstants.WEB_MAX_WIDTH / 2
                  : AppConstants.WEB_MAX_WIDTH,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    // Container(
                    //   color: Get.theme.primaryColor,
                    //   child: TabBar(
                    //     controller: commonController.tabController,
                    //     indicatorColor: Colors.white,
                    //     labelColor: Colors.white,
                    //     unselectedLabelColor: Colors.white,
                    //     onTap: (index) => commonController.setTabIndex(index),
                    //     tabs: [
                    //       Tab(
                    //         text: 'Personal Details',
                    //       ),
                    //       Tab(
                    //         text: 'Change Password',
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // commonController.tabController.index == 0
                    //     ?

                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Get.theme.primaryColor.withOpacity(0.2),
                                width: 4,
                              ),
                            ),
                            child: imageControlller.imageFile != null &&
                                    imageControlller.imageFile.path.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: GetPlatform.isWeb
                                        ? Image.network(
                                            imageControlller.imageFile.path)
                                        : Image.file(
                                            imageControlller.imageFile,
                                            fit: BoxFit.cover,
                                            // height: 100,
                                            // width: 120,
                                          ),
                                  )
                                : global.currentUser.userImage != null &&
                                        global.currentUser.userImage.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CustomImage(
                                          image: global.appInfo.baseUrls
                                                  .userImageUrl +
                                              '/' +
                                              global.currentUser.userImage,
                                          fit: BoxFit.cover,
                                          // height: 150,
                                          // width: 150,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.blue[100],
                                        child: Icon(
                                          Icons.person,
                                          size: 50,
                                        ),
                                      ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 5,
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  CupertinoActionSheet(
                                    title: Text(
                                      AppLocalizations.of(context).select,
                                      style: Get
                                          .theme.primaryTextTheme.titleLarge
                                          .copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    actions: [
                                      InkWell(
                                        onTap: () async {
                                          Get.back();
                                          imageControlller
                                              .imageService(ImageSource.camera);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .take_picture,
                                            style: Get.theme.primaryTextTheme
                                                .titleMedium,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Get.back();
                                          imageControlller.imageService(
                                              ImageSource.gallery);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .image_from_gallery,
                                            style: Get.theme.primaryTextTheme
                                                .titleMedium,
                                          ),
                                        ),
                                      ),
                                    ],
                                    cancelButton: TextButton(
                                      child: Text(
                                        AppLocalizations.of(context).cancel,
                                        style: Get
                                            .theme.primaryTextTheme.titleMedium
                                            .copyWith(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Get.theme.secondaryHeaderColor,
                                radius: 18,
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).full_name,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          TextFormField(
                            focusNode: fnameFocus,
                            controller: authController.name,
                            scrollPadding: EdgeInsets.zero,
                            cursorColor: Get.theme.primaryColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Test User',
                              hintStyle: Get.theme.primaryTextTheme.bodySmall
                                  .copyWith(color: Colors.grey[400]),
                              focusColor: Get.theme.primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnameFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnameFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnameFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context).email_address,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            focusNode: femailFocus,
                            controller: authController.email,
                            readOnly: global.currentUser.email != null &&
                                    global.currentUser.email.isNotEmpty
                                ? true
                                : false,
                            scrollPadding: EdgeInsets.zero,
                            cursorColor: Get.theme.primaryColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'test@gmail.com',
                              hintStyle: Get.theme.primaryTextTheme.bodySmall
                                  .copyWith(color: Colors.grey[400]),
                              focusColor: Get.theme.primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: femailFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: femailFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: femailFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                            ),
                          ),
                          // Text(
                          //   'test@gmail.com',
                          //   style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 5),
                          //   child: DottedLine(
                          //     dashLength: 1,
                          //     lineThickness: 1.5,
                          //     dashGapLength: 1.5,
                          //     dashColor: Colors.grey,
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context).mobile_number,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            focusNode: fnumberFocus,
                            controller: authController.contactNo,
                            readOnly: global.currentUser.phone != null &&
                                    global.currentUser.phone.isNotEmpty
                                ? true
                                : false,
                            scrollPadding: EdgeInsets.zero,
                            cursorColor: Get.theme.primaryColor,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: '9999999999',
                              hintStyle: Get.theme.primaryTextTheme.bodySmall
                                  .copyWith(color: Colors.grey[400]),
                              focusColor: Get.theme.primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnumberFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnumberFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnumberFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 5),
                          //   child: DottedLine(
                          //     dashLength: 1,
                          //     lineThickness: 1.5,
                          //     dashGapLength: 1.5,
                          //     dashColor: Colors.grey,
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         'Receive email when I get referral earning',
                          //       ),
                          //     ),
                          //     Switch(
                          //       thumbColor: MaterialStateProperty.all(
                          //         Colors.white,
                          //       ),
                          //       value: true,
                          //       onChanged: (val) {},
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    !GetPlatform.isWeb
                        ? InkWell(
                            onTap: () {
                              showConfirmationDialog(
                                context,
                                'Delete My Account',
                                'Are you sure you want to delete Account ?',
                                [
                                  CupertinoDialogAction(
                                    child: Text(
                                      AppLocalizations.of(context).yes,
                                      style: Get
                                          .theme.primaryTextTheme.titleSmall
                                          .copyWith(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      authController.removeUserfromDb();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text(
                                      AppLocalizations.of(context).no,
                                      style: Get
                                          .theme.primaryTextTheme.titleSmall
                                          .copyWith(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Delete My Account',
                                    style: Get.theme.primaryTextTheme.bodyMedium
                                        .copyWith(
                                      letterSpacing: -0.5,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    // : SizedBox(),
                    // StatefulBuilder(
                    //     builder: (BuildContext context, StateSetter setState) => Padding(
                    //       padding: const EdgeInsets.all(20.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           TextFormField(
                    //             focusNode: cPasswordFocus,
                    //             scrollPadding: EdgeInsets.zero,
                    //             cursorColor: Get.theme.primaryColor,
                    //             decoration: InputDecoration(
                    //               contentPadding: EdgeInsets.zero,
                    //               labelText: 'Current Password',
                    //               labelStyle: TextStyle(
                    //                 color: cPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               ),
                    //               focusColor: Get.theme.primaryColor,
                    //               focusedBorder: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: cPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               border: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: cPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               enabledBorder: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: cPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               suffixIcon: Icon(
                    //                 Icons.visibility_off_rounded,
                    //                 color: Colors.grey,
                    //               ),
                    //             ),
                    //             onTap: () {
                    //               //FocusScope.of(context).unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
                    //               FocusScope.of(context).requestFocus(cPasswordFocus);
                    //               setState(() {});
                    //             },
                    //           ),
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           TextFormField(
                    //             focusNode: newPasswordFocus,
                    //             scrollPadding: EdgeInsets.zero,
                    //             cursorColor: Get.theme.primaryColor,
                    //             decoration: InputDecoration(
                    //               contentPadding: EdgeInsets.zero,
                    //               labelText: 'New Password',
                    //               labelStyle: TextStyle(
                    //                 color: newPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               ),
                    //               focusColor: Get.theme.primaryColor,
                    //               focusedBorder: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: newPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               border: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: newPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               enabledBorder: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: newPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               suffixIcon: Icon(
                    //                 Icons.visibility_off_rounded,
                    //                 color: Colors.grey,
                    //               ),
                    //             ),
                    //             onTap: () {
                    //               FocusScope.of(context).requestFocus(newPasswordFocus);
                    //               setState(() {});
                    //             },
                    //           ),
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           TextFormField(
                    //             focusNode: conPasswordFocus,
                    //             scrollPadding: EdgeInsets.zero,
                    //             cursorColor: Get.theme.primaryColor,
                    //             decoration: InputDecoration(
                    //               contentPadding: EdgeInsets.zero,
                    //               labelText: 'Confirm Password',
                    //               labelStyle: TextStyle(
                    //                 color: conPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               ),
                    //               focusColor: Get.theme.primaryColor,
                    //               focusedBorder: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: conPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               border: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: conPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               enabledBorder: UnderlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: conPasswordFocus.hasFocus ? Get.theme.primaryColor : Colors.grey,
                    //               )),
                    //               suffixIcon: Icon(
                    //                 Icons.visibility_off_rounded,
                    //                 color: Colors.grey,
                    //               ),
                    //             ),
                    //             onTap: () {
                    //               FocusScope.of(context).requestFocus(conPasswordFocus);
                    //               setState(() {});
                    //             },
                    //           ),
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   )
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  authController.updateProfile(imageControlller.imageFile);
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    width: global.getPlatFrom()
                        ? AppConstants.WEB_MAX_WIDTH / 2
                        : Get.width,
                    decoration: BoxDecoration(
                      color: Get.theme.secondaryHeaderColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).save_changes,
                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
