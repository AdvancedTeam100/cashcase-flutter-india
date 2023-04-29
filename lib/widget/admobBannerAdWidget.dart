import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobBannerAdWidget extends StatefulWidget {
  final String adId;
  const AdmobBannerAdWidget({Key key, this.adId}) : super(key: key);

  @override
  State<AdmobBannerAdWidget> createState() => _AdmobBannerAdWidgetState(this.adId);
}

class _AdmobBannerAdWidgetState extends State<AdmobBannerAdWidget> {
  String adId;
  BannerAd _bannerAd;
  bool isAdmobBannerAdLoaed1 = false;
  final Completer<BannerAd> bannerCompleter = Completer<BannerAd>();

  _AdmobBannerAdWidgetState(this.adId) : super();

  @override
  Widget build(BuildContext context) {
    return _bannerAd != null && isAdmobBannerAdLoaed1
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(
                  ad: _bannerAd,
                ),
              ),
            ),
          )
        : SizedBox();
  }

  @override
  void initState() {
    super.initState();
    log('AdmobBannerAdWidget');
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    if (_bannerAd != null) {
      _bannerAd.dispose();
    }
  }

  Future _init() async {
    try {
      _bannerAd = new BannerAd(
        adUnitId: adId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('$BannerAd loaded.');
            isAdmobBannerAdLoaed1 = true;
            setState(() {});
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) async {
            print('$BannerAd failedToLoad: $error');
            isAdmobBannerAdLoaed1 = false;
            await _bannerAd.load();
            setState(() {});
          },
          onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        ),
      );
      await _bannerAd.load();
    } catch (e) {
      print("Exception - AdmobBannerAdWidget.dart - _init():" + e.toString());
    }
  }
}
