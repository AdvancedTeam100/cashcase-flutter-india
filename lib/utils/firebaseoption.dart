import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB29Rl1IKWA-sTP-gHvlrN7scS7hO4Mp4s",
    authDomain: "cashfuse-60939.firebaseapp.com",
    projectId: "cashfuse-60939",
    storageBucket: "cashfuse-60939.appspot.com",
    messagingSenderId: "521109211624",
    appId: "1:521109211624:web:1f3cec9c3cbbfea4c53c5d",
    measurementId: "G-KBPRBBZRYC",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCuGP6eCEJW5mGHvk4YoCOoXz6TiKxKJSM",
    authDomain: "cashfuse-60939.firebaseapp.com",
    projectId: "cashfuse-60939",
    storageBucket: "cashfuse-60939.appspot.com",
    messagingSenderId: "521109211624",
    appId: "1:521109211624:android:73898e9cbfabc8e4c53c5d",
    measurementId: "G-KBPRBBZRYC",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCuGP6eCEJW5mGHvk4YoCOoXz6TiKxKJSM",
    authDomain: "cashfuse-60939.firebaseapp.com",
    projectId: "cashfuse-60939",
    storageBucket: "cashfuse-60939.appspot.com",
    messagingSenderId: "521109211624",
    appId: "1:521109211624:android:73898e9cbfabc8e4c53c5d",
    measurementId: "G-KBPRBBZRYC",
  );
}
