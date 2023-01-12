import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mykommunity/app/data/models/NotesToGuard/NotesToGuardModel.dart';
import 'package:mykommunity/app/data/models/bottom_menu_items_model.dart';
import 'package:mykommunity/app/data/models/buttons_model.dart';
import 'package:mykommunity/app/data/models/quick_activity_model.dart';
import 'package:mykommunity/app/data/models/sos/sos_categories_model.dart';
import 'package:mykommunity/app/data/models/sos_alerts_model.dart';
import 'package:mykommunity/app/data/models/user_profile_model.dart';
import 'package:mykommunity/app/data/models/visitinghelp/visiting_help_categories_model.dart';
import 'package:mykommunity/app/modules/dashboard/views/house_hold_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/activities_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/community_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/home_view.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/app/widgets/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/AttendaceHisotryModel.dart';
import '../../../data/models/activities_model.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/advertisement_model.dart';
import '../../../data/models/allow_cab_once.dart';
import '../../../data/models/delivery/allow_delivery_once.dart';
import '../../../data/models/guests/pre_approved_guest_model.dart';
import '../../../data/models/local_service_model.dart';
import '../../../data/models/newImage.dart';
import '../../../data/models/new_resident_model.dart';
import '../../../data/models/new_user.dart';
import '../../../data/models/notices_model.dart';
import 'package:intl/intl.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/models/residents_model.dart';
import '../../../data/models/vehicle_log_model.dart';
import '../../../data/models/vehicle_model.dart';
import '../../../data/models/visitinghelp/visiting_help_once_model.dart';

class DashboardController extends GetxController {
  Iterable<Contact>? contacts = [];
  int selectedVisitorTypeID = 0;
  bool? isrecentActivitesLoading = true;
  bool? isrecentNoticesLoading = true;
  bool loadingContacts = false;
  bool loadingAdvertisements = false;
  final count = 0.obs;
  int currIndex = 0;
  int settingIndex = 0;
  double sc_width = 0.0;
  double sc_height = 0.0;
  int navIndex = 0;
  int displayCountdown = 5;
  UserProfileModel? userProfile;
  NewImage? NewProfileImage;

  List<String> role = ["Family", "Tenant"];

  String greetingMessage = "";
  String selectedRole = "Select Role";
  String selectedOccupancyStatus = "Occupancy Status";
  final newCompanyController = TextEditingController();
  final autoSizeGroup = AutoSizeGroup();
  var bottomNavIndex = 0; //default index of a first screen

  final iconList = <IconData>[
    Icons.home, Icons.timer,
    Icons.house_outlined,
    Icons.brightness_7,
  ];

  int? onceValidFor;
  var vehicleNo;
  List<MenuItemsModel> bottomMenuItems = [
    MenuItemsModel(icon: Icons.home, label: "Home", action: HomeView()),
    MenuItemsModel(
        icon: Icons.access_time, label: "Activity", action: HomeView()),
    MenuItemsModel(icon: Icons.people_alt_outlined,
        label: "Household",
        action: HomeView()),
    MenuItemsModel(
        icon: Icons.apartment_outlined, label: "Community", action: HomeView()),
  ];

  String counterImage = AppConstants.appimages.three;
  List<ButtonsModel> homepagebuttons = [
    ButtonsModel(
        id: 1,
        label: "Add Daily\nHelp",
        icon: AppConstants.appimages.adddailyhelpbtn,
        actionUrl: Routes.HELPDESK),

    // ButtonsModel(
    //     id: 2,
    //     label: "Pre-Approved\n",
    //     icon: AppConstants.appimages.preapprovebtn,
    //     actionUrl: Routes.HELPDESK),

  ];

  // //this diffrent from the actual model
  // List<AdvertisementsModel> advertisementsList = [
  //   AdvertisementsModel(
  //       sort_order: 1,
  //       imageurl:
  //           "https://www.mensjournal.com/wp-content/uploads/2022/04/enfieldmain.jpg?w=1400&quality=86&strip=all",
  //       label: "Home",
  //       action: HomeView()),
  //   AdvertisementsModel(
  //       sort_order: 2,
  //       imageurl:
  //           "https://www.voicendata.com/wp-content/uploads/2020/06/Amazon-expands-its-Pantry-service-to-over-300-cities-in-India-800x420.jpg",
  //       label: "Activity",
  //       action: HomeView()),
  //   AdvertisementsModel(
  //       sort_order: 3,
  //       imageurl:
  //           "https://content.jdmagicbox.com/comp/hyderabad/b3/040pxx40.xx40.171010195741.r8b3/catalogue/uber-cab-attachment-office-chanda-nagar-hyderabad-ola-cab-attachment-services-0jojtwyqm8.jpeg?clr=",
  //       label: "Household",
  //       action: HomeView()),
  // ];

  List<SosCategoriesModel> sosCategoriesList = [
    SosCategoriesModel(
        id: 1,
        dbcode: "FIRE_GAS_LEAK",
        category: "FIRE / GAS LEAKAGE\nEMERGENCY",
        imageUrl: AppConstants.appimages.fire),
    SosCategoriesModel(
        id: 2,
        dbcode: "MEDICAL",
        category: "MEDICAL EMERGENCY",
        imageUrl: AppConstants.appimages.medical),
    SosCategoriesModel(
        id: 3,
        dbcode: "LIFT",
        category: "LIFT EMERGENCY",
        imageUrl: AppConstants.appimages.lift),
    SosCategoriesModel(
        id: 4,
        dbcode: "THEFT",
        category: "THEFT / OTHER EMERGENCY",
        imageUrl: AppConstants.appimages.thief),
    SosCategoriesModel(
        id: 5,
        dbcode: "OTHER_EMERGENCY",
        category: "OTHER EMERGENCY",
        imageUrl: AppConstants.appimages.other),
  ];

  List<QuickActivityModel> quickActiveMenus = [
    QuickActivityModel(
        visitorCode: 1,
        imageurl: AppConstants.appimages.visitorpng,
        label: "PRE-APPROVED\nGUESTS",
        actionType: "GUEST",
        actionUrl: Routes.DASHBOARD),
    QuickActivityModel(
        visitorCode: 2,
        imageurl: AppConstants.appimages.cabpng,
        label: "PRE-APPROVED\nCAB",
        actionType: "CAB",
        actionUrl: Routes.DASHBOARD),
    QuickActivityModel(
        visitorCode: 3,
        imageurl: AppConstants.appimages.deliverypng,
        label: "PRE-APPROVED\nDELIVERY",
        actionType: "DELIVERY",
        actionUrl: Routes.DASHBOARD),
    QuickActivityModel(
        visitorCode: 4,
        imageurl: AppConstants.appimages.visitinghelp,
        label: "PRE-APPROVED\nVISITING HELP",
        actionUrl: Routes.DASHBOARD),
    QuickActivityModel(
        visitorCode: 5,
        imageurl: AppConstants.appimages.notetoguard,
        label: "NOTES TO\nGUARD",
        actionType: "NOTES",
        actionUrl: Routes.DASHBOARD),
    QuickActivityModel(
        visitorCode: 6,
        imageurl: AppConstants.appimages.sos,
        label: "SOS / EMERGENCY\nALERTS",
        actionType: "ALERT",
        actionUrl: Routes.DASHBOARD),
  ];

