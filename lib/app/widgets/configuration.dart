class Configuration {
  //static String apiurl = "http://52.66.208.232/v1/";

 static String apiurl2 = "http://3.111.99.46:3000/api/v1/";
 static String apiurl = "http://3.111.99.46:3000/api/v1/";

   //static String baseApiurl = "https://devapi.mykommunity.in/";
  //static String apiurl = "https://devapi.mykommunity.in/v1/";
  //static String apiurl = "https://prodapi.mykommunity.in/v1/";


   static String cities = apiurl2 + 'city/list';
   static String communities = apiurl2 + 'society/list';
   static String userLogin = apiurl2 + 'auth';
   static String newUserRegistration = apiurl2 + '/user/profile';




  //static String cities = apiurl + 'cities/';
  //static String communities = apiurl + 'communities/';
  //static String userLogin = apiurl + 'login/';
  //static String newUserRegistration = apiurl + 'register/';
  static String complaints = apiurl + 'complaints/';
  static String complaintCategories = apiurl + 'complaint-categories/';
  static String flats = apiurl + 'flats/';
  static String fileUpload = apiurl + "photos/";
  static String preApprovedCabs = apiurl + 'pre-approved-cabs/';
  static String preApprovedDelivery = apiurl + 'pre-approved-deliveries/';
  static String preApproveHelperEntry = apiurl + 'pre-approved-visiting-helps/';
  static String preApprovedEntriesFrequest = apiurl + 'frequent-entries/';
  static String visitingHelpCategories = apiurl + 'visiting-help-categories/';
  static String addFamilyMember = apiurl + 'add-resident/';
  static String residences = apiurl + 'residences/';
  static String vehicles = apiurl + 'vehicles/';
  static String notices = apiurl + 'notices/';
  static String approvedguests = apiurl + 'guests/';
  static String preapprovedGuests = apiurl + 'preapprovedguest/';
  static String preapprovedGuestList = apiurl + 'preapprovedguestlist/';
  static String preapprovedGuestinOut = apiurl + 'guestinout/';
  static String deleteGuest = apiurl + 'guests/';
  //static String approvedguests =  apiurl +  'in-outs/';
  static String activities = apiurl + 'activities/';
  static String emergencyContact = apiurl + 'emergency-contact/';
  static String inouts = apiurl + 'in-outs/';
  static String localServicesCategories = apiurl + 'local-service-categories/';
  static String localServices = apiurl + 'local-services/';
  //static String localServices = apiurl + 'household-local-services/';
  static String householdLocalServices = apiurl + 'household-local-services/';
  static String residentsDirectory = apiurl + 'resident-directory/';
  //static String amenities = apiurl + 'amenity/';
  static String amenities = apiurl + 'amenitydetails/';
  static String advertisement = apiurl + 'advertisment/';
  //static String groupchat = apiurl + 'chatapp/';
  static String groupchat = apiurl + 'discussion/';
  static String profile = apiurl + 'profile-photo/';
 //static String profile = apiurl + 'v1/profilephoto/';
  static String notestoGuard = apiurl + 'notetoguard/';
  static String sosalerts = apiurl + 'alert/';
  static String anenitiesclub = apiurl + 'amenities/';

}
