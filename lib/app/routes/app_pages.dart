import 'package:get/get.dart';
import 'package:mykommunity/app/modules/Amenities/views/clubhouse_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/edit_profile_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/my_account_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/notestoguard_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/settings_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/soscategories_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/soscountdown_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/sospost_view.dart';
import 'package:mykommunity/app/modules/groupchat/views/addgroupchat_view.dart';
import 'package:mykommunity/app/modules/groupchat/views/groupchatmessage_view.dart';
import 'package:mykommunity/app/modules/groupchat/views/groupchatpage_view.dart';
import 'package:mykommunity/app/modules/payments/views/billreceipt.dart';
import 'package:mykommunity/app/modules/payments/views/clubassociation_view.dart';
import 'package:mykommunity/app/modules/payments/views/creditcard_view.dart';
import 'package:mykommunity/app/modules/payments/views/creditcardadd_view.dart';
import 'package:mykommunity/app/modules/payments/views/dth_view.dart';
import 'package:mykommunity/app/modules/payments/views/education_view.dart';
import 'package:mykommunity/app/modules/payments/views/electricity_view.dart';
import 'package:mykommunity/app/modules/payments/views/fasttag_view.dart';
import 'package:mykommunity/app/modules/payments/views/fasttagpage_view.dart';
import 'package:mykommunity/app/modules/payments/views/fasttagpayment_view.dart';
import 'package:mykommunity/app/modules/payments/views/historydetails_view.dart';
import 'package:mykommunity/app/modules/payments/views/insurance_view.dart';
import 'package:mykommunity/app/modules/payments/views/landlinepostpaid_view.dart';
import 'package:mykommunity/app/modules/payments/views/loanrupay_view.dart';
import 'package:mykommunity/app/modules/payments/views/lpgscreen_view.dart';
import 'package:mykommunity/app/modules/payments/views/mobilepostpaid_view.dart';
import 'package:mykommunity/app/modules/payments/views/mobileprepaid_view.dart';
import 'package:mykommunity/app/modules/payments/views/muncipalcorporate_view.dart';
import 'package:mykommunity/app/modules/payments/views/muncipalpage_view.dart';
import 'package:mykommunity/app/modules/payments/views/pipedgas_view.dart';
import 'package:mykommunity/app/modules/payments/views/recurringbillers_view.dart';
import 'package:mykommunity/app/modules/payments/views/selectrecharge_view.dart';
import 'package:mykommunity/app/modules/payments/views/subscription_view.dart';
import 'package:mykommunity/app/modules/payments/views/sundirect_view.dart';
import 'package:mykommunity/app/modules/payments/views/water_view.dart';