  QuickActivityModel? selectedVisitorTypeOnce;
  QuickActivityModel? selectedVisitorTypeFrequent;
  bool leavePackageAtGate = false;
  List<QuickActivityModel> communityScreenMenus = [
    QuickActivityModel(
        visitorCode: 1,
        imageurl: AppConstants.appimages.helpdesk,
        label: "HELP-DESK\n& SUPPORT",
        actionType: "",
        actionUrl: Routes.HELPDESK),
    QuickActivityModel(
        visitorCode: 2,
        imageurl: AppConstants.appimages.directory,
        label: "RESIDENT\nDIRECTORY",
        actionType: "",
        actionUrl: Routes.RESIDENTS),
    QuickActivityModel(
        visitorCode: 3,
        imageurl: AppConstants.appimages.emergency,
        label: "EMERGENCY\nNUMBER",
        actionType: "",
        actionUrl: Routes.EMERGENCYNUMBERS),
    QuickActivityModel(
        visitorCode: 4,
        imageurl: AppConstants.appimages.localservice,
        label: "LOCAL\nSERVICES",
        actionUrl: Routes.LOCALSERVICE_CATEGORIES),
    QuickActivityModel(
        visitorCode: 5,
        imageurl: AppConstants.appimages.noticeboard,
        label: "NOTICE\nBOARD",
        actionType: "",
        actionUrl: Routes.NOTICE_BOARD),
    QuickActivityModel(
        visitorCode: 6,
        imageurl: AppConstants.appimages.groupchat,
        label: "GROUP\nCHATS",
        actionType: "",
        actionUrl: Routes.GROUPCHAT),
    QuickActivityModel(
        visitorCode: 7,
        imageurl: AppConstants.appimages.utilitypayments,
        label: "UTILITIES &\nPAYMENTS",
        actionType: "",
        actionUrl: Routes.PAYMENTS),
    QuickActivityModel(
        visitorCode: 8,
        imageurl: AppConstants.appimages.residentamenities,
        label: "RESIDENT\nAMENITIES",
        actionType: "",
        actionUrl: Routes.SELECTAMENITIES
      // actionUrl: Routes.AMENITIES
    ),
  ];
  QuickActivityModel newResident = QuickActivityModel(
      visitorCode: 10,
      imageurl: AppConstants.appimages.contacts,
      label: "RESIDENT\nAMENITIES",
      actionType: "",
      actionUrl: Routes.GET_CONTACTS);

  FocusNode inputNode = FocusNode();

  var _newUserForm = GlobalKey<FormState>();
  NewUser newUser = new NewUser();

  final txtmsgController = TextEditingController();
  FocusNode? _firstName;
  FocusNode? _lastName;
  FocusNode? _email;
  FocusNode? _mobilenumber;
  bool isValidEmail = true;
  NewUser newuser = new NewUser();
  String? selectedDeliveryVendor = "Vendor Name";

  final pages = [
    HomeView(),
    HomeView(),
    HomeView(),
    HomeView(),
  ];

  bool? notificationSetting;
  List<String> cabcompanies = ["UBER", "MERU", "OLA"];
  List<String> vechicleTypes = ["Two Wheeler", "Four Wheeler"];
  String? selectedVechileType;
  List<String> deliverycompanies = [
    "Amazon",
    "Bharat Gas",
    "Big Basket",
    "DHL",
    "DTDC",
    "Flipkart",
    "Food Panda",
    "Uber Eats",
    "ZOMOTO"
  ];
  String? occupancyStatus = "Occupancy Status";
  List<String> occupancyStatusList = [
    "Vacant",
    "Letout",
    "Residing",
    "Tenant Family",
    "Flatmate"
  ];
  List<VisitingHelpCategoriesmodel> visitingHelpCategories = [];
  int? visitingHelpId;
  String selectedCategory = "Select Category";
  String selectedCompany = "Company Name";
  List<ActivitiesModel> _activities = [];

  List<ActivitiesModel> get activities => _activities;
  List<AdvertisementModel> _advertisementsList = [];

  List<AdvertisementModel> get advertisementsList => _advertisementsList;
  List<Noticesmodel> _noticeboardItems = [];

  List<Noticesmodel> get noticeboardItems => _noticeboardItems;

  //Guest one time
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  String? errMsg;
  String validfromdate = "Select Date";
  int? onceValidForinHrs;

  DateTime? currentDate = DateTime.now();
  DateTime? currentDate2 = DateTime.now();
  DateTime? targetDateTime = DateTime.now();
  String? selectedDate;
  var onceStartTime = "time";
  String validhours = "pick";
  int? selectedCabCompnayIndex;
  int? selectedDeliveryCompnayIndex;
  int? selectedVisitingHelpIndex;
  double astart = 0.75;
  double aend = 1.0;
  double bstart = 1.0;
  double bend = 0.75;
  String activeIconstring = 'icon1';
  List<String> hours = [
    "1 Hour",
    "2 Hours",
    "4 Hours",
    "8 Hours",
    "12 Hours",
    "24 Hours"
  ];
  AppState _appSate = AppState.Idle;

  AppState get appState => _appSate;
  List<Residentsmodel> _residents = [];

  List<Residentsmodel> get residents => _residents;
  bool isLoading = false;

//vehicle images
  List<Vehiclemodel> _vechiles = [];

  List<Vehiclemodel> get vechiles => _vechiles;
  List<VehicleLogModal> _vechileLog = [];

  List<VehicleLogModal> get vechileLog => _vechileLog;
  List<AttendanceHistoryModal> _attadanceHistoryList = [];

  List<AttendanceHistoryModal> get attadanceHistoryList =>
      _attadanceHistoryList;
  List<PaymentModal> _paymentHistoryList = [];

  List<PaymentModal> get paymentHistoryList => _paymentHistoryList;
  List<int> _uploadedIamgeRefIds = [];

  List<int> get uploadedImageRefIds => _uploadedIamgeRefIds;
  List<String> _uploadedIamgeRefUrls = [];

  List<String> get uploadedIamgeRefUrls => _uploadedIamgeRefUrls;
  Vehiclemodel? myVehicle;
  int selectedVehicleID = 0;
  int newVehicleType = 0;
  TextEditingController controllerVehicleName = TextEditingController();
  TextEditingController controllerVehicleNumber = TextEditingController();
  List<LocalServiceModal> _myDailyHelp = [];

  List<LocalServiceModal> get myDailyHelp => _myDailyHelp;
  List<NoteToGuardModel> _notestoGuardList = [];

  List<NoteToGuardModel> get notestoGuardList => _notestoGuardList;
  int? selectedServantId;
  bool selectedOptIn = true;
  bool isloading = true;
  LocalServiceModal? lsm;
  int? amountTobePaid;
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String paymentRemarks = "";
  List<String> paymentOptions = ["Cash", "Online"];
  int choiceIndex = 0;
  String modeofPayment = "Cash";
  String? block, community, flatId, selectedflat_number, city, resident_type;
  bool emojiShowing = false;
  SosCategoriesModel? selectedSOScategory;
  List<SosAlertsModel> _sosAlertsList = [];

