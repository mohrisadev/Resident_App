import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../app/widgets/configuration.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? deviceid;

  Future<void> init() async {
    const String channel_name = "mohrisa";
    //platform specific
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      channel_name,
      'High Importance Notifications from MyKommunity',
      //'This channel is used for important notifications.',
      importance: Importance.max,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notificationlogo');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, a, b, c) async {},
    );
    final MacOSInitializationSettings initializationSettingsMac =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMac);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {});

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
      }
    }

    _getId();
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

  Future<void> showLocalNotification(
      {int? id, String? title, String? body, String? payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecific =
        AndroidNotificationDetails(
      'mohrisa',
      'mohrisa',
      // 'notifications.',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecific = NotificationDetails(
      android: androidPlatformChannelSpecific,
      iOS: IOSNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(
      id!,
      title,
      body,
      platformChannelSpecific,
      payload: payload,
    );
  }
}
