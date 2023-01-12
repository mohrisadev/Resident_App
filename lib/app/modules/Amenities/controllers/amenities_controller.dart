
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:http/http.dart' as http;
import '../../../data/models/amenity_model.dart';
import '../../../data/models/visitinghelp/amenity_clubhouse_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/configuration.dart';

class AmenitiesController extends GetxController {
  List<AmenityModel> _amenitiesList = [];
  List<AmenityModel> get amenitiesList => _amenitiesList;
  List<AmenityClubModel> _amenitiesclubList = [];
  List<AmenityClubModel> get amenitiesclubList => amenitiesclubList;
  AmenityClubModel? bb;
  AmenityModel? aa;
  double sc_width = 0.0;
  double sc_height = 0.0;
  DateTime? currentDate = DateTime.now();
  DateTime? currentDate2 = DateTime.now();
  var onceStartTime = "time";
  String validhours = "pick";
  String? selectedDate;
  String validfromdate = "Select Date";
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
  void setInitialValue() {
    _amenitiesclubList = [];
    getAmenitiesClub();
  }
  @override
  void onClose() {}
  showDashboard() {
    Get.toNamed(Routes.DASHBOARD);
  }
  showDetasils(AmenityModel cc) {
    aa = cc;
    getAmenities();
    Get.toNamed(Routes.CLUBHOUSE);
  }

  Future<void> getAmenities() async {
    isLoading = true;
    _amenitiesList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.amenities),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _amenitiesList.clear();
          for (var item in map['results']) {
            //print(item);
            AmenityModel cc = AmenityModel.fromJson(item);
            _amenitiesList.add(cc);
          }
        } else if (response.statusCode == 401) {
          isLoading = false;
          update();
        }
      } else {
        //'Please Check Your Internet Connection'
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }




// Get Amenities club house
  Future<void> getAmenitiesClub() async {
    isLoading = true;
    _amenitiesclubList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.anenitiesclub),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );
        if (response.statusCode == 200) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _amenitiesclubList.clear();
          for (var item in map['results']) {
            print(item);
            AmenityClubModel bb = AmenityClubModel.fromJson(item);
            _amenitiesclubList.add(bb);
            print(bb);

          }
        } else if (response.statusCode == 401) {
          isLoading = false;
          update();
        }
      } else {
    //'Please Check Your Internet Connection'
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }
}



