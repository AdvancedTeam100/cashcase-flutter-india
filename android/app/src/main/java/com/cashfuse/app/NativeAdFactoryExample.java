package com.cashfuse.app;

import com.cashfuse.app.R;
import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdView;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.Map;

import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;

class NativeAdFactoryExample implements GoogleMobileAdsPlugin.NativeAdFactory {

  private final Context context;

  NativeAdFactoryExample(Context context) {
    this.context = context;
  }

  @Override
  public NativeAdView createNativeAd(
          NativeAd nativeAd, Map<String, Object> customOptions) {
    NativeAdView nativeAdView = (NativeAdView) LayoutInflater.from(context)
            .inflate(R.layout.list_tile_native_ad, null);

    TextView attributionViewSmall = nativeAdView
            .findViewById(R.id.tv_list_tile_native_ad_attribution_small);
    TextView attributionViewLarge = nativeAdView
            .findViewById(R.id.tv_list_tile_native_ad_attribution_large);

    ImageView iconView = nativeAdView.findViewById(R.id.iv_list_tile_native_ad_icon);
    NativeAd.Image icon = nativeAd.getIcon();
    if (icon != null) {
      attributionViewSmall.setVisibility(View.VISIBLE);
      attributionViewLarge.setVisibility(View.INVISIBLE);
      iconView.setImageDrawable(icon.getDrawable());
    } else {
      attributionViewSmall.setVisibility(View.INVISIBLE);
      attributionViewLarge.setVisibility(View.VISIBLE);
    }
    nativeAdView.setIconView(iconView);

    TextView headlineView = nativeAdView.findViewById(R.id.tv_list_tile_native_ad_headline);
    headlineView.setText(nativeAd.getHeadline());
    nativeAdView.setHeadlineView(headlineView);

    TextView bodyView = nativeAdView.findViewById(R.id.tv_list_tile_native_ad_body);
    bodyView.setText(nativeAd.getBody());
    bodyView.setVisibility(nativeAd.getBody() != null ? View.VISIBLE : View.INVISIBLE);
    nativeAdView.setBodyView(bodyView);

    nativeAdView.setNativeAd(nativeAd);

    return nativeAdView;
  }
}