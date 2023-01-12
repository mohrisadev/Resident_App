import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/data/models/active_flat_model.dart';

class _Images {
  final String app_logo = "assets/images/app_logo.png";
  final String topBackground = "assets/images/mainheader.png";
  final String home = "assets/images/home.png";
  final String loading = "assets/images/loading.json";
  final String intro_page_logo = "assets/images/intrologo.jpeg";
  final String lightBackground = "assets/images/light.jpeg";
  final String darkBackground = "assets/images/dark.jpeg";
  final String splahlogo = "assets/images/splash.png";
  final String cab = "assets/images/cab.png";
  final String delivery = "assets/images/delivery.png";
  final String bike = "assets/images/bike.jpg";
  final String cabsvg = "assets/images/svg/cab.svg";
  final String deliverysvg = "assets/images/svg/delivery.svg";
  final String visitorsvg = "assets/images/svg/visitor.svg";
  final String cabpng = "assets/images/svg/cab.png";
  final String deliverypng = "assets/images/svg/delivery.png";
  final String visitorpng = "assets/images/svg/visitor.png";
  final String visitorCircle = "assets/images/custom/visitor.png";
  final String cabCircle = "assets/images/custom/cab.png";
  final String deliveryCircle = "assets/images/custom/delivery.png";
  final String visitingHelpCircle = "assets/images/custom/visitinghelp.png";
  final String phonebook = "assets/images/phonebook.png";
  final String visitinghelp = "assets/images/visitinghelpdb.png";
  final String notetoguard = "assets/images/notestoguard.png";
  final String sos = "assets/images/sos.png";
  final String onboardLogo = "assets/images/custom/onboardlogo.png";
  final String background = "assets/images/custom/background.png";
  final String onboardBtn = "assets/images/custom/btn.png";
  final String vector1 = "assets/images/custom/Vector1.png";
  final String vector2 = "assets/images/custom/Vector2.png";
  final String vector3 = "assets/images/custom/Vector3.png";
  final String helpdesk = "assets/images/custom/helpdesk.png";
  final String directory = "assets/images/custom/directory.png";
  final String emergency = "assets/images/custom/emergency.png";
  final String localservice = "assets/images/custom/localservicemenu.png";
  final String noticeboard = "assets/images/custom/noticeboard.png";
  final String groupchat = "assets/images/custom/groupchat.png";
  final String utilitypayments = "assets/images/custom/utilitypayments.png";
  final String residentamenities = "assets/images/custom/residentamenities.png";

  /*button icons*/
  final String adddailyhelpbtn = "assets/images/buttonimages/adddailyhlep.png";
  final String preapprovebtn = "assets/images/buttonimages/pre-approved.png";
  final String clockbtn = "assets/images/buttonimages/clock.png";
  final String peoplebtn = "assets/images/buttonimages/peoplebtn.png";
  final String waterbtn = "assets/images/buttonimages/Water.png";
  final String sampleimage = "assets/images/buttonimages/sampleimage.png";
  final String bharatpaylogo = "assets/images/buttonimages/bharatpaylogo.png";
  final String mobileprepaid = "assets/images/buttonimages/mobileprepaid.png";
  final String mobilepostpaid = "assets/images/buttonimages/mobilepostpaid.png";
  final String broadband = "assets/images/buttonimages/broadband.png";
  final String dth = "assets/images/buttonimages/dth.png";
  final String cabletv = "assets/images/buttonimages/cabletv.png";
  final String landlinePostpaid = "assets/images/buttonimages/LandlinePostpaid.png";
  final String fastag = "assets/images/buttonimages/Fastag.png";
  final String pathlogy = "assets/images/buttonimages/Pathlogy.png";
  final String creditcard = "assets/images/buttonimages/CreditCard.png";
  final String hospital = "assets/images/buttonimages/Hospital.png";
  final String loanrepayment = "assets/images/buttonimages/LoanRepayment.png";
  final String recurringdeposite = "assets/images/buttonimages/RecurringDeposit.png";
  final String subscription = "assets/images/buttonimages/Subscription.png";
  final String clubassociation = "assets/images/buttonimages/Club&Associates.png";
  final String educationfee = "assets/images/buttonimages/EducationFee.png";
  final String security = "assets/images/buttonimages/security.png";
  final String electricity = "assets/images/buttonimages/electricity.png";
  final String gaspipeline = "assets/images/buttonimages/gaspipeline.png";
  final String housingSociety = "assets/images/buttonimages/HousingSociety.png";
  final String lpg = "assets/images/buttonimages/LPG.png";
  final String muncipalTaxes = "assets/images/buttonimages/MuncipalTaxes.png";
  final String muncipalServices = "assets/images/buttonimages/MuncipalServices.png";
  final String bblogotop = "assets/images/custom/bblogotop.png";
  final String contacts = "assets/images/custom/contacts.png";
  final String ahmedabad = "assets/images/cities/ahmedabad.png";
  final String amritsar = "assets/images/cities/amritsar.png";
  final String bangalore = "assets/images/cities/bangalore.png";
  final String delhi = "assets/images/cities/delhi.png";
  final String hyderabad = "assets/images/cities/hyderabad.png";
  final String mumbai = "assets/images/cities/mumbai.png";

