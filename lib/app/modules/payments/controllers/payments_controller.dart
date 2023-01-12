import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/buttons_model.dart';
import '../../../routes/app_pages.dart';

class PaymentsController extends GetxController {
  //TODO: Implement PaymentsController
  double sc_width = 0.0;
  double sc_height = 0.0;
  final count = 0.obs;
  bool isloading = false;

  List<ButtonsModel> BillsandPhonePaymentsList = [
    ButtonsModel(
        id: 1,
        label: "Mobile\nPrepaid",
        icon: AppConstants.appimages.mobileprepaid,
        actionType: "",
        actionUrl: Routes.MOBILEPREPAID),

    ButtonsModel(
        id: 2,
        label: "Mobile\nPostpaid",
        icon: AppConstants.appimages.mobilepostpaid,
        actionType: "",
        actionUrl: Routes.MOBILEPOSTPAID),
    ButtonsModel(
        id: 3,
        label: "Broadband\n",
        icon: AppConstants.appimages.broadband,
        actionType: "",
        actionUrl: Routes.BRODBRAND),
    ButtonsModel(
        id: 4,
        label: "DTH\n",
        icon: AppConstants.appimages.dth,
        actionType: "",
        actionUrl: Routes.DTHVIEW),
    ButtonsModel(
        id: 5,
        label: "Cable TV\n",
        icon: AppConstants.appimages.cabletv,
        actionType: "",
        actionUrl: Routes.PAYMENTS),
    ButtonsModel(
        id: 6,
        label: "Landline\nPostpaid",
        icon: AppConstants.appimages.landlinePostpaid,
        actionType: "",
        actionUrl: Routes.LANDLINEPOSTPAID),
    ButtonsModel(
        id: 7,
        label: "Fasttag\n",
        icon: AppConstants.appimages.fastag,
        actionType: "",
        actionUrl: Routes.FASTTAGVIEW),
  ];

  List<ButtonsModel> homeUitlityBills = [
    ButtonsModel(
        id: 1,
        label: "Electricity\n",
        icon: AppConstants.appimages.electricity,
        actionUrl: Routes.ELECTRICITYVIEW),
    ButtonsModel(
        id: 2,
        label: "LPG\n",
        icon: AppConstants.appimages.lpg,
        actionUrl: Routes.LPGSCREENVIEW),
    ButtonsModel(
        id: 3,
        label: "Muncipal\nServices",
        icon: AppConstants.appimages.muncipalServices,
        actionUrl: Routes.MUNCIPALPAGEVIEW),
    ButtonsModel(
        id: 4,
        label: "Muncipal\nTaxes",
        icon: AppConstants.appimages.muncipalTaxes,
        actionUrl: Routes.MUNCIPALPAGEVIEW),
    ButtonsModel(
        id: 5,
        label: "Water\n",
        icon: AppConstants.appimages.waterbtn,
        actionUrl: Routes.WATERVIEW),
    ButtonsModel(
        id: 6,
        label: "Housing\nSoceity",
        icon: AppConstants.appimages.housingSociety,
        actionUrl: Routes.HOUSINGSCREENVIEW),
    ButtonsModel(
        id: 7,
        label: "Piped Gas\n",
        icon: AppConstants.appimages.gaspipeline,
        actionUrl: Routes.PIPEDGASVIEW
    ),
  ];
  List<ButtonsModel> healthItems = [
    // ButtonsModel(
    //     id: 1,
    //     label: "Hospital\n",
    //     icon: AppConstants.appimages.hospital,
    //     actionUrl: Routes.PAYMENTS),
    ButtonsModel(
        id: 1,
        label: "Hospital\nPathology",
        icon: AppConstants.appimages.hospital,
       actionUrl: Routes.PAYMENTS),
  ];
  List<ButtonsModel> financeItems = [
    ButtonsModel(
        id: 1,
        label: "Credit\nCard",
        icon: AppConstants.appimages.creditcard,
       actionUrl: Routes.CREDITCARDVIEW),
    ButtonsModel(
        id: 2,
        label: "Loan\nRepay",
        icon: AppConstants.appimages.loanrepayment,
       actionUrl: Routes.LOANRUPAYVIEW),
    ButtonsModel(
        id: 3,
        label: "Recurring\nDeposit",
        icon: AppConstants.appimages.recurringdeposite,
       actionUrl: Routes.RECURRINGBILLERSVIEW),
  ];
  List<ButtonsModel> othersItems = [
    ButtonsModel(
        id: 1,
        label: "Subscription\nsubscription",
        icon: AppConstants.appimages.subscription,
       actionUrl: Routes.SUBSCRIPTIONVIEW),
    ButtonsModel(
        id: 2,
        label: "Club\nAssociation",
        icon: AppConstants.appimages.clubassociation,
       actionUrl: Routes.CLUBASSOCIATIONVIEW),
    ButtonsModel(
        id: 3,
        label: "Education\nFees",
        icon: AppConstants.appimages.educationfee,
       actionUrl: Routes.EDUCATIONVIEW),
  ];
  List<ButtonsModel> insuranceItems = [
    ButtonsModel(
        id: 1,
        label: "Life\nInsurance",
        icon: AppConstants.appimages.security,
       actionUrl: Routes.INSURANCEVIEW),
  ];



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  showDashboard() {
    Get.toNamed(Routes.DASHBOARD);
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  updateScreenWidth(context) {
    sc_width = MediaQuery.of(context).size.width;
    sc_height = MediaQuery.of(context).size.height;
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

  showScreen(String screenName) {
    Get.toNamed(screenName);
  }
}
