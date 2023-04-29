import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class FbBannerAdWidget extends StatelessWidget {
  final String adId;
  const FbBannerAdWidget({Key key, this.adId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FacebookBannerAd(
          placementId: adId,
          bannerSize: BannerSize.STANDARD,
          keepAlive: true,
          listener: (result, value) {
            if (result == BannerAdResult.ERROR) {}
            if (result == BannerAdResult.LOGGING_IMPRESSION) {}
            if (result == BannerAdResult.LOADED) {}
          },
        ),
      ),
    );
  }
}
