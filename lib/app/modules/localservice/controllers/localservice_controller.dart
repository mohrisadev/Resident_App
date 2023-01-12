import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/AttendaceHisotryModel.dart';
import '../../../data/models/local_service_model.dart';
import '../../../data/models/localservice_category.dart';
import '../../../data/models/localservice_details_model.dart';
import '../../../data/models/payment_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/configuration.dart';
import 'package:http/http.dart' as http;

class LocalserviceController extends GetxController {
  List<LocalServiceModal> _localService = [];
  List<LocalServiceModal> get localservices => _localService;
  List<LocalServiceModal> _householdLocalService = [];
  List<LocalServiceModal> get houseHoldlocalservices => _householdLocalService;
  LocalServiceDetailedModal lsmDetails = new LocalServiceDetailedModal();
  int? selectedServantId;
  int? amountTobePaid;
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  List<LocalServiceModal> _myDailyHelp = [];
  List<LocalServiceModal> get myDailyHelp => _myDailyHelp;
  List<AttendanceHistoryModal> _attadanceHistoryList = [];
  List<AttendanceHistoryModal> get attadanceHistoryList => _attadanceHistoryList;

  List<PaymentModal> _paymentHistoryList = [];
  List<PaymentModal> get paymentHistoryList => _paymentHistoryList;

  List<LocalServiceCategory> _localServiceCategoryList = [];
  List<LocalServiceCategory> get localServiceCategoryList => _localServiceCategoryList;

  String paymentRemarks = "";
  String modeofPayment = "";

  int? selectedCategoryId;
  LocalServiceCategory? slsc;
  LocalServiceModal? selectedServant;

  bool isloading = false;

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

  Future<void> getLocalService() async {
    isloading = true;

    _localService.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        print(token);
        print(flatid);
        var response = await http.get(
          Uri.parse(Configuration.localServices),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //Map<dynamic, dynamic> map = json.decode(response.body)["results"];

          _localService.clear();
          for (var item in json.decode(response.body)["results"]) {
            ////print(item);
            LocalServiceModal cc = LocalServiceModal.fromJson(item);
            if (slsc!.id == cc.categoryId) {
              _localService.add(cc);
            }
          }
          isloading = false;
          update();
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
          isloading = false;
          update();
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

  void getMyDailyHelp() {
    _myDailyHelp = [];
    _localServiceCategoryList = [];
    _householdLocalService = [];
    fetchMyDailyHelpList();

    update();
  }

  Future<void> fetchMyDailyHelpList() async {
    isloading = false;
    update();
    _myDailyHelp.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        //print(token);
        //print(flatid);
        var response = await http.get(
          Uri.parse(Configuration.householdLocalServices),
          // Uri.parse(Configuration.localServices),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _myDailyHelp.clear();
          for (var item in map['results']) {
            ////print(item);
            LocalServiceModal cc = LocalServiceModal.fromJson(item);
            _myDailyHelp.add(cc);
          }
          update();
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
          isloading = false;
          update();
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

  Future<void> getLocalServiceCategoriesList() async {
    isloading = true;
    //update(); ////
    _localServiceCategoryList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        //print(token);
        //print(flatid);
        var response = await http.get(
          Uri.parse(Configuration.localServicesCategories),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _localServiceCategoryList.clear();
          for (var item in map['results']) {
            ////print(item);
            LocalServiceCategory cc = LocalServiceCategory.fromJson(item);
            _localServiceCategoryList.add(cc);
          }
          isloading = false;
          update();
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);

          isloading = false;
          update();
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

  //get servant details
  Future<void> get_lsm_details() async {
    isloading = true;

    var preference = await SharedPreferences.getInstance();
    var connectivityResult = await (Connectivity().checkConnectivity());

    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse("${Configuration.localServices}${selectedServant!.id!}/"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          lsmDetails =
              LocalServiceDetailedModal.fromJson(jsonDecode(response.body));
          isloading = false;
          update();
        } else if (response.statusCode == 401) {}
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

  Future<void> addtoHouseHold() async {
    isloading = true;
    update();
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    // var newComment = {
    //   "comment": commenetsString,
    //   "photos": uploadedImageRefIds
    // };

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString =
            "${Configuration.localServices}${selectedServant!.id}/add_to_household/";
        var response = await http.post(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //navigateReplacePage(page: router.LocalServiceDetails);
          Get.toNamed(Routes.LOCAL_SERVANT_DETAILS);
          //Get.toNamed(Routes.LOCALSERVICE_DETAILS);

          isloading = false;
          update();
        } else if (response.statusCode == 401) {
          isloading = false;
          update();
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {
      isloading = false;
      update();
    }
    isloading = false;
    update();
  }

  Future<void> removeFromHouseHold() async {
    isloading = true;
    update();
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    // var newComment = {
    //   "comment": commenetsString,
    //   "photos": uploadedImageRefIds
    // };

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString =
            "${Configuration.localServices}${selectedServant!.id}/remove_from_household/";

        var response = await http.post(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //return to list of complaints
          isloading = false;
          Get.toNamed(Routes.LOCAL_SERVANT_DETAILS);
        } else if (response.statusCode == 401) {
          isloading = false;
          update();
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {
      isloading = false;
      update();
    }
    isloading = false;
    update();
  }

  showDashboard() {
    Get.toNamed(Routes.DASHBOARD);
  }

  goback() {
    Get.back();
  }

  showServicePeople(LocalServiceCategory lsm) {
    slsc = lsm;
    Get.toNamed(Routes.LOCALSERVICE);
  }

  showServantDetails(LocalServiceModal sl) {
    selectedServant = sl;
    update();
    Get.toNamed(Routes.LOCAL_SERVANT_DETAILS);
  }
}