import '../data/models/localservice_category.dart';
import '../modules/Amenities/bindings/amenities_binding.dart';
import '../modules/Amenities/views/amenities_view.dart';
import '../modules/Amenities/views/selectamenities_view.dart';
import '../modules/NoticeBoard/bindings/notice_board_binding.dart';
import '../modules/NoticeBoard/views/notice_board_view.dart';
import '../modules/PhoneAuth/bindings/phone_auth_binding.dart';
import '../modules/PhoneAuth/views/onboard_screens_view.dart';
import '../modules/PhoneAuth/views/phone_auth_view.dart';
import '../modules/PhoneAuth/views/welcom_screen_view.dart';
import '../modules/camera/bindings/camera_binding.dart';
import '../modules/camera/bindings/camera_binding.dart';
import '../modules/camera/views/my_camera_view.dart';
import '../modules/camera/views/my_camera_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/allow_frequently_view.dart';
import '../modules/dashboard/views/allow_once_view.dart';
import '../modules/dashboard/views/attendancehistory_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dashboard/views/dbheroview_view.dart';
import '../modules/dashboard/views/get_contact_view.dart';
import '../modules/dashboard/views/home_view.dart';
import '../modules/dashboard/views/house_hold_view.dart';
import '../modules/dashboard/views/newfamilymember_view.dart';
import '../modules/dashboard/views/newpayment_view.dart';
import '../modules/dashboard/views/newvehicle_view.dart';
import '../modules/dashboard/views/paymenthistory_view.dart';
import '../modules/dashboard/views/quick_activity_view.dart';
import '../modules/dashboard/views/vehiclelog_view.dart';
import '../modules/groupchat/bindings/groupchat_binding.dart';
import '../modules/groupchat/views/groupchat_view.dart';
import '../modules/helpdesk/bindings/helpdesk_binding.dart';
import '../modules/helpdesk/views/complaint_categoreis_view.dart';
import '../modules/helpdesk/views/complaint_details_view.dart';
import '../modules/helpdesk/views/emergencynumbers_view.dart';
import '../modules/helpdesk/views/helpdesk_view.dart';
import '../modules/helpdesk/views/heroview_view.dart';
import '../modules/helpdesk/views/post_comment_view.dart';
import '../modules/helpdesk/views/raisecomplaint_view.dart';
import '../modules/helpdesk/views/residents_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/addflat_view.dart';
import '../modules/home/views/block_view.dart';
import '../modules/home/views/cities_view.dart';
import '../modules/home/views/communities_view.dart';
import '../modules/home/views/newuser_view.dart';
import '../modules/home/views/waitingfor_approval_view.dart';
import '../modules/localservice/bindings/localservice_binding.dart';
import '../modules/localservice/views/local_servant_details_view.dart';
import '../modules/localservice/views/local_service_categories_view.dart';
import '../modules/localservice/views/localservice_view.dart';
import '../modules/payments/bindings/payments_binding.dart';
import '../modules/payments/views/boardbrand_view.dart';
import '../modules/payments/views/housingscreen_view.dart';
import '../modules/payments/views/payments_view.dart';
import '../modules/payments/views/rechargeplan_view.dart';
import '../modules/payments/views/watersupply_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARD;

  static final routes = [
    // GetPage(
    //   name: _Paths.HOME,
    //   page: () => HomeView(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.PHONE_AUTH,
      page: () => PhoneAuthView(),
      binding: PhoneAuthBinding(),
    ),

    GetPage(
      name: _Paths.ONBOARD,
      page: () => OnboardScreensView(),
      binding: PhoneAuthBinding(),
    ),

    GetPage(
      name: _Paths.WELCOME_SCREENS,
      page: () => WelcomScreenView(),
      binding: PhoneAuthBinding(),
    ),

    GetPage(
      name: _Paths.CITIES,
      page: () => CitiesView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NEWUSER,
      page: () => NewuserView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.WAITING_FOR_APPROVAL,
      page: () => WaitingforApprovalView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME_DB,
      page: () => HomeView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.QUICK_ACTIVITY,
      page: () => QuickActivityView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SELECTRECHARGEVIEW,
      page: () => SelectRechargeView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ALLOW_ONCE,
      page: () => AllowOnceView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ALLOW_FREQUENTLY,
      page: () => AllowFrequentlyView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.GET_CONTACTS,
      page: () => GetContactView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.ADD_FLAT,
      page: () => AddflatView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.COMMUNITIES,
      page: () => CommunitiesView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.BLOCKLIST,
      page: () => BlockView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HELPDESK,
      page: () => const HelpdeskView(),
      binding: HelpdeskBinding(),
    ),

    GetPage(
      name: _Paths.COMPLAINT_DETAILS,
      page: () => const ComplaintDetailsView(),
      binding: HelpdeskBinding(),
    ),

    GetPage(
      name: _Paths.RAISECOMPLAINT,
      page: () => RaisecomplaintView(),
      binding: HelpdeskBinding(),
    ),

    GetPage(
      name: _Paths.EMERGENCYNUMBERS,
      page: () => EmergencynumbersView(),
      binding: HelpdeskBinding(),
    ),

    GetPage(
      name: _Paths.POST_COMMENT,
      page: () => const PostCommentView(),
      binding: HelpdeskBinding(),
    ),
    GetPage(
      name: _Paths.MYCAMERA,
      page: () => const MyCameraView(),
      binding: CameraBinding(),
    ),

    GetPage(
      name: _Paths.HERO_VIEW,
      page: () => const HeroviewView(),
      binding: CameraBinding(),
    ),

    GetPage(
      name: _Paths.COMPLAINT_CATEGORIES,
      page: () => const ComplaintCategoriesView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.SUNDIRECTVIEW,
      page: () => SundirectView(),
      binding: CameraBinding(),
    ),

    GetPage(
      name: _Paths.RESIDENTS,
      page: () => ResidentsView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.LOCALSERVICE,
      page: () => LocalserviceView(),
      binding: LocalserviceBinding(),
    ),

    GetPage(
      name: _Paths.LOCALSERVICE_CATEGORIES,
      page: () => LocalServiceCategoriesView(),
      binding: LocalserviceBinding(),
    ),

    GetPage(
      name: _Paths.LOCAL_SERVANT_DETAILS,
      page: () => LocalServantDetailsView(),
      binding: LocalserviceBinding(),
    ),
    GetPage(
      name: _Paths.NOTICE_BOARD,
      page: () => NoticeBoardView(),
      binding: NoticeBoardBinding(),
    ),
    GetPage(
      name: _Paths.AMENITIES,
      page: () => AmenitiesView(),
      binding: AmenitiesBinding(),
    ),
    GetPage(
      name: _Paths.SELECTAMENITIES,
      page: () => SelectAmenitiesView(),
      binding: AmenitiesBinding(),
    ),
    GetPage(
      name: _Paths.CLUBHOUSE,
      page: () => ClubHouseView(),
      binding: AmenitiesBinding(),
    ),
    // GetPage(
    //   name: _Paths.HOUSE_HOLD,
    //   page: () => HouseHoldView(),
    //   binding: HouseHoldBinding(),
    // ),
    GetPage(
      name: _Paths.PAYMENTS,
      page: () => PaymentsView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.MOBILEPREPAID,
      page: () => MobilePrepaidView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.MOBILEPOSTPAID,
      page: () => MobilePostPaidView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.BRODBRAND,
      page: () => BoardBrandView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.DTHVIEW,
      page: () => DthView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.ELECTRICITYVIEW,
      page: () => ElectricityView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.LPGSCREENVIEW,
      page: () => LpgScreenView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.PIPEDGASVIEW,
      page: () => PipedgasView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.HISTORYDETAILS,
      page: () => HistoryDetailsView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.BILLRECEIPT,
      page: () => BillreceiptView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.FASTTAGVIEW,
      page: () => FasttagView(),
      binding: PaymentsBinding(),
    ),
