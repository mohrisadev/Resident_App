import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:mykommunity/app/data/models/chat_model.dart';
import 'package:mykommunity/app/data/models/group_discussion_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';
import '../../../widgets/configuration.dart';

class GroupchatController extends GetxController {
  //TODO: Implement GroupchatController

  bool isloading = false;
  List<GroupDiscussionModel> _chatItems = [];
  List<GroupDiscussionModel> get chatItems => _chatItems;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  showDashboard() {
    Get.toNamed(Routes.DASHBOARD);
  }

  Future<void> getGroupChatMessages() async {
    isloading = true;
    update();

    _chatItems.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.groupchat),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _chatItems.clear();
          for (var item in map['results']) {
            ////print(item);
            GroupDiscussionModel cc = GroupDiscussionModel.fromJson(item);
            _chatItems.add(cc);
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
