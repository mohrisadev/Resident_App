import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mykommunity/app/data/models/active_flat_model.dart';
import 'package:mykommunity/app/data/models/city_image_model.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/flat_model.dart';
import '../../../data/models/new_user.dart';
import '../../../data/models/resident_type.dart';
import '../../../widgets/configuration.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  int currIndex = 0;
  int settingIndex = 0;
  final count = 0.obs;
  String greetingMessage = "";
  var bottomNavIndex = 0; //default index of a first screen
  double sc_width = 0.0;
  double sc_height = 0.0;
  final iconList = <IconData>[
    Icons.home,
    Icons.timer,
    Icons.house_outlined,
    Icons.brightness_7,
  ];
  var newUserForm = GlobalKey<FormState>();
  FocusNode? firstName;
  FocusNode? lastName;
  FocusNode? emailfc;
  String? fname, lname, eml;
  bool showCities = false;
  var preference;
  NewUser newuser = NewUser();
  bool isSearching = false;
  FocusNode inputNode = FocusNode();
  TextEditingController editingController = TextEditingController();
  TextEditingController editingCommunityController = TextEditingController();

  final pages = [
    Text("test"),
    Text("test"),
    Text("test"),
    Text("test"),
  ];
  AppState _appSate = AppState.Idle;
  AppState get appState => _appSate;

  List<dynamic> _cities = [];
  List<dynamic> get cities => _cities;
  List<dynamic> _filteredList = [];
  List<dynamic> get filteredItems => _filteredList;
  List<dynamic> _dummySearchList = [];
  List<dynamic> get dummySearchList => _filteredList;

  TextEditingController flateditingController = TextEditingController();
  TextEditingController flateditControolerRemarks = TextEditingController();

  int _resident_type_id = 1;
  String _resident_type_text = '';

  List<ResidentType> _residentTypes = [
    ResidentType(
      resident_type: "Flat Owner",
      id: 1,
    ),
    ResidentType(
      resident_type: "Renting with family",
      id: 2,
    ),
    ResidentType(
      resident_type: "Renting with other flatmates",
      id: 3,
    ),
  ];

  List<CityImageModel> _cityImageslist = [];
  List<CityImageModel> get cityImageslist => _cityImageslist;
  List<dynamic> _flats = [];
  List<dynamic> get flats => _flats;

  List<dynamic> _filteredFlatList = [];
  List<dynamic> get filteredFlatItems => _filteredFlatList;

  List<dynamic> _dummyFlatSearchList = [];
  List<dynamic> get dummyFlatsSearchList => _filteredFlatList;

  String? next_page = "";

  ScrollController scrcontroller = ScrollController();
  bool _showbottomButton = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    scrcontroller.addListener(scrollListener);
  }

  updateBottomIndex(int idx) {
    bottomNavIndex = idx;
    update();
  }

  updateFirstName(value) {
    fname = value;
    newuser.firstName = fname;
    update();
  }

  updateLastName(value) {
    lname = value;
    newuser.lastName = lname;
    update();
  }

  void setAppState(AppState state) {
    _appSate = state;
    update();
  }

  updateEmail(value) {
    eml = value;
    newuser.email = eml;
    update();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  updateIndex() {
    currIndex = currIndex == 0 ? 1 : 0;
    update();
  }

  updateSettings() {
    settingIndex = settingIndex == 0 ? 1 : 0;
    update();
  }

  // updateNavindex(int idx) {
  //   navIndex = idx;
  //   update();
  // }

  void greetings() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      greetingMessage = 'Good Morning!';
      update();
    } else if (hour >= 12 && hour < 16) {
      greetingMessage = 'Good Afternoon!';
      update();
    }
    greetingMessage = 'Good Evening!';
    update();
  }

  String getgreetingString() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Afternoon!';
    }
    return 'Good Evening!';
  }
  updateNewuser() async {
    // If the form is valid, display a Snackbar.
    preference = await SharedPreferences.getInstance();
    newuser.mobileNumber = preference.getString("phone");
    createNewUser(newuser);
  }
  Future<String> createNewUser(NewUser newuser) async {
    var preference = await SharedPreferences.getInstance();
    String token = "";
    var connectivityResult = await (Connectivity().checkConnectivity());
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var responce = await http.post(
          Uri.parse(Configuration.newUserRegistration),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(
            {
              "email":newuser.email,
              "mobileNumber":newuser.mobileNumber,
              "firstName": newuser.firstName,
              "middleName": newuser.middleName,
              "lastName": newuser.lastName
            },
          ),
        );
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          if (json.decode(responce.body)["result"]["token"]) {
            token = json.decode(responce.body)["result"]["token"];
            preference.setString(
                "token", json.decode(responce.body)["result"]["token"]);
            Get.toNamed(Routes.WAITING_FOR_APPROVAL);
          } else {
            Get.toNamed(Routes.WAITING_FOR_APPROVAL);
          }
        } else {
          Get.toNamed(Routes.WAITING_FOR_APPROVAL);
          // Fluttertoast.showToast(
          //     msg: json.decode(responce.body)["result"]["phone"],
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 2,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 18.0);

          //navigateReplacePage(page: router.SelectHomePage);
        }
      } else {
        Get.snackbar('Error', 'Please verify your internet connectivity',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {}

    return token;
  }

  getCities() {
    Future.delayed(Duration.zero).then((_) {
      setInitialValue();

      update();
    });
  }

  void setInitialValue() {
    _cities = [];
    _dummySearchList = [];
    getListofCities();
    setAppState(AppState.Idle);
    update();
  }

  Future<void> getListofCities() async {
    setAppState(AppState.Busy);
    _cities.clear();
    _filteredList.clear();
    _dummySearchList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        var response = await http.get(
          Uri.parse(Configuration.cities),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> map = json.decode(response.body);
          _cityImageslist.clear();
          _cities = map['results'];
          _dummySearchList = map['results'];
          _filteredList = map['results'];
          for (var item in map['results']) {
            String cy = item['name'].toString().trim();
            //print(cy);
            if (cy == "Bangalore" || cy == "Banglore") {
              Map<String, dynamic> json = {
                "id": item['id'],
                "name": "Bangalore",
                "image": AppConstants.appimages.bangalore
              };
              CityImageModel? c1 = CityImageModel.fromJson(json);
              _cityImageslist.add(c1);
              showCities = true;
            } else if (cy == "Delhi") {
              Map<String, dynamic> json = {
                "id": item['id'],
                "name": "Delhi",
                "image": AppConstants.appimages.delhi
              };
              CityImageModel? c1 = CityImageModel.fromJson(json);
              _cityImageslist.add(c1);
              showCities = true;
            } else if (cy == "Mumbai") {
              Map<String, dynamic> json = {
                "id": item['id'],
                "name": "Mumbai",
                "image": AppConstants.appimages.mumbai
              };
              CityImageModel? c1 = CityImageModel.fromJson(json);
              _cityImageslist.add(c1);
              showCities = true;
            } else if (cy == "Amritsar") {
              Map<String, dynamic> json = {
                "id": item['id'],
                "name": "Amritsar",
                "image": AppConstants.appimages.amritsar
              };
              CityImageModel? c1 = CityImageModel.fromJson(json);
              _cityImageslist.add(c1);
              showCities = true;
            } else if (cy == "Hyderabad") {
              Map<String, dynamic> json = {
                "id": item['id'],
                "name": "Hyderabad",
                "image": AppConstants.appimages.hyderabad
              };
              CityImageModel? c1 = CityImageModel.fromJson(json);
              _cityImageslist.add(c1);
              showCities = true;
            } else if (cy == "Ahmedabad") {
              Map<String, dynamic> json = {
                "id": item['id'],
                "name": "Ahmedabad",
                "image": AppConstants.appimages.ahmedabad
              };
              CityImageModel? c1 = CityImageModel.fromJson(json);
              _cityImageslist.add(c1);
              showCities = true;
            }
          }
        } else if (response.statusCode == 401) {}
      } else {}
    } catch (e) {
      setAppState(AppState.Idle);
    }
    setAppState(AppState.Idle);
  }
  void filterSearchResults(query) {
    List<dynamic> dummyListData = [];
    if (query.isNotEmpty) {
      dummyListData.clear();
      communities.forEach((item) {
        if (item['name']
            .toString()
            .toLowerCase()
            .contains(query.toString().toLowerCase())) {
          dummyListData.add(item);
        }
      });
      filteredItems.clear();
      filteredItems.addAll(dummyListData);
      update();
      // return;
    } else {
      resetListView();
      update();
    }
  }

  void resetListView() {
    _filteredList = [];
    filteredItems.addAll(cities);
  }

  void itemSearching() {
    isSearching = !this.isSearching;
    editingController.text = "";
    resetListView();
    update();
    isSearching ? showKeyboard() : dismissKeyboard();
    update();
  }
  void showKeyboard() {
    inputNode.requestFocus();
  }
  void dismissKeyboard() {
    inputNode.unfocus();
  }
  Future<void> updateCity(dynamic item) async {
    AppConstants.appStrings.selectedCityId = item['id'];
    AppConstants.appStrings.selectedCity = item['city'];
    var preference = await SharedPreferences.getInstance();
    preference.setString("city", item['city']);
    update();
    resetListView();
    Get.toNamed(Routes.COMMUNITIES);
  }

  //flats

  connectFlat(int flatId) async {
    setAppState(AppState.Busy);
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");

        var response = await http.post(
          Uri.parse("${Configuration.flats}$flatId/connect/"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          setAppState(AppState.Idle);
          preference.setInt("flatId", flatId);
          Get.offNamed(Routes.DASHBOARD);
          return true;
        } else if (response.statusCode == 401) {}
      } else {
        //print("Internet error");
      }
    } catch (e) {
      (AppState.Idle);
    }
    (AppState.Idle);
  }

  void filterSearchflats(query) {
    List<dynamic> dummyListdt = [];
    if (query.isNotEmpty) {
      dummyListdt.clear();
      flats.forEach((item) {
        if (item['name']
            .toString()
            .toLowerCase()
            .contains(query.toString().toLowerCase())) {
          dummyListdt.add(item);
        }
      });
      filteredFlatItems.clear();
      filteredFlatItems.addAll(dummyListdt);
      update();
      // return;
    } else {
      resetFlatsListView();
      update();
      // //print(controller.filteredItems.length);
    }
  }

  void resetFlatsListView() {
    _filteredList = [];
    //filteredFlatItems.addAll(flats);
  }

  void setInitialFlatsValue() {
    _flats = [];
    _dummyFlatSearchList = [];
    getListofFlats();
  }

  scrollListener() {
    if (scrcontroller.offset >= scrcontroller.position.maxScrollExtent &&
        !scrcontroller.position.outOfRange) {
      update();
    }
    if (scrcontroller.offset <= scrcontroller.position.minScrollExtent &&
        !scrcontroller.position.outOfRange) {
      _showbottomButton = false;
      //setState(() {});
    }
  }

  Future<void> getListofFlats() async {
    _flats.clear();
    _filteredFlatList.clear();
    _dummyFlatSearchList.clear();

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        ////print(AppConstants.appStrings.selectedCityId);
        //  print(token);
        var urlString =
            "${Configuration.flats}?block=${AppConstants.appStrings.selectedBlockId}";
        //print(urlString);

        var response = await http.get(
          Uri.parse('${Configuration.flats}?block=${AppConstants.appStrings.selectedBlockId}'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          //    //print(response.body);

          Map<String, dynamic> map = json.decode(response.body);
          // print(map['next']);

          _flats = map['results'];
          _dummyFlatSearchList = map['results'];
          _filteredFlatList = map['results'];
          next_page = map['next'];
          update();
        } else if (response.statusCode == 401) {}
      } else {}
    } catch (e) {}
  }

  flatsSearching() {
    isSearching = !isSearching;
    editingController.text = "";
    resetFlatsListView();
    update();
    isSearching ? showKeyboard() : dismissKeyboard();
    update();
  }

  updateFlatinfo(Flat flat) async {
    var preference = await SharedPreferences.getInstance();
    preference.setString("selectedflat_number", flat.name!);
    var bn = preference.getString("block_name");
    ActiveFlatModel act = ActiveFlatModel();
    act.flatId = flat.id;
    act.flatNumber = flat.name;
    act.cityId = AppConstants.appStrings.selectedCityId;
    act.cityName = AppConstants.appStrings.selectedCity;
    act.communityId = AppConstants.appStrings.selectedCommunityID;
    act.communityName = AppConstants.appStrings.selectedCommunity;
    act.blockName = bn;
    AppConstants.appStrings.selectedflatId = flat.id!;
    AppConstants.appStrings.selectedflat_number = flat.name!;
    AppConstants.activeFlat = act;
    resetFlatsListView();
    update();
    connectFlat(flat.id!);
    Get.toNamed(Routes.DASHBOARD);
    //context.read<FlatsController>().navigateReplacePage(page: router.AddFlat);
  }
  Future<void> loadMore() async {
    setAppState(AppState.Busy);
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        ////print(AppConstants.appStrings.selectedCityId);
        //print(token);
        var urlString = next_page;
        var response = await http.get(
          Uri.parse(urlString!),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          //    //print(response.body);
          next_page = "";
          Map<String, dynamic> map = json.decode(response.body);
          // print(map['next']);
          next_page = map['next'];
          _flats = map['results'];
          _dummyFlatSearchList = map['results'];
          _filteredFlatList = map['results'];
        } else if (response.statusCode == 401) {}
      } else {
        //'Please Check Your Internet Connection'
      }
    } catch (e) {
      setAppState(AppState.Idle);
    }
    setAppState(AppState.Idle);
  }
  List<dynamic> _communities = [];
  List<dynamic> get communities => _communities;
  List<dynamic> _filteredCommunityList = [];
  List<dynamic> get filteredCommunitiyItems => _filteredCommunityList;
  List<dynamic> _dummyCommunitySearchList = [];
  List<dynamic> get dummycommunityListData => filteredCommunitiyItems;

  void communitySearchfilter(query) {
    List<dynamic> dummycommunityListData = [];
    if (query.isNotEmpty) {
      dummycommunityListData.clear();
      communities.forEach((item) {
        if (item['name'].toString()
      .toLowerCase().contains(query.toString().toLowerCase())) {
        dummycommunityListData.add(item);
        }
      });
      filteredCommunitiyItems.clear();
      filteredCommunitiyItems.addAll(dummycommunityListData);
      update();
      // return;
    } else {
      resetCommunityListView();
      update();
    }
  }

  void resetCommunityListView() {
    _filteredCommunityList = [];
    filteredCommunitiyItems.addAll(communities);
  }

  updateCommunity() {
    isSearching = !isSearching;
    editingCommunityController.text = "";
    resetCommunityListView();
    isSearching ? showKeyboard() : dismissKeyboard();
    update();
  }

  setCommunity(dynamic item) async {
    AppConstants.appStrings.selectedCommunityID = item['id'];
    AppConstants.appStrings.selectedCommunity = item['name'];
    var preference = await SharedPreferences.getInstance();
    preference.setString("community", item['name']);
    preference.setInt("communityID", item['id']);
    resetCommunityListView();
    Get.toNamed(Routes.BLOCKLIST);
    // context.read<CommunitiesController>()
   // .navigateReplacePage(page: router.AddFlat);
  }
  Future<void> getListofCommunities() async {
    _communities.clear();
    _filteredCommunityList.clear();
    _dummyCommunitySearchList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");

        //print(AppConstants.appStrings.selectedCityId);
        var response = await http.get(
          Uri.parse('${Configuration.cities}${AppConstants.appStrings.selectedCityId}/communities/'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          //    //print(response.body);
          Map<String, dynamic> map = json.decode(response.body);
          _communities = map['results'];
          _dummyCommunitySearchList = map['results'];
          _filteredCommunityList = map['results'];
          update();
        } else if (response.statusCode == 401) {}
      } else {
        //'Please Check Your Internet Connection'

      }
    } catch (e) {}
  }

  getCommunities() {
    setInitialcommunityValue();
  }

  void setInitialcommunityValue() {
    _communities = [];
    _dummyCommunitySearchList = [];
    getListofCommunities();
  }

  List<dynamic> _blocks = [];
  List<dynamic> get blocks => _blocks;
  List<dynamic> _filteredBlockList = [];
  List<dynamic> get filteredblockItems => _filteredBlockList;

  // ignore: deprecated_member_use
  List<dynamic> _dummySearchblockList = [];
  List<dynamic> get dummySearchblockList => _filteredBlockList;
  TextEditingController blockCommunityController = TextEditingController();

  void setBlockInitialValue() {
    _blocks = [];
    _dummySearchblockList = [];
    getListofBlocks();
  }

  Future<void> getListofBlocks() async {
    _blocks.clear();
    _filteredList.clear();
    _dummySearchList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        ////print(AppConstants.appStrings.selectedCityId);
        var response = await http.get(
  Uri.parse('${Configuration.communities}${AppConstants.appStrings.selectedCommunityID}/blocks/'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //    //print(response.body);
          Map<String, dynamic> map = json.decode(response.body);
          _blocks = map['results'];
          _dummySearchblockList = map['results'];
          _filteredBlockList = map['results'];
          update();
        } else if (response.statusCode == 401) {}
      } else {
        //'Please Check Your Internet Connection'
      }
    } catch (e) {}
  }
  updateBlock() {
    isSearching = !this.isSearching;
    editingController.text = "";
    resetBlockListView();
    isSearching ? showKeyboard() : dismissKeyboard();
  }
  setBlock(dynamic item) async {
    AppConstants.appStrings.selectedBlockId = item['id'];
    AppConstants.appStrings.selectedBlock = item['name'];
    var preference = await SharedPreferences.getInstance();
    preference.setString("name", item['name']);
    resetBlockListView();
    Get.toNamed(Routes.ADD_FLAT);
  }
  void resetBlockListView() {
    _filteredBlockList = [];
    filteredblockItems.addAll(blocks);
  }
}
