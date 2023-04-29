import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobNativeAdWidget extends StatefulWidget {
  final String adId;
  const AdmobNativeAdWidget({Key key, this.adId}) : super(key: key);

  @override
  State<AdmobNativeAdWidget> createState() => _AdmobNativeAdWidgetState(this.adId);
}

class _AdmobNativeAdWidgetState extends State<AdmobNativeAdWidget> {
  String adId;
  NativeAd _myNativeAd;
  bool _isNativeAdLoaded = false;

  _AdmobNativeAdWidgetState(this.adId) : super();

  @override
  Widget build(BuildContext context) {
    return _myNativeAd != null && _isNativeAdLoaded
        ? Container(
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: AdWidget(
              ad: _myNativeAd,
            ),
          )
        : SizedBox();
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    super.dispose();

    if (_myNativeAd != null) {
      _myNativeAd.dispose();
    }
  }

  Future _init() async {
    try {
      final NativeAdListener listener = NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded.');
          _isNativeAdLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _isNativeAdLoaded = false;
          setState(() {});
          _myNativeAd.load();
          print('Ad failed to load$error');
        },
      );

      _myNativeAd = new NativeAd(
          adUnitId: adId,
          factoryId: 'adFactoryExample',
          request: AdRequest(),
          listener: listener,
          nativeAdOptions: NativeAdOptions(
            shouldRequestMultipleImages: true,
          ));
      _myNativeAd.load();
    } catch (e) {
      print("Exception - AdmobNativeAdWidget.dart - _init():" + e.toString());
    }
  }
}
