import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mykommunity/app/data/models/resident_directory_model.dart';
import 'package:mykommunity/app/modules/camera/views/my_camera_view.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/app/widgets/app_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/ResidentsModel.dart';
import '../../../data/models/cItem.dart';
import '../../../data/models/complaint_category.dart';
import '../../../data/models/complaints_model.dart';
import '../../../data/models/confirmedComplaintModel.dart';
import '../../../data/models/emergency_contact_model.dart';
import '../../../data/models/newImage.dart';
import '../../../widgets/configuration.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HelpdeskController extends GetxController {
  List<ConfirmedComplaintModal> _confirmedcomplaintslist = [];
  List<ConfirmedComplaintModal> get confirmed_complaintsList => _confirmedcomplaintslist;
  int? detailsId;

  bool isLoading = true;

  ConfirmedComplaintModal? sc;


  TextEditingController? commentController;
  String commenetsString = "";
  String paymentRemarks = "";

  List<int> _uploadedIamgeRefIds = [];
  List<int> get uploadedImageRefIds => _uploadedIamgeRefIds;

  List<NewImage> _newImages = [];
  List<NewImage> get newImages => _newImages;

  var url;
  File? _file;
  File get file => _file!;
  String? currentFilePath;

  String? activeHeroTag;
  String? heroImageUrl;

  List<ComplaintCategory> _complaintCategories = [];
  List<ComplaintCategory> get complaintCategories => _complaintCategories;

  List<ResidentDirectoryModel> _residentsList = [];
  List<ResidentDirectoryModel> get residentsList => _residentsList;

  List<ResidentDirectoryModel> _residentsSearchList = [];
  List<ResidentDirectoryModel> get residentsSearchList => _residentsSearchList;

  int selectedCategoryIndx = 0;
  String selectedCategory = "";
  ComplaintCategory? selectedComplaintCategory;

  List<String> _flatNumbers = [];
  List<String> get flatNumbers => _flatNumbers;

  int? selectedIndex;

  String subcat = 'Complaint';
  String complaintType = 'Personal';
  String? remarks;

  final count = 0.obs;

  TextEditingController editingController = TextEditingController();
  TextEditingController editControolerRemarks = TextEditingController();

  int complaintTypeId = 1;
  int subcatid = 1;

  List<dynamic> _filteredList = [];
  List<dynamic> get filteredItems => _filteredList;

  List<CItem> dataItems = [];
  List<CItem> duplicateItems = [];

  List<EmergencyContactsModal> _emergency_contacts_slist = [];
  List<EmergencyContactsModal> get emergency_contacts_list => _emergency_contacts_slist;

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

  void setInitialValue() {
    _confirmedcomplaintslist = [];
    get_ListofComplaints();
  }

  Future<void> getListofComplaintCategories() async {
    isLoading = true;

    _complaintCategories.clear();

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");

        var response = await http.get(
          Uri.parse(Configuration.complaintCategories),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200) {
          Map<dynamic, dynamic> map = json.decode(response.body);

          _complaintCategories.clear();
          for (var item in map['results']) {
            //print(item);
            ComplaintCategory cc = ComplaintCategory.fromJson(item);

            _complaintCategories.add(cc);
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

  showDashboard() {
    Get.toNamed(Routes.DASHBOARD);
  }

  showDetasils(ConfirmedComplaintModal c) {
    sc = c;
    get_ComplaintDetails();
    Get.toNamed(Routes.COMPLAINT_DETAILS);
  }

  updateStatsAndRaiseComplaint(ComplaintCategory c) {
    // selectedCategoryIndx = c.id!;
    // selectedCategory = c.name!;

    // selectedComplaintCategory?.setId(c.id);
    // selectedComplaintCategory?.setName(c.name);

    selectedComplaintCategory = c;
    update();
    Get.toNamed(Routes.RAISECOMPLAINT);
  }

  back() {
    Get.back();
  }

  String? hero_imageLocation;

  heroTapped(int idx, String imgurl, String? loc) {
    activeHeroTag = idx.toString();
    heroImageUrl = imgurl;
    hero_imageLocation = loc;
    Get.toNamed(Routes.HERO_VIEW);
  }

  Future<void> get_ListofComplaints() async {
    isLoading = true;
    _confirmedcomplaintslist.clear();

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");

        var response = await http.get(
          Uri.parse(Configuration.complaints),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);
          // //print(map['results']);
          //_confirmedcomplaintslist = map['results'];
          //   Iterable it = (map['results']);
          //   _confirmedcomplaintslist = it.map((e) => ConfirmedComplaints.fromJson(e)).toList();
          _confirmedcomplaintslist.clear();
          for (var item in map['results']) {
            //print(item);
            ConfirmedComplaintModal cc = ConfirmedComplaintModal.fromJson(item);
            _confirmedcomplaintslist.add(cc);
          }
          _confirmedcomplaintslist.sort();

          isLoading = false;
          update();
        } else if (response.statusCode == 401) {}
      } else {
        isLoading = false;
        update();
        //'Please Check Your Internet Connection'
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  void postComment() async {
    isLoading = true;
    update();
    bool result = false;
    uploadedImageRefIds.clear();
    newImages.forEach((NewImage img) => uploadedImageRefIds.add(img.id!));
    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    // //print(selectedIndex);
    // //print(subcat);
    // //print(complaintType);
    // //print(remarks);
    // //print(uploadedImageRefIds);

    var newComment = {
      "comment": commenetsString,
      "photos": uploadedImageRefIds
    };

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var urlString = "${Configuration.complaints}${sc!.id}/comment/";
        var response = await http.post(
          Uri.parse(urlString),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(newComment),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          _newImages.clear();
          commenetsString = "";
          //return to list of complaints
          Get.toNamed(Routes.COMPLAINT_DETAILS);
        } else if (response.statusCode == 401) {}
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

  updateCommentString(val) {
    commenetsString = val;
    update();
  }

  // showCamera() {
  //   AppConstants.appStrings.lastRoute = Routes.POST_COMMENT;

  //   Get.toNamed(Routes.MYCAMERA);
  // }

  File? imageFile;
  File? capturedImageFile;
  bool? fileUploaded;

  showCamera() {
    //AppConstants.appStrings.lastRoute = Routes.POST_COMMENT;
    pickImage();
  }

  Future pickImage() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    if (img == null) return;
    final imageTeporary = File(img.path);
    capturedImageFile = File(img.path);

    fileUploaded = false;
    imageFile = imageTeporary;

    uploadFiles(imageTeporary.path);
  }

  Future<bool> uploadFiles(String? currentFilePath,
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
          ////print(k['id']);
          NewImage img = new NewImage();
          img.localurl = file.path;
          img.id = k['id'];
          newImages.add(img);

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

  // submitComplaint() async {
  //   isLoading = true;
  //   update();
  //   bool result = false;
  //   uploadedImageRefIds.clear();
  //   newImages.forEach((NewImage img) => uploadedImageRefIds.add(img.id!));

  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   var preference = await SharedPreferences.getInstance();
  //   // //print(selectedIndex);
  //   // //print(subcat);
  //   // //print(complaintType);
  //   // //print(remarks);
  //   // //print(uploadedImageRefIds);

  //   Complaints newComplaint = Complaints(
  //       category: SELEC,
  //       sub_category: subcat,
  //       complain_type: complaintType,
  //       description: remarks,
  //       photos: uploadedImageRefIds);

  //   ////print(json.encode(newComplaint.toJson()));
  //   try {
  //     if (connectivityResult == ConnectivityResult.mobile ||
  //         connectivityResult == ConnectivityResult.wifi) {
  //       var token = preference.getString("token");
  //       int? flatid = preference.getInt("flatId");
  //       var response = await http.post(
  //         Uri.parse(Configuration.complaints),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json",
  //           "Authorization": "token $token",
  //           "X-FLAT": "$flatid"
  //         },
  //         body: json.encode(newComplaint.toJson()),
  //       );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         _newImages.clear();
  //         remarks = "";
  //         //return to list of complaints
  //         isLoading = false;
  //         update();

  //         Get.toNamed(Routes.HELPDESK);

  //         return true;
  //       } else if (response.statusCode == 401) {}
  //     } else {
  //       isLoading = false;
  //       update();
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     update();
  //   }
  //   isLoading = false;
  //   update();
  // }

  Future<void> get_ComplaintDetails() async {
    isLoading = true;
    update();
    var preference = await SharedPreferences.getInstance();
    var connectivityResult = await (Connectivity().checkConnectivity());
    //print(Configuration.complaints + complaitnId.toString());
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.get(
          Uri.parse(Configuration.complaints + sc!.id.toString()),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          sc = ConfirmedComplaintModal.fromJson(jsonDecode(response.body));
          // print(complaint.comments.first.commentedBy);
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

  updateComplaintType(cid, ctype) {
    complaintTypeId = cid;
    complaintType = ctype;
    update();
  }

  updateCatSubcat(scid, sc) {
    subcatid = scid;
    subcat = sc;
    update();
  }

  void filterSearchResults(query) {
    List<dynamic> dummyListData = []; // List<dynamic>();

    if (query.isNotEmpty) {
      dummyListData.clear();

      complaintCategories.forEach((item) {
        ////print(item['name']);
        if (item.name!.contains(query)) {
          dummyListData.add(item);
        }
      });
      filteredItems.clear();
      filteredItems.addAll(dummyListData);
      update();
    } else {
      resetListView();
      update();
    }
  }

  void resetListView() {
    _filteredList = [];
    filteredItems.addAll(complaintCategories);
  }

  getHelpDesknumbers() {}

  submitComplaint() async {
    isLoading = true;
    update();
    bool result = false;
    uploadedImageRefIds.clear();
    newImages.forEach((NewImage img) => uploadedImageRefIds.add(img.id!));

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();

    Complaints newComplaint = Complaints(
        categoryId: selectedComplaintCategory!.id,
        sub_category: subcat,
        complain_type: complaintType,
        description: remarks,
        photos: uploadedImageRefIds);

    ////print(json.encode(newComplaint.toJson()));
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        var response = await http.post(
          Uri.parse(Configuration.complaints),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
          body: json.encode(newComplaint.toJson()),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          _newImages.clear();
          remarks = "";
          //return to list of complaints
          //   navigateReplacePage(page: router.Helpdesk);
          isLoading = false;
          update();
          Fluttertoast.showToast(
              msg: "Complaint raised successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: AppConstants.appcolors.primaryColor,
              textColor: Colors.white,
              fontSize: 13.0);

          Get.toNamed(Routes.HELPDESK);
          return true;
        } else if (response.statusCode == 401) {}
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

  clearImagesandGotoPostCommentScreen() {
    newImages.clear();
    Get.toNamed(Routes.POST_COMMENT);
  }

  Future<void> getListofEmergencyContacts() async {
    isLoading = true;
    _emergency_contacts_slist.clear();

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        // print(token);
        var response = await http.get(
          Uri.parse(Configuration.emergencyContact),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<dynamic, dynamic> map = json.decode(response.body);

          _emergency_contacts_slist.clear();
          for (var item in map['results']) {
            //print(item);
            EmergencyContactsModal cc = EmergencyContactsModal.fromJson(item);

            _emergency_contacts_slist.add(cc);
          }
          isLoading = false;
          update();
        } else if (response.statusCode == 401) {
          // navigateToLogin();
        }
      } else {}
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> getListofResidents() async {
    isLoading = true;
    _residentsList.clear();
    _residentsSearchList.clear();
    _flatNumbers.clear();

    var connectivityResult = await (Connectivity().checkConnectivity());
    var preference = await SharedPreferences.getInstance();
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var token = preference.getString("token");
        int? flatid = preference.getInt("flatId");
        // print(token);
        var response = await http.get(
          Uri.parse(Configuration.residentsDirectory),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "token $token",
            "X-FLAT": "$flatid"
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          //Map<dynamic, dynamic> map = json.decode(response.body);
          _residentsList.clear();
          //  _residentsList = List<ResidentModel>.from(elements)(jsonDecode(response.body))

          Map<dynamic, dynamic> map = json.decode(response.body);

          for (var item in map['results']) {
            // print(item);
            ResidentDirectoryModel cc = ResidentDirectoryModel.fromJson(item);

            if (!_flatNumbers.contains(cc.flatNumber!)) {
              _flatNumbers.add(cc.flatNumber!);
            }
            _residentsList.add(cc);
            _residentsSearchList.add(cc);
          }
          _flatNumbers.sort();

          isLoading = false;
          update();
        } else if (response.statusCode == 401) {
          // navigateToLogin();
        }
      } else {}
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }
}
