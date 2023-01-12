import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/notices_model.dart';
import '../../../widgets/configuration.dart';
import 'package:http/http.dart' as http;

class NoticeBoardController extends GetxController {
  bool isloading = false;
  List<Noticesmodel> _noticeboardItems = [];
  List<Noticesmodel> get noticeboardItems => _noticeboardItems;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  showDashboard() {
    Get.toNamed(Routes.DASHBOARD);
  }

  Future<void> getListofNotiecBoardItems() async {
    isloading = true;
    update();

    _noticeboardItems.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.notices),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _noticeboardItems.clear();
          for (var item in map['results']) {
            ////print(item);
            Noticesmodel cc = Noticesmodel.fromJson(item);
            _noticeboardItems.add(cc);
          }
          isloading = false;
          update();
        } else if (response.statusCode == 401) {
          //navigateToLogin();
        }
      } else {
        //'Please Check Your Internet Connection'

      }
    } catch (e) {
      isloading = false;
      update();
    }
    isloading = false;
    update();
  }
}
