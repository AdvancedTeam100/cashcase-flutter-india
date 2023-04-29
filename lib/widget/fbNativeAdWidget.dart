import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class FbNativeAdWidget extends StatelessWidget {
  final String adId;
  const FbNativeAdWidget({Key key, this.adId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FacebookNativeAd(
        placementId: adId,
        adType: NativeAdType.NATIVE_AD,
        width: double.infinity,
        height: 300,
        keepAlive: true,
        backgroundColor: Colors.blue,
        titleColor: Colors.white,
        descriptionColor: Colors.white,
        buttonColor: Colors.deepPurple,
        buttonTitleColor: Colors.white,
        buttonBorderColor: Colors.white,
        listener: (result, value) {
          print("Native Ad: $result --> $value");
        },
        keepExpandedWhileLoading: false,
      ),
    );
  }
}
