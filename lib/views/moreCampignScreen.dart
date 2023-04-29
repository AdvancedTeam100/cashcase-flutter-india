import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/views/campaignDetailScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreCampignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).see_more_offers,
                      style: Get.theme.primaryTextTheme.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  shrinkWrap: true,
                  itemCount: homeController.seeMoreCampaignList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomImage(
                              image: '${global.appInfo.baseUrls.offerImageUrl}/${homeController.seeMoreCampaignList[index].image}',
                              height: global.getPlatFrom() ? 50 : 50,
                              width: global.getPlatFrom() ? 100 : 50,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    homeController.seeMoreCampaignList[index].name,
                                    textAlign: TextAlign.start,
                                    style: Get.theme.primaryTextTheme.titleSmall,
                                  ),
                                  Text(
                                    homeController.seeMoreCampaignList[index].description,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            Get.back();
                            await homeController.getCampignDetails(homeController.seeMoreCampaignList[index].id.toString());
                            Get.to(
                              () => CampaignDetailScreen(
                                campaign: homeController.campaign,
                                fromSeeMore: true,
                              ),
                              preventDuplicates: false,
                              routeName: 'detail',
                            );
                          },
                          child: Container(
                            width: Get.width / 2,
                            height: 45,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Get.theme.secondaryHeaderColor,
                                  width: 1,
                                )),
                            alignment: Alignment.center,
                            child: Text(
                              homeController.seeMoreCampaignList[index].buttonText,
                              style: TextStyle(color: Get.theme.secondaryHeaderColor, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                          height: 10,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.grey[200],
                        ),
                      ],
                    );
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       'Expires in 15 days',
                    //       style: TextStyle(
                    //         fontSize: 11,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 10),
                    //       child: Text('Earn upto 6% Cashback on all Myntra Orders + 24% Bonus Cashback (Once per user)'),
                    //     ),
                    //     Text(
                    //       'See Details',
                    //       style: TextStyle(
                    //         fontSize: 10,
                    //         color: Colors.blue,
                    //       ),
                    //     ),
                    //     Container(
                    //       width: Get.width / 2,
                    //       height: 45,
                    //       margin: EdgeInsets.only(top: 10, bottom: 10),
                    //       padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           border: Border.all(
                    //             color: Get.theme.secondaryHeaderColor,
                    //             width: 1,
                    //           )),
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         'ACTIVATE CASHBACK',
                    //         style: TextStyle(color: Get.theme.secondaryHeaderColor, fontSize: 14, fontWeight: FontWeight.w600),
                    //       ),
                    //     ),
                    //     Container(
                    //       height: 10,
                    //       margin: EdgeInsets.symmetric(vertical: 10),
                    //       color: Colors.grey[200],
                    //     ),
                    //   ],
                    // );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
