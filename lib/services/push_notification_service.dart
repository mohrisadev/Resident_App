import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mykommunity/services/local_notification_service.dart';
import 'package:mykommunity/shared/appconstants.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../app/widgets/configuration.dart';
import '../utils/notification_url.dart';

class PushNotificationService {
  FirebaseMessaging fcm = FirebaseMessaging.instance;
  String? deviceid;

  Future<void> askIOSPermission() async {
    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  //ios forground notification
  Future<void> iosForgroundNotification() async {
    //displya

    await fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String?> getFCMToken() async {
    return await fcm.getToken();
  }

  Future<void> getFCMTokenpair() async {
    String apiKey = AppConstants.appStrings.fcmKeypair;

    String? _fcmToken =
        await FirebaseMessaging.instance.getToken(vapidKey: apiKey);

    if (Platform.isIOS) {
      NotificationSettings settings = await fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      ////print('User granted permission: ${settings.authorizationStatus}');
    }
  }

  //get initial message
  Future<void> getInitialMessage() async {
    await fcm.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        RemoteNotification? notification = message.notification;

        LocalNotificationService().showLocalNotification(
          id: notification.hashCode,
          title: notification!.title,
          body: notification.body,
        );
      }
    });
  }

  Future<void> initialise() async {
    _getId();

    _registerOnFirebase();

    fcm.requestPermission();

    fcm.setAutoInitEnabled(true);

    fcm.getToken().then((value) {
      updateFirebaseDeviceInfo(fcmToken: value!);
    });
  }

  _registerOnFirebase() {
    fcm.subscribeToTopic('all');

    fcm.getAPNSToken().then((token) => print(token));
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceid = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceid = androidDeviceInfo.androidId;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  Future<void> updateFirebaseDeviceInfo({String? fcmToken}) async {
    var device_type, device_name, device_os;

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;

      device_type = 'android';
      device_os = 'android ${androidInfo.version.release}';
      device_name = '${androidInfo.manufacturer} - ${androidInfo.model}';

      ////print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      device_type = iosInfo.systemName.toLowerCase();
      device_os = '$device_type ${iosInfo.systemVersion}';
      device_name = '${iosInfo.name}  ${iosInfo.model}';

      ////print('$systemName $version, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone
    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");

// //print("device_type:$device_type device_name: $device_name device_id:"" device_token:$fcmToken device_os:$device_os");

        //print(deviceid);
        var response = await http.post(
          Uri.parse(Configuration.apiurl + "devices/"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token $token",
          },

          //try to fectch the device id,,,check with android 10 and ios..

          body: json.encode({
            "device_type": device_type,
            "device_name": device_name,
            "device_id": deviceid,
            "device_token": fcmToken,
            "device_os": device_os
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
        } else if (response.statusCode == 401) {}
      }
    } catch (e) {
      //print(e);
    }
  }

  //on message
  Future<void> onMessage({RemoteMessage? message}) async {
    _serialiseAndNavigate(message!.data);

    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification.android;
    //   if (notification != null && android != null) {
    //   if (android != null) {
    //   LocalNotificationService().showLocalNotification(
    //     id: notification.hashCode,
    //     titel: notification.title,
    //     body: notification.body,
    //   );
    // }
    //   RemoteNotification notification = message.
    //   LocalNotificationService().showLocalNotification(
    //     id: notification.hashCode,
    //     titel: notification.title,
    //     body: notification.body,
    //   );
    
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = json.decode(message['data']);
    var msgtype = message['type'];

    // print(message);
 
    // print(notificationData['name']);

    // print(json.decode(message['data']));

    // var body = JSON.stringify(notificationData);

    String title = "";
    String body = "";
    int entry_id;

    if (msgtype.toString().toLowerCase() == "visitor_entry") {
      title = "Visitor Entry";
      body =
          "${notificationData['name']} - ${notificationData['company']}\n${notificationData['phone']}";

      entry_id = int.parse(notificationData['entry'].toString().trim());
      showNotificationWithIconsAndActionButtons(entry_id, title, body);
    }

    //showBasicNotification(1,title,body);
    // LocalNotificationService().showLocalNotification(
    //   id: notificationData.hashCode,
    //   titel: title,
    //   body: body,
    // );
  }
}
