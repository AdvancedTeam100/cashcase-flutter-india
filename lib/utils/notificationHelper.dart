// ignore_for_file: empty_catches, missing_return

import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:cashfuse/utils/global.dart' as global;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    try {
      AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('ic_launcher');
      DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
          defaultPresentBadge: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          defaultPresentSound: true,
          onDidReceiveLocalNotification: (
            int id,
            String title,
            String body,
            String payload,
          ) async {
            return null;
          });
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onSelectNotification);
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showNotification(message);
        //Get.find<NotificationController>().getNotificationList();
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("onOpenApp: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
        try {
          if (message.notification.titleLocKey != null && message.notification.titleLocKey.isNotEmpty) {
            // Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(message.notification.titleLocKey)));
            // Get.to(() => OrderDetailsScreen(
            //       orderId: int.parse(message.notification.titleLocKey),
            //       orderModel: null,
            //     ));
          } else {
            // Get.to(() => NotificationScreen());
          }
        } catch (e) {}
      });
    } catch (e) {
      log("Exception - NotificationHelper.dart  -  initialize():" + e.toString());
    }
  }

  static Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    try {
      if (message != null && message.data != null) {
        Firebase.initializeApp();
        log("background");
        //global.notificationModel = NotificationModel.fromJson(message.data);
      }
    } catch (e) {
      log("Exception - NotificationHelper.dart  -  _firebaseMessagingBackgroundHandler():" + e.toString());
    }
  }

  static Future onSelectNotification(NotificationResponse payload) async {
    try {
      if (payload != null && payload.payload.isNotEmpty) {
        // Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));

      } else {
        //Get.to(() => NotificationScreen());
      }
    } catch (e) {
      log("Exception - NotificationHelper.dart  -  onSelectNotification():" + e.toString());
    }
  }

  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/$fileName';
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      log("Exception - NotificationHelper.dart  -  downloadAndSaveFile():" + e.toString());
    }
  }

  static Future showNotification(RemoteMessage message) async {
    try {
      if (!GetPlatform.isIOS) {
        String _title;
        String _body;
        String _orderID;
        String _image;
        // if (message.data != null ) {
        //   _title = message.data['title'];
        //   _body = message.data['body'];
        //   _orderID = message.data['order_id'];
        //   _image = (message.data['image'] != null && message.data['image'].isNotEmpty)
        //       ? message.data['image'].startsWith('http')
        //           ? message.data['image']
        //           : '${global.baseUrl}/storage/app/public/notification/${message.data['image']}'
        //       : null;
        // } else {
        _title = message.notification.title;
        _body = message.notification.body;
        _orderID = message.notification.titleLocKey;
        if (GetPlatform.isAndroid) {
          _image = (message.notification.android.imageUrl != null && message.notification.android.imageUrl.isNotEmpty)
              ? message.notification.android.imageUrl.startsWith('http')
                  ? message.notification.android.imageUrl
                  : '${global.baseUrl}/storage/app/public/notification/${message.notification.android.imageUrl}'
              : null;
        } else if (GetPlatform.isIOS) {
          _image = (message.notification.apple.imageUrl != null && message.notification.apple.imageUrl.isNotEmpty)
              ? message.notification.apple.imageUrl.startsWith('http')
                  ? message.notification.apple.imageUrl
                  : '${global.baseUrl}/storage/app/public/notification/${message.notification.apple.imageUrl}'
              : null;
        }
        //}

        if (_image != null && _image.isNotEmpty) {
          try {
            await showBigPictureNotificationHiddenLargeIcon(_title, _body, _orderID, _image, flutterLocalNotificationsPlugin);
          } catch (e) {
            await showBigTextNotification(_title, _body, _orderID, flutterLocalNotificationsPlugin);
          }
        } else {
          await showBigTextNotification(_title, _body, _orderID, flutterLocalNotificationsPlugin);
        }
      }
    } catch (e) {
      log("Exception - NotificationHelper.dart  -  showNotification():" + e.toString());
    }
  }

  static Future<void> showTextNotification(String title, String body, String orderID, FlutterLocalNotificationsPlugin fln) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      global.appName,
      global.appName,
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      //sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigTextNotification(String title, String body, String orderID, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      global.appName,
      global.appName,
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String orderID, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      global.appName,
      global.appName,
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }
}