GetPage(
      name: _Paths.FASTTAPAGEGVIEW,
      page: () => FastTagPageView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.FASTTAGPAYMENTVIEW,
      page: () => FastTagPaymentView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.LANDLINEPOSTPAID,
      page: () => LandlinePostpaidView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.WATERVIEW,
      page: () => WaterView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.WATERSUPPLYVIEW,
      page: () => WaterSupplyView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.MUNCIPALPAGEVIEW,
      page: () => MuncipalPageView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.MUNCIPALCORPORATEVIEW,
      page: () => MuncipalCorporateView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTIONVIEW,
      page: () => SubscriptionView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.LOANRUPAYVIEW,
      page: () => LoanRupayView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.CREDITCARDVIEW,
      page: () => CreditcardView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.RECURRINGBILLERSVIEW,
      page: () => RecurringBillersView(),
      binding: PaymentsBinding(),
    ),GetPage(
      name: _Paths.EDUCATIONVIEW,
      page: () => EducationView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.CLUBASSOCIATIONVIEW,
      page: () => ClubAssociationView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.INSURANCEVIEW,
      page: () => InsuranceView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.CREDITCARDADDVIEW,
      page: () => CreditcardAddView(),
      binding: PaymentsBinding(),
    ),

    GetPage(
      name: _Paths.NEW_FAMILY_MEMBER,
      page: () => NewfamilymemberView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.PAYMENT_HISTORY,
      page: () => PaymenthistoryView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOUSINGSCREENVIEW,
      page: () => HousingScreenView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.NEW_PAYMENT_PAGE,
      page: () => NewpaymentView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.ATTENDENCE_HISTORY,
      page: () => AttendancehistoryView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.NEW_VEHICLE,
      page: () => NewvehicleView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.DB_HERO_VIEW,
      page: () => DbheroviewView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.VEHICLE_LOG,
      page: () => VehiclelogView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.GROUPCHAT,
      page: () => const GroupchatpageView(),
      binding: GroupchatBinding(),
    ),
    GetPage(
      name: _Paths.GROUPCHATMESSAGEVIEW,
      page: () => const GroupchatMessageView(),
      binding: GroupchatBinding(),
    ),
    GetPage(
      name: _Paths.ADDGROUPCHAT,
      page: () => const AddGroupchatView(),
      binding: GroupchatBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.MYACCOUNT,
      page: () => MyAccountView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGEPLAN,
      page: () => RechargePlanView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => EditProfileView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.NOTESTOGUARD,
      page: () => NotestoguardView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.SOSCATEGORIES,
      page: () => SoscategoriesView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.SOSCOUNTDOWN,
      page: () => SoscountdownView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.POST_SOS_ALERT,
      page: () => SospostView(),
      binding: DashboardBinding(),
    ),

    // GetPage(
    //   name: _Paths.AMENITIESCLUB,
    //   page: () => SelectAmenitiesView(),
    //   binding: DashboardBinding(),
    // ),
  ];
}
