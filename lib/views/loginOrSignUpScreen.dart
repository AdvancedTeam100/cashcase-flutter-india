import 'package:cashfuse/controllers/authController.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  final bool fromMenu;
  LoginOrSignUpScreen({this.fromMenu});

  final countryPicker = FlCountryCodePicker();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        backgroundColor: Color(0xFFFEF9F3),
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
              Center(
                child: Text(
                  AppLocalizations.of(context).login,
                  style: Get.theme.primaryTextTheme.displaySmall.copyWith(
                    letterSpacing: -1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  AppLocalizations.of(context).login_subtitle,
                  style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: authController.contactNo,
                    cursorColor: Get.theme.primaryColor,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      labelText: 'Enter phone',
                      labelStyle: TextStyle(color: Colors.black),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      contentPadding: EdgeInsets.only(bottom: 5),
                      prefixIcon: InkWell(
                        onTap: () async {
                          final code = await countryPicker.showPicker(
                            context: context,
                          );
                          if (code != null) {
                            authController.coutryCode = code.dialCode;
                            authController.update();
                          }
                        },
                        child: Container(
                          width: 20,
                          alignment: Alignment.center,
                          child: Text(
                            authController.coutryCode,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Get.theme.primaryColor,
                        ),
                      ),
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
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                await authController.loginOrRegister(fromMenu);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                margin:
                    EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 15),
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
            
          ],
        ),
      );
    });
  }
}