  List<SosAlertsModel> get sosAlertsList => _sosAlertsList;

  @override
  void onInit() {
    super.onInit();
    getListofActivities();
    getListofNotiecBoardItems();
    getAdvertisements();
    autoConnect();
    getVechlesList();
    getVehicleLogHistry();
    getUserProfile();
  }

  updateSOSCategory(SosCategoriesModel am) {
    selectedSOScategory = am;
    Get.toNamed(Routes.SOSCOUNTDOWN);
  }

  // getActiveResidentDetails() async {
  //   isloading = true;

  //   var preference = await SharedPreferences.getInstance();
  //   block = preference.getString("block");
  //   community = preference.getString("community");
  //   city = preference.getString("city");
  //   resident_type = preference.getString("resident_type");
  //   selectedflat_number = preference.getString("selectedflat_number");
  //   isloading = false;
  //   update();
  // }

  @override
  void onReady() {
    super.onReady();
    getListofCategories();
  }

  @override
  void onClose() {
    super.onClose();
  }

  updateLSM(lm) {
    lsm = lm;
    update();
  }

  selectVechileType(String str) {
    selectedVechileType = str;
    if (str.contains("2")) {
      newVehicleType = 2;
    } else {
      newVehicleType = 4;
    }

    update();
    Get.back();
    Get.toNamed(Routes.NEW_VEHICLE);
  }

  updatePaymentoption(int idx) {
    modeofPayment = paymentOptions[idx];
    choiceIndex = idx;
    update();
  }

  autoConnect() async {
    try {
      var flatId = AppConstants.activeFlat!.flatId;
      var flatNumber = AppConstants.activeFlat!.flatNumber;
      AppConstants.appStrings.selectedflatId = flatId!;
      AppConstants.appStrings.selectedflat_number = flatNumber!;
      getListofReidents();
      fetchMyDailyHelpList();
      //}
    } catch (e) {
      //getListofReidents();
      isLoading = false;
      update();
    }
  }

