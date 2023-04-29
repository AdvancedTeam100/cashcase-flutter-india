import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebAdsCampaignWidget extends StatelessWidget {
  final CommonModel commonModel;
  final bool fromWebHome;
  WebAdsCampaignWidget({this.commonModel, this.fromWebHome});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: commonModel.tagline != null ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          commonModel.tagline != null && commonModel.tagline.isNotEmpty
              ? Align(
                  alignment: Alignment.topLeft,
                  child: RotatedBox(
                    quarterTurns: -45,
                    child: ClipPath(
                      clipper: MultiplePointsClipper(Sides.bottom, heightOfPoint: 10, numberOfPoints: 1),
                      child: Container(
                        width: 20,
                        height: 135,
                        decoration: BoxDecoration(
                            color: Colors.red[600],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                            )),
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 5),
                        child: RotatedBox(
                          quarterTurns: 45,
                          child: Text(
                            commonModel.tagline,
                            textAlign: TextAlign.center,
                            style: Get.theme.primaryTextTheme.bodySmall.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          // SizedBox(
          //   height: 20,
          // ),
          CustomImage(
            image: commonModel.image,
            //height: 32,
            height: fromWebHome
                ? commonModel.tagline != null && commonModel.tagline.isNotEmpty
                    ? 80
                    : 100
                : 150,

            //width: 100,
            fit: BoxFit.contain,
            errorImage: Images.dummyImage,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              commonModel.name,
              style: Get.theme.primaryTextTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 5),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            decoration: BoxDecoration(
              color: Get.theme.secondaryHeaderColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              commonModel.buttonText != null ? commonModel.buttonText : 'Grab deal',
              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     Get.to(
          //       () => RatesAndTermScreen(
          //         commonModel: commonModel,
          //       ),
          //       transition: Transition.rightToLeft,
          //     );
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 10),
          //     //height: 20,
          //     //alignment: Alignment.center,
          //     child: Text(
          //       'Rewards Rates & Terms',
          //       textAlign: TextAlign.center,
          //       style: Get.theme.primaryTextTheme.bodySmall.copyWith(
          //         color: Colors.teal,
          //         fontSize: 10,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
