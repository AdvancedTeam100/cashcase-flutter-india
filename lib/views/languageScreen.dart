import 'package:cashfuse/controllers/localizationController.dart';
import 'package:cashfuse/l10n/l10n.dart';
import 'package:cashfuse/provider/local_provider.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context);
    var locale = provider.locale ?? Locale('en');
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          AppLocalizations.of(context).language,
          style: Get.theme.primaryTextTheme.titleSmall.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
          builder: (localizationController) {
            return ListView.builder(
                itemCount: L10n.languageListName.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                      children: [
                        RadioListTile(
                          onChanged: (val) {
                            global.languageCode = val;
                            final provider = Provider.of<LocaleProvider>(context, listen: false);
                            locale = Locale(L10n.all[index].languageCode);
                            provider.setLocale(locale);
                            global.languageCode = locale.languageCode;
                            if (global.languageCode == 'ar') {
                              global.isRTL = false;
                            } else {
                              global.isRTL = true;
                            }
                            Get.updateLocale(locale);
                          },
                          value: L10n.all[index].languageCode,
                          groupValue: global.languageCode,
                          title: Text(L10n.languageListName[index]),
                        ),
                        index != L10n.languageListName.length - 1
                            ? Divider(
                                color: Color(0xFFDFE8EF),
                              )
                            : SizedBox(),
                      ],
                    ));
          },
        ),
      ),
    );
  }
}