  //sos images
  final String one = "assets/images/sosimages/1.png";
  final String two = "assets/images/sosimages/2.png";
  final String three = "assets/images/sosimages/3.png";
  final String fire = "assets/images/sosimages/fire.png";
  final String lift = "assets/images/sosimages/lift.png";
  final String medical = "assets/images/sosimages/medical.png";
  final String thief = "assets/images/sosimages/thief.png";
  final String other = "assets/images/sosimages/other.png";
}

class _AppIcons {
  final IconData inr = FontAwesomeIcons.rupeeSign;
}

enum CaptureType { Camera, Gallery }

class _Colors {
  final Color blue = Color.fromRGBO(55, 122, 222, 1);
  final Color greenButton = Color.fromRGBO(146, 210, 78, 1);
  final Color homeBackground = Color.fromRGBO(118, 202, 249, 1);
  final Color darkOrange = Color.fromARGB(255, 240, 89, 2);
  //final Color primaryColor = Color.fromARGB(1, 48, 42, 406); // color #302A6A
  //final Color primaryColor = Color(0xFF302A6A);
  final Color primaryColor = Color(0xFF202151);
  final Color secondrayColor = Color(0xFF302A6A);
  final Color appPincColor = Color(0xFFBC10D9);
  final Color appOrange = Color(0xFFEA6733); //Color.fromARGB(234, 103, 51, 1);
  final Color appWhite = Colors.white;
  final Color? primaryColorold = Colors.purple[400];
  final Color babyblue = Color.fromRGBO(231, 246, 252, 1);
  final Color teallite = Color.fromRGBO(2, 132, 118, 1);
  final Color darkpurple = Color(0xFF230F87);
  final Color lightpurple = Color(0xFFAD5ED3);
  final Color? textBlue = Colors.blue[900];
  final Color? generalTextColor = Color(0xFF595588);
  final Color? appgrey = Color.fromARGB(153, 57, 58, 58);

  final Color? appredcolor = Color(0xFFE23744);
}

enum AppState { Idle, Busy }

class AppConstants {
  static BuildContext? appContext;
  static final appcolors = _Colors();
  static final appimages = _Images();
  static final appIcons = _AppIcons();
  static final appStrings = _AppStrings();
  static final appStyles = _AppStyles();
  static ActiveFlatModel? activeFlat;
}

class _AppStrings {
  final String fcmKeypair =
      "BI0M4Sz1Hxgt2bbklZuTbbmTI96uh0RY0NFQK7pU9n-YLqLbVBVukKX-LvcVyIfVUbWS_brwBR5SqPP-rNafYjQ";

  final String appName = "My Kommunity";
  final String splashlines = "Secure, Safe and Happy";
  final String helpdesk = "Help Desk";
  final String approvedGuests = "Approved Guests";
  final String emergencyContacts = "Emergency Contacts";
  final String settings = "Settings";
  final String complaints = "Complaints";
  final String raiseAcomplaint = "Raise a Complaint";
  final String complaintDetails = "Complaint Details";