  Future<void> getNotesToguard() async {
    _notestoGuardList.clear();
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
          Uri.parse(Configuration.notestoGuard),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _notestoGuardList.clear();
          // print(map['results']);

          for (var item in map['results']) {
            ////print(item);
            NoteToGuardModel cc = NoteToGuardModel.fromJson(item);
            _notestoGuardList.add(cc);
          }
          _notestoGuardList.sort((a, b) => b.id!.compareTo(a.id!));
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
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

  Future<void> getListofReidents() async {
    _residents.clear();
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
          Uri.parse(Configuration.residences),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _residents.clear();

          for (var item in map['results']) {
            ////print(item);
            Residentsmodel cc = Residentsmodel.fromJson(item);
            _residents.add(cc);
          }
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
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

  Future<void> getSOSAlerts() async {
    isLoading = true;
    _sosAlertsList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.sosalerts),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //print(response.body);
          Map<dynamic, dynamic> map = json.decode(response.body);
          _sosAlertsList.clear();
          for (var item in map['results']) {
            ////print(item);
            SosAlertsModel cc = SosAlertsModel.fromJson(item);
            _sosAlertsList.add(cc);
          }
          _sosAlertsList.sort((a, b) => b.id!.compareTo(a.id!));
          isLoading = false;
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
          isLoading = false;
          update();
        }
      } else {
        //'Please Check Your Internet Connection'
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  Future<void> getVechlesList() async {
    isLoading = true;
    update();
    _vechiles.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.vehicles),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //print(response.body);
          Map<dynamic, dynamic> map = json.decode(response.body);
          _vechiles.clear();
          for (var item in map['results']) {
            ////print(item);
            Vehiclemodel cc = Vehiclemodel.fromJson(item);
            _vechiles.add(cc);
          }
          isLoading = false;
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
          isLoading = false;
          update();
        }
      } else {
        //'Please Check Your Internet Connection'
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  launchURL() async {
    const _url = 'https://mohrisa.com/privacy-policy';
    await launch(_url);
  }


  Future<void> getUserProfile() async {
    isLoading = true;
    update();
    _vechiles.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.profile),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //print(response.body);
          Map<dynamic, dynamic> map = json.decode(response.body);

          for (var item in map['results']) {
            userProfile = UserProfileModel.fromJson(item);
            print(userProfile?.photos);
          }
          isLoading = false;
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
          isLoading = false;
          update();
        }
      } else {
        //'Please Check Your Internet Connection'
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }









  updateBottomIndex(int idx) {
    if (bottomNavIndex <= 0) {
      currIndex = 0;
      activeIconstring = "icon1";
      bottomNavIndex = idx;
      update();
      Get.toNamed(Routes.DASHBOARD);
    } else {
      bottomNavIndex = idx;
    }

    getDashboardView(bottomNavIndex);
    update();
  }

  updateIndex() {
    currIndex = currIndex == 0 ? 1 : 0;
    currIndex == 1 ? bottomNavIndex = -1 : null;
    activeIconstring = activeIconstring == "icon1" ? "icon2" : "icon1";
    update();
  }

  updateSettings() {
    settingIndex = settingIndex == 0 ? 1 : 0;
    update();
  }

  //update profile photo
  updateProfileImage() {
    pickImage(true).then((value) => {updateProfileImagetoServer(userProfile!.id.toString())});
  }

  Future<void> markasPresent(LocalServiceModal lsm) async {
    isLoading = true;
    update();
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var dateprsent = {"present_on": formattedDate};
    //print(formattedDate);
    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString =
            "${Configuration.householdLocalServices}${lsm.id}/mark_present/";
        var response = await http.post(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(dateprsent),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //return to list of complaints
          isLoading = false;
          update();
          //navigateReplacePage(page: router.Home);

        } else if (response.statusCode == 401) {
          isLoading = false;
          update();
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  Future<void> sendNotesToGuard() async {
    isLoading = true;
    update();

    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");

        NoteToGuardModel ntg = new NoteToGuardModel();
        ntg.flatNumber = AppConstants.activeFlat!.flatNumber!;
        ntg.userName = userProfile!.firstName.toString() + userProfile!.lastName.toString();
        ntg.text = txtmsgController.text;

        var urlString = Configuration.notestoGuard;
        var postUri = Uri.parse(urlString);
        var request = http.MultipartRequest("POST", postUri);
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "token $token",
          "X-FLAT": "$flatid"
        };
        request.headers.addAll(headers);
        request.fields['flat_number'] = AppConstants.activeFlat!.flatNumber!;
        request.fields['user_name'] = userProfile!.firstName.toString() +
            " " +
            userProfile!.lastName.toString();
        request.fields['text'] = txtmsgController.text;
        request.files.add(
          await http.MultipartFile.fromPath(
            'photo',
            imageTeporary.path,
            filename: file.path.split("/").last,
          ),
        );
        http.StreamedResponse response = await request.send();
        // var response = await http.post(
        //   Uri.parse(urlString),
        //   headers: {
        //     "Content-Type": "application/json",
        //     "Accept": "application/json",
        //     "Authorization": "token $token",
        //     "X-FLAT": "$flatid",
        //   },
        //   body: json.encode(ntg),
        // );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //return to list of complaints
          txtmsgController.text = "";
          isLoading = false;
          update();
          getNotesToguard();
          //navigateReplacePage(page: router.Home);

        } else if (response.statusCode == 401 || response.statusCode == 401) {
          isLoading = false;
          update();
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  Future<void> attadance_history() async {
    _attadanceHistoryList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        //print(token);
        //print(flatid);
        var urlString = Configuration.householdLocalServices +
            lsm!.id.toString() +
            "/attendance/";

        var response = await http.get(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //json.decode(response.body);

          isLoading = false;
          update();
          _attadanceHistoryList.clear();
          _attadanceHistoryList = List<AttendanceHistoryModal>.from(json
              .decode(response.body)
              .map((x) => AttendanceHistoryModal.fromJson(x)));

          isLoading = false;
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

  Future<void> fetchMyDailyHelpList() async {
    isLoading = true;
    update();

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
          isLoading = false;
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

  updateLeavePackageAtGate() {
    leavePackageAtGate = leavePackageAtGate == false ? true : false;
    update();
  }

  updateScreenWidth(context) {
    sc_width = MediaQuery.of(context).size.width;
    sc_height = MediaQuery.of(context).size.height;
  }

  clearVisitorFields() {
    nameController.text = "";
    phoneController.text = "";
    validfromdate = "Select Date";
    onceStartTime = "time";
    validhours = "pick";
    onceValidForinHrs = 0;
    update();
  }

  showExitDialog(context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Do you really want to exit from App?',
                style: AppConstants.appStyles.smallSidehead),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: Text('No', style: AppConstants.appStyles.smallSidehead,),
              ),
              OutlinedButton(
                onPressed: () {
                  //Navigator.pop(context, true);
                  exit(0);
                },
                // passing true
                child: Text('Yes', style: AppConstants.appStyles.smallSidehead,),
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;
      if (exit) {
        // user pressed Yes button
      } else {
        // user pressed No button
      }
    });
  }

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

  getDashboardView(int page) {
    switch (page) {
      case 0:
        return HomeView();
      case 1:
        return ActivitiesView();
      case 2:
        return HouseHoldView();
      case 3:
        return CommunityView();
      case 4:
        return HomeView();
      // return Container(
      //     //color: AppConstants.appcolors.primaryColor,

      //     height: MediaQuery.of(context).size.height - 100.0,
      //     padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
      //     child: gridView());

      default:
        return HomeView();
      // return Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: <Widget>[
      //     Text("Home Screen"),
      //   ],
      // );
    }
  }

  void setAppState(AppState state) {
    _appSate = state;
  }

  Future<void> getListofActivities() async {
    isrecentActivitesLoading = true;
    _activities.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");

        //print("pid${AppConstants.appStrings.selectedCommunity}");

        var response = await http.get(
          Uri.parse(Configuration.activities),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );
        if (response.statusCode == 200) {

          //print(response.body);
          //_activities =  (json.decode(response.body) as List<Activitiesmodel>);

          Map<dynamic, dynamic> map = json.decode(response.body);
          _activities.clear();

          for (var item in map['results']) {
            //print(item);
            // if(item['category']=="others")
            // {
            ActivitiesModel am = ActivitiesModel.fromJson(item);

            print(am);
            _activities.add(am);
            //}

          }
          isrecentActivitesLoading = false;
          update();
        } else if (response.statusCode == 401) {
          // navigateToLogin();
          isrecentActivitesLoading = false;
          update();
          // Get.offAndToNamed(Routes.PHONE_AUTH);
        }
      } else {
        isrecentActivitesLoading = false;
        update();
        //'Please Check Your Internet Connection'
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            //timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
        setAppState(AppState.Idle);
      }
    } catch (e) {
      isrecentActivitesLoading = false;
      update();
      setAppState(AppState.Idle);
    }
  }

  Future<void> getAdvertisements() async {
    loadingAdvertisements = true;
    _advertisementsList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.advertisement),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _advertisementsList.clear();
          for (var item in map['results']) {
            AdvertisementModel cc = AdvertisementModel.fromJson(item);
            cc.photo != null ? _advertisementsList.add(cc) : null;
          }
          loadingAdvertisements = false;
          update();
        } else if (response.statusCode == 401) {
          Get.offAndToNamed(Routes.PHONE_AUTH);
        }
      } else {
        //'Please Check Your Internet Connection'
        loadingAdvertisements = false;
        update();
        //'Please Check Your Internet Connection'
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            //timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
         }
    } catch (e) {
      loadingAdvertisements = false;
    }
  }

  Future<void> openWebLink(AdvertisementModel item) async {
    Uri _url = Uri.parse(item.weblink!);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Future<void> getListofNotiecBoardItems() async {
    isrecentNoticesLoading = true;

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
          isrecentNoticesLoading = false;
          update();
        } else if (response.statusCode == 401) {
          Get.offAndToNamed(Routes.PHONE_AUTH);
        }
      } else {
        //'Please Check Your Internet Connection'
        isrecentNoticesLoading = false;
        update();
        //'Please Check Your Internet Connection'
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            //timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } catch (e) {}
  }

  showDashboard() {
    updateIndex();
    Get.toNamed(Routes.DASHBOARD);
  }
  showScreen(String screenName) {
    Get.toNamed(screenName);
  }
  showCommunityWidget(QuickActivityModel am) {
    Get.toNamed(am.actionUrl!);
  }
  showOptions(QuickActivityModel am) {
    switch (am.visitorCode) {
      case 1:
        updateSelectedVisitorTypeOnce(am);
        //getBottomSheet(am);
        break;
      case 2:
        updateSelectedVisitorTypeOnce(am);
        //getBottomSheet(am);
        break;
      case 3:
        updateSelectedVisitorTypeOnce(am);
        //getBottomSheet(am);
        break;
      case 4:
        updateSelectedVisitorTypeOnce(am);
        //getBottomSheet(am);

        break;
      case 5:
        updateAndShowNotestoGuard(am);
        break;
      case 6:
        updateAndShowSOSCategories(am);
        break;
    }
  }
  getBottomSheet(QuickActivityModel am) {
    Get.bottomSheet(
      Container(
          height: 350.0,
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.00))),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          "How many times do you want to allow ${getTitleString(am)}?",
                          style: AppConstants.appStyles.bottomSheetTitle),
                    ),
                  ),
                  Container(
                    height: 250,
                    width: sc_width,
                    color: Colors.white,
                    child: Column(children: [
                      ListTile(
                        leading: SizedBox(
                            width: 60.0,
                            child: MaterialButton(
                              shape: CircleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: AppConstants.appcolors.appOrange)),
                              color: Colors.white,
                              onPressed: () {},
                              child: Icon(Icons.check,
                                  color: AppConstants.appcolors.appOrange),
                            )),
                        onTap: () {
                          Get.back();
                          updateSelectedVisitorTypeOnce(am);
                          //controller.showOptions(am);
                        },
                        title: Text("Allow ${getVistorType(am)} once",
                          style: AppConstants.appStyles.quickActiveListItem,
                        ),
                      ),
                      ListTile(
                        leading: SizedBox(
                            width: 60.0,
                            child: MaterialButton(
                              shape: CircleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: AppConstants.appcolors.appOrange)),
                              color: Colors.white,
                              onPressed: () {},
                              child: const Icon(Icons.check, color: Colors.orange),
                            )),
                        onTap: () {
                          //Get.back();
                          //Get.toNamed(Routes.ALLOW_FREQUENTLY);
                          Get.back();
                          updateSelectedVisitorTypeFrequent(am);
                        },
                        title: Text(
                          "Allow ${getVistorType(am)} frequently",
                          style: AppConstants.appStyles.quickActiveListItem,
                        ),
                      )
                    ]),
                  )
                ],
              ))),
      elevation: 20.0,
      enableDrag: false,
      backgroundColor: Colors.transparent,
    );
  }

  updateSelectedVisitorTypeOnce(QuickActivityModel am) {
    selectedVisitorTypeOnce = am;
    update();
    Get.toNamed(Routes.ALLOW_ONCE);
  }
  updateAndShowNotestoGuard(QuickActivityModel am) {
    selectedVisitorTypeOnce = am;
    update();
    Get.toNamed(Routes.NOTESTOGUARD);
  }
  updateAndShowSOSCategories(QuickActivityModel am) {
    selectedVisitorTypeOnce = am;
    update();
    Get.toNamed(Routes.SOSCATEGORIES);
  }
  updateSelectedVisitorTypeFrequent(QuickActivityModel am) {
    selectedVisitorTypeFrequent = am;
    update();
    Get.toNamed(Routes.ALLOW_FREQUENTLY);
  }
  getVistorType(QuickActivityModel am) {
    switch (am.visitorCode) {
      case 1:
        return "Guest";
      case 2:
        return "CAB";
      case 3:
        return "Delivery";
      case 4:
        return "Visiting Help";
      case 5:
        break;
      case 6:
        break;
    }
  }
  updateCabcompnayIndex(index) {
    selectedCabCompnayIndex = index;
    selectedCompany = cabcompanies[index];
    update();
    Get.back();
  }

  updateDeliverycompnayIndex(index) {
    selectedDeliveryCompnayIndex = index;
    selectedDeliveryVendor = deliverycompanies[index];
    update();
    Get.back();
  }
  updateVisitingHelpIndex(index) {
    selectedVisitingHelpIndex = index;
    selectedCategory = visitingHelpCategories[index].name!;
    visitingHelpId = visitingHelpCategories[index].id!;
    update();
    Get.back();
  }
  updateCabcompnay(compnay) {
    selectedCompany = compnay;
    selectedCabCompnayIndex = -1;
    update();
    Get.back();
    Get.back();
  }
  getTitleString(QuickActivityModel am) {
    switch (am.visitorCode) {
      case 1:
        return "Guest entry";
      case 2:return "CAB entry";
      case 3:
        return "Delivery executive";
      case 4:
        return "Visiting Help entry";
      case 5:
        break;
      case 6:
        break;
    }
  }
  Future<void> refreshContacts() async {
    loadingContacts = true;
    update();
    final Iterable<Contact> devicecontacts =
        await ContactsService.getContacts();
    contacts = devicecontacts;
    loadingContacts = false;
    update();
  }
  fetchContactInformation(Contact c) {
    nameController.text = c.displayName!.toString();
    var phonenumber = getValidPhoneNumber(c.phones!);
    phoneController.text = phonenumber.toString().trim();
    update();
    Get.back();
  }
  getValidPhoneNumber(Iterable phoneNumbers) {
    if (phoneNumbers.toList().isNotEmpty) {
      List phoneNumbersList = phoneNumbers.toList();
      // This takes first available number. Can change this to display all
      // numbers first and let the user choose which one use.
      return phoneNumbersList[0].value;
    }
    return "";
  }
  showDatePickerIosStyle() async {
    DateTime? picked;
    await showCupertinoModalPopup(
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (_) => Container(
              height: sc_height / 2,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.00))),
                    height: 80,
                    width: sc_width,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                          color: Colors.transparent,
                          child: Text("Select Date",
                              style: AppConstants.appStyles.bottomSheetTitle),
                        )),
                  ),
                  Container(
                    color: Colors.white,
                    height: 230,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        minimumYear: DateTime.now().year,
                        minimumDate: DateTime.now(),
                        maximumDate: DateTime.now().add(Duration(days: 60)),
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          picked = val;
                          //update();
                        }),
                  ),
                  SizedBox(width: 20.0),
                  Divider(),
                  SizedBox(width: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: AppConstants.appStyles.smallText,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (validfromdate == "Select Date") {
                            selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                            selectedDate = selectedDate!.replaceAll("00:00:00.000", "");
                            validfromdate = selectedDate!;
                          }
                          update();
                          Get.back();
                        },
                        child: Text(
                          ' OK ',
                          style: AppConstants.appStyles.buttonText,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppConstants.appcolors.appOrange,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
    if (picked != null && picked != currentDate) {
      currentDate = picked;
      currentDate2 = picked;
      selectedDate = currentDate2.toString();
      selectedDate = selectedDate!.replaceAll("00:00:00.000", "");
      validfromdate = selectedDate!;
    }
    update();
  }
  selectTime() async {
    TimeOfDay? pickedTime;
    await showCupertinoModalPopup(
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (_) => Container(
              height: 380,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.00))),
                    height: 80,
                    width: sc_width,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                          color: Colors.transparent,
                          child: Text("Select Time",
                          style: AppConstants.appStyles.bottomSheetTitle),
                        )),
                  ),
                  Container(
                    color: Colors.white,
                    height: 230,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          onceStartTime = DateFormat('Hm').format(val);
                          //"stes"; // '${val.hour}:${val.minute}';
                          //update();
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: AppConstants.appStyles.smallText,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      ElevatedButton(
                        onPressed: () {
                          if (onceStartTime == "time") {
                        onceStartTime = DateFormat('Hm').format(DateTime.now());
                          }
                          update();
                          Get.back();
                        },
                        child: Text(
                          ' OK ',
                          style: AppConstants.appStyles.buttonText,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppConstants.appcolors.appOrange,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));

    // TimeOfDay _currentTime = new TimeOfDay.now();
    // TimeOfDay? pickedTime =
    //     await showTimePicker(context: Get.context!, initialTime: _currentTime);
    // MaterialLocalizations localizations =
    //     MaterialLocalizations.of(Get.context!);
    // if (pickedTime != null) {
    //   String formattedTime = localizations.formatTimeOfDay(pickedTime,
    //       alwaysUse24HourFormat: false);

    //   onceStartTime = formattedTime;
    //   //tabindex = 0;

    //   update();
    //   //   Navigator.pop(context);
    //   // showCabOptions();

    // }
  }

  void shownexthoursmodel() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (context) {
          return getHoursList();
        });
  }

  Widget getHoursList() {
// return Row(children: controller.hours.map((item) => new Text(item)).toList());

    return Container(
        height: 150.0,
        child: Center(
            child: Wrap(direction: Axis.horizontal, children: [
          for (var item in hours)
            Padding(
              padding: EdgeInsets.all(5.0),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    String sh = item;
                    sh = sh.replaceAll(' Hours', '');
                    sh = sh.replaceAll(' Hour', '');
                    validhours = item;
                    onceValidForinHrs = int.parse(sh);
                    onceValidFor = onceValidForinHrs;

                    update();
                    //Navigator.pop(context);
                    Get.back();
                    //Navigator.pop(context);
                    // showCabOptions();
                  },
                  color: validhours == item ? Colors.red : Colors.white,
                  textColor: validhours == item ? Colors.white : Colors.black,
                  child: Text(
                    item, style: AppConstants.appStyles.smallTextbs,
                  )),
            )
        ])));
  }

  Future<PreApprovedGuestModel?> submitAllowGuestOnce() async {
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    String pn = phoneController.text.trim().toString();
    pn = pn.replaceAll(" ", "");
    errMsg = "";

    if (pn.length == 10) {
      pn = "+91" + pn;
    } else if (pn.length > 13 || pn.length < 10) {
      errMsg = "Please verify phone number";
    }

    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        // //print(token);
        // //print(json.encode(allowCabOnce.toJson()),);
        int? flatid = preference.getInt("flatId");
        int? communityID = preference.getInt("communityID");
        PreApprovedGuestModel allowGuestOnce = new PreApprovedGuestModel();
        allowGuestOnce.phone = pn;
        allowGuestOnce.name = nameController.text.trim();
        allowGuestOnce.frequencyType = 1;
        allowGuestOnce.validFromDate = validfromdate.trim();
        allowGuestOnce.onceStartTime = onceStartTime.trim();
        allowGuestOnce.visitorType = selectedVisitorTypeOnce!.visitorCode;
        allowGuestOnce.community = communityID;
        allowGuestOnce.flat = flatid;
        allowGuestOnce.onceValidFor = onceValidForinHrs;
        allowGuestOnce.onceStartTime = onceStartTime.trim();
        allowGuestOnce.status = true;

        //print(json.encode(allowGuestOnce.toJson()));

        var response = await http.post(
          //Uri.parse(Configuration.approvedguests),
          Uri.parse(Configuration.preapprovedGuests),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(allowGuestOnce.toJson()),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          print(response.body);

          PreApprovedGuestModel allowed_gust =
              PreApprovedGuestModel.fromJson(json.decode(response.body));

          resetvalues();
          return allowed_gust;
          //  Get.toNamed(Routes.DASHBOARD);

        } else if (response.statusCode == 400 ||
            response.statusCode == 401 ||
            response.statusCode == 403) {
          Fluttertoast.showToast(
              msg: "Update error",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
          return null;
        }
      } else {}
    } catch (e) {}
  }

  resetvalues() {
    // //validfromdate
    // final visitorTypeList = visitorTypeChoices
    //     .map((hr) => MultiSelectItem<VisitorTypeModel>(hr, hr.visitor_type))
    //     .toList();

    // nameController.text = "";
    // phonenumber = "";
    // phoneController.text = "";
    // validfromdate = "Select Date";
    // onceStartTime = "time";
    // validhours = "pick";
    // SelectedVisitorType = "Select guest type";
    // selectedVisitorTypeID = 0;
    // SelectedVisitorType = "Select guest type";
    // selectedVisitorTypeID = 0;
  }

  resettoDefaults() {
    validfromdate = "Select Date";
    selectedCompany = "Company Name";
    selectedCategory = "Select Category";
    selectedDeliveryVendor = "Vendor Name";
    validhours = "pick";
    onceStartTime = "time";
  }

  submitAllowCabOnce() async {
    bool result = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    AllowCabOnce allowCabOnce = AllowCabOnce(
        validFromdate: validfromdate.trim(),
        onceStarttime: onceStartTime,
        onceValidfor: onceValidFor,
        vehicleNumber: vehicleNo,
        company: selectedCompany);

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        // //print(token);
        // //print(json.encode(allowCabOnce.toJson()),);
        int? flatid = preference.getInt("flatId");
        var response = await http.post(
          Uri.parse(Configuration.preApprovedCabs),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(allowCabOnce.toJson()),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          resettoDefaults();
          //   _newImages.clear();
          //  remarks = "";
          //return to list of complaints
          Get.toNamed(Routes.QUICK_ACTIVITY);

          return true;
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: "Update error",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
        }
      } else {}
    } catch (e) {}
  }

  submitAllowDeliveryOnce() async {
    bool result = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    AllowDeliveryOncemodel allowDeliveryOnce = AllowDeliveryOncemodel(
        validFromdate: validfromdate.trim(),
        onceStarttime: onceStartTime,
        //leavePackageAtGate: leavePackageAtGate,
        onceValidfor: onceValidFor,
        company: selectedCompany);

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        // //print(token);
        // //print(json.encode(allowCabOnce.toJson()),);
        int? flatid = preference.getInt("flatId");
        var response = await http.post(
          Uri.parse(Configuration.preApprovedDelivery),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(allowDeliveryOnce.toJson()),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          resettoDefaults();
          Fluttertoast.showToast(
              msg: "Update Success",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 13.0);
          Get.toNamed(Routes.QUICK_ACTIVITY);
          return true;
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: "Update Failed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
        }
      } else {}
    } catch (e) {}
  }

  submitAllowVisitingOnce() async {
    bool result = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    AllowVisitHelpOncemodel allowVistingOnce = AllowVisitHelpOncemodel(
        visitingHelpCategoryId: visitingHelpId,
        validFromdate: validfromdate.trim(),
        onceStarttime: onceStartTime,
        onceValidfor: onceValidFor,
        company: selectedCategory);

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        // //print(token);
        // //print(json.encode(allowCabOnce.toJson()),);
        int? flatid = preference.getInt("flatId");
        var response = await http.post(
          Uri.parse(Configuration.preApproveHelperEntry),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(allowVistingOnce.toJson()),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          resettoDefaults();
          Fluttertoast.showToast(
              msg: "Update Success",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 13.0);

          Get.toNamed(Routes.QUICK_ACTIVITY);

          return true;
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: "Update Failed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {}
  }

  Future<void> getListofCategories() async {
    visitingHelpCategories.clear();

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");

        var response = await http.get(
          Uri.parse(Configuration.visitingHelpCategories),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          visitingHelpCategories.clear();
          for (var item in map['results']) {
            // //print(item);
            VisitingHelpCategoriesmodel vc =
                VisitingHelpCategoriesmodel.fromJson(item);

            visitingHelpCategories.add(vc);
          }
        } else if (response.statusCode == 401) {
          Get.toNamed(Routes.PHONE_AUTH);
        }
      } else {}
    } catch (e) {}
  }

  String? firstname;
  String? lastName;
  String? mobilenumber;
  String? useremail;
  Widget getFirstName() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              hintText: 'First Name',
              hintStyle: AppConstants.appStyles.smallTextPrimary),
          autofocus: false,
          controller: nameController,
          onChanged: (value) {
            firstname = value;
            update();
          },
          focusNode: _firstName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {},
          validator: (value) {
            if (value != null) {
              return null;
            } else {
              return 'Enter First Name';
            }
          },
        ));
  }

  Timer? _timer;
  clearTimerandClose() {
    _timer!.cancel();
    Get.back();
  }

  displayCoundonwImages() {
    displayCountdown = 4;
    counterImage = AppConstants.appimages.three;
    int _pos = 4;

    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _pos = (_pos - 1);

      if (_pos == 3) {
        counterImage = AppConstants.appimages.three;
        print(counterImage);
        update();
      } else if (_pos == 2) {
        counterImage = AppConstants.appimages.two;
        print(counterImage);
        update();
      } else if (_pos == 1) {
        counterImage = AppConstants.appimages.one;

        update();
      }
      if (_pos <= 0) {
        _timer!.cancel();
        updateSOSalert();

        //
      }
      update();
      //_pos = (_pos + 1) % widget.photos.length;
    });
  }

  void updateSOSalert() async {
    setAppState(AppState.Busy);
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    var newSOS = {
      "name": userProfile!.firstName.toString() +
          " " +
      userProfile!.lastName.toString(),
      "flats": preference.getInt("flatId"),
      "phone": preference.getString("phone"),
      "emergency_type": selectedSOScategory!.dbcode!,
      "community": preference.getInt("communityID"),
      "resolvedType": 1
    };

    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString = Configuration.sosalerts;

        var response = await http.post(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(newSOS),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          selectedVehicleID = 0;

          Fluttertoast.showToast(
              msg: "Status updated",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 13.0);
          Get.offAndToNamed(Routes.POST_SOS_ALERT);
        } else if (response.statusCode == 401 || response.statusCode == 400) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
          setAppState(AppState.Idle);
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {
      setAppState(AppState.Idle);
    }
    setAppState(AppState.Idle);
  }

  Widget getLastName() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              hintText: 'Last Name',
              hintStyle: AppConstants.appStyles.smallTextPrimary),
          onChanged: (value) {
            lastName = value;
            update();
          },
          focusNode: _lastName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            //_lastName.unfocus();
            //FocusScope.of(context).requestFocus(_firstName);
          },
          validator: (value) {
            if (value != null) {
              return null;
            } else {
              return 'Enter Last Name';
            }
          },
        ));
  }

  Widget getPhoneNumber() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: TextFormField(
          maxLength: 15,
          decoration: InputDecoration(
              counterText: "",
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              hintText: 'Mobile Number',
              hintStyle: AppConstants.appStyles.smallTextPrimary),
          controller: phoneController,
          onChanged: (value) {
            mobilenumber = value;
            //newuser.phone = value;
            //lname=value;
            update();
            //newUser.last_name = value,
          },
          focusNode: _mobilenumber,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {},
          validator: (value) {
            if (value != null) {
              return null;
            } else {
              return 'Enter Mobile Number';
            }
          },
        ));
  }

  Widget getEmailFiled() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: TextFormField(
          decoration: InputDecoration(
              counterText: "",
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              hintText: 'Enter Email',
              hintStyle: AppConstants.appStyles.smallTextPrimary),
          controller: emailController,
          onChanged: (value) {
            useremail = value;
            //newuser.phone = value;
            //lname=value;
            update();
            //newUser.last_name = value,
          },
          focusNode: _mobilenumber,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {},
          validator: (value) {
            if (value == null) {
              return 'Enter Email Id';
            }
            // else if (!EmailValidator.validate(value)) {
            //   return 'Enter Email Id';
            // }
            return null;
          },
        ));
  }

  updateRole(String item) {
    selectedRole = item;

    update();
    Get.back();
  }

  updateOccupancyStatus(String item) {
    occupancyStatus = item;
    update();
    Get.back();
  }

  swapOptin() {
    selectedOptIn == true ? selectedOptIn = false : selectedOptIn = true;
    update();
  }

  Future<bool?> Addresident() async {
    isLoading = true;
    update();
    bool result = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    int? flatid = preference.getInt("flatId");

    String pn = phoneController.text.trim().toString();

    pn = pn.replaceAll(" ", "");
    this.errMsg = "";

    if (pn.length == 10) {
      pn = "+91" + pn;
    } else if (pn.length > 13 || pn.length < 10) {
      this.errMsg = "Please verify phone number";
      isLoading = false;
      update();
      return null;
    }

    NewUser newuser = NewUser(
        email: useremail,
        mobileNumber: pn,
        firstName: nameController.text.trim(),
        lastName: lastName);

    NewResidentmodel newResident = NewResidentmodel(
        flat: flatid,
        role: selectedRole.toLowerCase(),
        occupancy_status: occupancyStatus.toString().toLowerCase(),
        connect_opt_in: selectedOptIn,
        user: NewUser.fromJson(newuser.toJson()));

    //print(json.encode(newResident.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        //print(token);
        // //print(json.encode(allowCabOnce.toJson()),);

        var response = await http.post(
          Uri.parse(Configuration.addFamilyMember),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token"
          },
          body: json.encode(newResident.toJson()),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          isLoading = false;
          update();
          Get.toNamed(Routes.DASHBOARD);
          return true;
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
          isLoading = false;
          update();
        }
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  Future<void> paymentHistory() async {
    isloading = true;

    _paymentHistoryList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        //print(token);
        //print(flatid);
        var urlString = Configuration.householdLocalServices +
            lsm!.id.toString() +
            "/payments/";

        var response = await http.get(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //json.decode(response.body);

          _paymentHistoryList.clear();
          _paymentHistoryList = List<PaymentModal>.from(
              json.decode(response.body).map((x) => PaymentModal.fromJson(x)));
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

  updaetPaymentRemarks(String val) {
    paymentRemarks = val;
    update();
  }

  Future<void> postPayment() async {
    setAppState(AppState.Busy);
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    if (amountController.text == null) {
      Get.snackbar('Error', 'Enter amount',
          colorText: Colors.white,
          backgroundColor: AppConstants.appcolors.appOrange,
          snackPosition: SnackPosition.TOP);

      return;
    }

    var amountString = {
      "amount": int.parse(amountController.text),
      "what_for": paymentRemarks,
      "mode": modeofPayment
    };
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString = Configuration.householdLocalServices +
            lsm!.id.toString() +
            "/record_payment/";
        var response = await http.post(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(amountString),
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          //return to list of complaints
          //setAppState(AppState.Idle);

          isloading = false;
          update();
          Get.snackbar('Success', 'Payment updated',
          colorText: Colors.white,
          backgroundColor: AppConstants.appcolors.greenButton,
          snackPosition: SnackPosition.TOP);
          paymentRemarks = "";
          amountController.text = "";
          commentController.text = "";
          Get.toNamed(Routes.DASHBOARD);
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

  File? imageFile;
  File? capturedImageFile;
  bool? fileUploaded;

  var url;
  File? _file;
  File get file => _file!;
  String? currentFilePath;

  List<NewImage> _newImages = [];
  List<NewImage> get newImages => _newImages;

  showCamera() {
    //AppConstants.appStrings.lastRoute = Routes.POST_COMMENT;
    pickImage(false);
  }



  void updateProfileImagetoServer(String id) async {
    setAppState(AppState.Busy);
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString = Configuration.profile;
        var postUri = Uri.parse(urlString);
        var request = http.MultipartRequest("POST", postUri);
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "token $token",
          "X-FLAT": "$flatid"
        };
        request.headers.addAll(headers);
        request.fields['users'] = userProfile!.id.toString();
        request.fields['photos'] = NewProfileImage!.localurl.toString();
        request.files.add(
          await http.MultipartFile.fromPath(
            'photos',
            NewProfileImage!.localurl.toString(),
            filename: file.path.split("/").last,
          ),
        );
        http.StreamedResponse response = await request.send();
               print(userProfile!.users);
        // var response = await http.post(
        //   Uri.parse(urlString),
        //   headers: {
        //     "Content-Type": "application/json",
        //     "Accept": "application/json",
        //     "Authorization": "token $token",
        //     "X-FLAT": "$flatid"
        //   },
        //   body: json.encode(updateStatus),
        // );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Fluttertoast.showToast(
              msg: "Profile Image Updated",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 13.0);
          setAppState(AppState.Idle);
        } else if (response.statusCode == 401) {
          setAppState(AppState.Idle);
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {
      setAppState(AppState.Idle);
    }
    setAppState(AppState.Idle);
  }

  var imageTeporary;

  pickImagefromGallery() async {
    imageTeporary = "";
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageTeporary = File(pickedFile.path);
      fileUploaded = false;
      imageFile = imageTeporary;
      uploadFiles(imageTeporary.path, false);
    }
  }

  Future pickImage(bool isProfileImage) async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    if (img == null) return;
    imageTeporary = File(img.path);
    capturedImageFile = File(img.path);
    fileUploaded = false;
    imageFile = imageTeporary;
    uploadFiles(imageTeporary.path, isProfileImage);
  }
  Future<bool> uploadFiles(String? currentFilePath, bool isProfileImage,
      {String? eventid, bool? isprivate}) async {
    isLoading = true;
    update();
    bool result = false;
    var preference = await SharedPreferences.getInstance();
    int? flatid = preference.getInt("flatId");
    try {
      _file = File(currentFilePath!);
      var token = preference.getString("token");

      if (_file == null) {
        //show some error
      } else {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(Configuration.fileUpload),
        );
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            file.path,
            filename: file.path.split("/").last,
          ),
        );
        request.headers.addAll({
          "Content-Type": "multipart/form-data",
          "Authorization": "token $token",
          "X-FLAT": "$flatid"
        });
        var streamedResponse = await request.send();
        if (streamedResponse.statusCode == 200 ||
            streamedResponse.statusCode == 201) {
          var response = await http.Response.fromStream(streamedResponse);
          var k = json.decode(response.body);
          NewImage img = NewImage();
          img.localurl = file.path;
          img.id = k['id'];
          NewProfileImage!.id = k['id'];
          NewProfileImage!.localurl = file.path;
          if (!isProfileImage) {
            newImages.add(img);
          } else {
            NewProfileImage = img;
            NewProfileImage!.id = k['id'];
            NewProfileImage!.localurl = file.path;
          }
          result = true;
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    return result;
  }

  void addNewVehicle() async {
    isLoading = true;
    update();
    bool result = false;

    //uploadedImageRefIds.clear();
    //newImages.forEach((NewImage img) => uploadedImageRefIds.add(img.id!));

    uploadedIamgeRefUrls.clear();
    newImages.forEach((NewImage img) => uploadedIamgeRefUrls.add(img.localurl!));
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    var newVehicle = {
      "name": controllerVehicleName.text.toUpperCase(),
      "vehicle_number": controllerVehicleNumber.text.toUpperCase(),
      "vehicle_type": newVehicleType,
      "photo": uploadedIamgeRefUrls[0]
    };

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString = Configuration.vehicles;

        var postUri = Uri.parse(urlString);
        var request = http.MultipartRequest("POST", postUri);

        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "token $token",
          "X-FLAT": "$flatid"
        };

        request.headers.addAll(headers);

        request.fields['name'] = controllerVehicleName.text.toUpperCase();
        request.fields['vehicle_number'] =
            controllerVehicleNumber.text.toUpperCase();
        request.fields['vehicle_type'] = newVehicleType.toString();

        request.files.add(
          await http.MultipartFile.fromPath(
            'photo',
            file.path,
            filename: file.path.split("/").last,
          ),
        );
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200 || response.statusCode == 201) {
          _newImages.clear();
          controllerVehicleName.text = "";
          controllerVehicleNumber.text = "";
          isLoading = false;
          update();
          Get.toNamed(Routes.DASHBOARD);
        } else if (response.statusCode == 401) {}
      } else {
       // print("Internet error");
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  String? hero_imageLocation;
  String? activeHeroTag;
  String? heroImageUrl;

  heroTapped(int idx, String imgurl, String? loc) {
    activeHeroTag = idx.toString();
    heroImageUrl = imgurl;
    hero_imageLocation = loc;
    Get.toNamed(Routes.DB_HERO_VIEW);
  }
  void enableNotification() {
    notificationSetting = true;
    update();
    updateNotification();
  }
  void disableNotification() {
    notificationSetting = false;
    update();
    updateNotification();
  }
  void updateNotification() async {
    setAppState(AppState.Busy);
    bool result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    var updateStatus = {"is_enabled": notificationSetting};
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString = Configuration.vehicles +
            myVehicle!.id.toString() +
            "/notify_setting/";
        var response = await http.post(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(updateStatus),
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          selectedVehicleID = 0;
          Fluttertoast.showToast(
              msg: "Status updated",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 13.0);
          setAppState(AppState.Idle);
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 13.0);
          setAppState(AppState.Idle);
        }
      } else {
        //print("Internet error");
      }
    } catch (e) {
      setAppState(AppState.Idle);
    }
    setAppState(AppState.Idle);
  }

  Future<void> getVehicleLogHistry() async {
    setAppState(AppState.Busy);
    _vechileLog.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        //print(token);
        //print(flatid);
        var urlString =
            Configuration.vehicles + selectedVehicleID.toString() + "/in-outs/";

        var response = await http.get(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          _vechileLog.clear();
          for (var item in map['results']) {
            //print(item);
            VehicleLogModal vc = VehicleLogModal.fromJson(item);
            _vechileLog.add(vc);
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
          setAppState(AppState.Idle);
        }
      } else {
        //'Please Check Your Internet Connection'

      }
    } catch (e) {
      setAppState(AppState.Idle);
    }
    setAppState(AppState.Idle);
  }

  //get servant details
  Future<void> getVehicleDetails() async {
    setAppState(AppState.Busy);
    var preference = await SharedPreferences.getInstance();
    var connectivityResult = await (Connectivity().checkConnectivity());

    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(
              Configuration.vehicles + selectedVehicleID.toString() + "/"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          myVehicle = Vehiclemodel.fromJson(jsonDecode(response.body));
          update();
        } else if (response.statusCode == 401) {}
      } else {
    //'Please Check Your Internet Connection'
      }
    } catch (e) {
      setAppState(AppState.Idle);
    }
    setAppState(AppState.Idle);
  }
  selectVehicle(Vehiclemodel slv) {
    myVehicle = slv;
    update;
    Get.toNamed(Routes.VEHICLE_LOG);
  }
}