  final String residents = "Residents";

  final String confirm = "Confirm";
  final String show = "Show";
  final String ok = "Ok";

  final String cancel = "Cancel";
  final String security = "Security";
  final String cities = "Select City";
  final String communities = "Select Community";
  final String block = "Select Block";

  //Bottombar menu items

  final String home = "Home";
  final String activity = "Activity";
  final String nodata = "No data available";
  final String noComplaints = "You have not raised any complaint";
  final String noresidents = "No Residents";
  final String noFlat =
      "No flats mapped with this device.\n Add Flat / Villa now.";
  final String nonoticeboarditems = "No notices";
  final String noguests = "No approved guests";
  final String noCategories = "No categories";
  final String noLocalService = "No local services";

  //settings page
  final String addflat = "Add Flat / Villa";
  final String selectFlat = "Select Flat";

  String selectedCity = 'city';
  int selectedCityId = 0;

  String selectedCommunity = '-';
  int selectedCommunityID = 0;

  int selectedBlockId = 0;
  String selectedBlock = '-';

  int selectedflatId = 0;
  String selectedflat_number = '-';

  int selectedBottomTab = 2;
  String lastRoute = "";
}

enum SubCategoriesEnum { Complaint, Request }

enum ComplaintType { Personal, Community }

enum VisitorTypeEnum { DELIVERY, CAB, VISITING_HELP }

class _AppStyles {
  TextStyle dashboardSideHeadText = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.primaryColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle screenTitle = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 14,
      letterSpacing: 0.25,
      color: Colors.white,
      fontWeight: FontWeight.w500);

  TextStyle smallTextwhite = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: Colors.white);

  TextStyle listTileHead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.primaryColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle generalText = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 12,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.generalTextColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle iconButtonText = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 12,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.primaryColor,
    fontWeight: FontWeight.w500,
  );
  TextStyle textweight500 = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.primaryColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle textweight600 = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.primaryColor,
    fontWeight: FontWeight.w900,
  );
  TextStyle sidehead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.2,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  TextStyle buttonUnderLineText = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 11,
      decoration: TextDecoration.underline,
      letterSpacing: 0.2,
      color: AppConstants.appcolors.primaryColor,
      fontWeight: FontWeight.w400);

  TextStyle menuSidehead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 18,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.primaryColor,
    fontWeight: FontWeight.bold,
  );

  TextStyle quickActiveListItem = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 14,
      letterSpacing: 0.2,
      color: AppConstants.appcolors.primaryColor,
      fontWeight: FontWeight.w700);
      TextStyle sideheadblue = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 14,
      letterSpacing: 0.2,
      color: Colors.blue[900],
      fontWeight: FontWeight.bold,
    );

  TextStyle loginTitle = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 36,
      letterSpacing: 0.25,
      color: Colors.white);

  TextStyle mediumPrimaryhead = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 26,
      letterSpacing: 0.25,
      color: AppConstants.appcolors.primaryColor);

  TextStyle mediumPagetitle = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 22,
      letterSpacing: 0.25,
      color: Colors.white);

  TextStyle loginpageSidehead = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 22,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  TextStyle sideheadorange = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.2,
    color: AppConstants.appcolors.appOrange,
    fontWeight: FontWeight.bold,
  );
  TextStyle errorText = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.25,
    color: Colors.purple[400],
  );
  TextStyle sideheadwhite = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.2,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  TextStyle bottomSheetTitle = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 17,
    letterSpacing: 0.2,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  TextStyle quickactions = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    letterSpacing: 0.3,
    color: Colors.black,
    // fontWeight: FontWeight.bold,
  );
  TextStyle nameHead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 20,
    letterSpacing: 0.3,
    color: Colors.black,
  );

  TextStyle complaintHead = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      letterSpacing: 0.4,
      color: AppConstants.appcolors.primaryColor);

  TextStyle onboardHead = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 26,
      letterSpacing: 0.4,
      color: AppConstants.appcolors.primaryColor);

  TextStyle onboardText = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 17,
      letterSpacing: 0.3,
      color: AppConstants.appcolors.primaryColor);
  TextStyle datehead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    letterSpacing: 0.3,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  TextStyle titleStrongHead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 24,
    letterSpacing: 0.25,
    color: Colors.white,
  );

  TextStyle complaintTitle = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.25,
    color: Colors.black,
  );

  TextStyle smallpageTitle = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  TextStyle frequentlytitleWhite = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.25,
    color: Colors.white,
  );
  TextStyle dashboardTitle = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  TextStyle drawerHead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 18,
    letterSpacing: 0.2,
    color: Colors.black,
  );
  TextStyle titledarkhead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 19,
    letterSpacing: 0.2,
    color: Colors.black,
  );
  TextStyle flatHead = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 15,
    letterSpacing: 0.2,
    color: Colors.black,
  );

  TextStyle smallTextgrey = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: Colors.grey[500]);

  TextStyle smallTextbs = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 13,
    letterSpacing: 0.25,
  );

  TextStyle tilesidehead = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 16,
      letterSpacing: 0.25,
      color: Colors.black);

  TextStyle phoneNumberWhite = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 18,
      letterSpacing: 0.25,
      color: Colors.white,
      fontWeight: FontWeight.bold);
  TextStyle phoneNumberText = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 18,
      letterSpacing: 0.25,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  TextStyle smallText = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.25,
      color: Colors.black);

  TextStyle username = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 19,
      letterSpacing: 0.2,
      color: Colors.black,
      fontWeight: FontWeight.w800);

  TextStyle messageText = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 17,
      letterSpacing: 0.2,
      color: Colors.black,
      fontWeight: FontWeight.w500);

  TextStyle hintTopbar = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.25,
      color: Colors.white);

  TextStyle smallSideheadorange = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 12,
      letterSpacing: 0.20,
      color: AppConstants.appcolors.darkOrange,
      fontWeight: FontWeight.bold);

  TextStyle smallTextDialog = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.2,
      color: Colors.black);

  TextStyle smallSidehead = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 12,
      letterSpacing: 0.25,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  TextStyle tileText = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 12,
      letterSpacing: 0.25,
      color: Colors.black);

  TextStyle emergencyContact = GoogleFonts.montserrat(
      fontStyle: FontStyle.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: Colors.black);
  TextStyle medium = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: Colors.black);
  TextStyle defaulttext = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 9,
      letterSpacing: 0.1,
      color: Colors.black);
  TextStyle selectedItem = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 9,
      letterSpacing: 0.1,
      color: Colors.white);

  TextStyle smallTextblue = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 11,
      letterSpacing: 0.25,
      color: AppConstants.appcolors.primaryColor);

  TextStyle smallTextPrimary = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 14,
      letterSpacing: 0.25,
      color: AppConstants.appcolors.primaryColor,
      fontWeight: FontWeight.w500);

  TextStyle smallTextOrange = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 14,
      letterSpacing: 0.25,
      color: AppConstants.appcolors.appOrange,
      fontWeight: FontWeight.w500);

  TextStyle smallTextGreen = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 14,
      letterSpacing: 0.25,
      color: AppConstants.appcolors.teallite,
      fontWeight: FontWeight.w500);

  TextStyle smallTextorange = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.25,
    color: AppConstants.appcolors.primaryColor,
    decoration: TextDecoration.underline,
  );

  TextStyle commentText = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontSize: 16,
      letterSpacing: 0.25,
      color: Colors.black);
  TextStyle smallTextred = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 12,
    letterSpacing: 0.25,
    color: Colors.red[900],
  );

  TextStyle commentsSection = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      letterSpacing: 0.25,
      color: AppConstants.appcolors.appOrange);
  TextStyle formsFieldsText = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 13,
    letterSpacing: 0.2,
    color: Colors.black,
    //  decoration: TextDecoration.underline,
  );

  TextStyle buttonText = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  TextStyle buttonTextBold = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  TextStyle statuApproved = GoogleFonts.poppins(
    fontStyle: FontStyle.normal,
    fontSize: 18,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500,
    color: Colors.green,
  );
}
