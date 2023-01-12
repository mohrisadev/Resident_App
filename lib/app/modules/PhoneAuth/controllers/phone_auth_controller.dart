import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../services/push_notification_service.dart';
import '../../../data/models/active_flat_model.dart';
import '../../../data/models/fb_uid_token.dart';
import '../../../widgets/app_widgets.dart';
import '../../../widgets/configuration.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneAuthController extends GetxController {
  bool isValid = false;
  double sc_width = 0.0;
  double sc_height = 0.0;
  String errmsg = "";
  bool agree = true;
  bool showMessage = false;
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phone = TextEditingController();
  final otpcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? verificationId;
  bool showLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  String countryCode = "+91";
  final count = 0.obs;
  StreamController<ErrorAnimationType>? errorController;
  String TitleText = "Login";
  @override
  void onInit() {
    getCurrentUser();
    // setPinState();
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

  updateContryCode(String code) {
    countryCode = code;
    update();
  }

  updateTtile() {
    if (currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE) {
      TitleText = "Login";
      update();
    } else {
      TitleText = "OTP Verification";
      update();
    }
  }

  updateShowMessage() {
    Future.delayed(Duration(microseconds: 300), () {
      showMessage = true;
      update();
    });
  }
  getCurrentUser() async {
    final User? _user = _auth.currentUser;
    user = _user;
    if (user != null) {
      user!.getIdToken().then((val) {
        String firebaseToken;
        firebaseToken = val.toString();
        FBUidToken _user =
        FBUidToken(firebaseToken: firebaseToken, mobileNumber: user!.phoneNumber);
        verifyPhone(_user);
      });
    }
  }

  // verifyPhone(FBUidToken _user) {
  //   var controller = context.read<AuthController>();
  //   if (controller.isLogin) controller.verifyPhone(_user);
  //   // else
  //   //   controller.userRegistation(user: _user);

  //   return;
  // }

  Future<String> verifyPhone(FBUidToken user) async {
    var preference = await SharedPreferences.getInstance();
    String token = "";
    bool isNewUser;
    print("ABAXX");
    //print(user.fb_phone);
    //print(user.fb_token);
    //print(user.fb_uid);
    //print(jsonDecode(user));
    //print(jsonDecode.user);
    //var json = jsonDecode(myJSON);

    var connectivityResult = await (Connectivity().checkConnectivity());

    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var responce = await http.post(
          Uri.parse(Configuration.userLogin),

          headers: {
            "Content-Type": "application/json",
          },
         // body: json.encode({"fb_uid": user.fb_uid, "fb_token": user.fb_token},
            body: json.encode({"mobileNumber": user.mobileNumber, "firebaseToken": user.firebaseToken},
          ),
        );
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          //print(responce.body);
          preference.setString("mobileNumber", user.mobileNumber!);
          isNewUser = json.decode(responce.body)["result"]["new_user"];
          var flat_id = json.decode(responce.body)["result"]["flat_id"];
          if (isNewUser) {
            //navigateRemoveHistory(page: router.Registration);
            Get.offAndToNamed(Routes.NEWUSER);
          } else if (!isNewUser && flat_id == "") {
            token = json.decode(responce.body)["result"]["token"];
            print(token);
            if (Platform.isIOS || Platform.isAndroid)
              await PushNotificationService().initialise();
            preference.setString("token", json.decode(responce.body)["result"]["token"]);
            print("token ${json.decode(responce.body)["result"]["token"]}");
            // preference.setInt(
            //    "flatId", json.decode(responce.body)["result"]["flat_id"]);
            //navigateRemoveHistory(page: router.Cities);
            //Get.offAndToNamed(Routes.Cities)
            Get.offAndToNamed(Routes.CITIES);
          } else if (!isNewUser && flat_id != "") {
            token = json.decode(responce.body)["result"]["token"];
            print("token $token");
            if (Platform.isIOS || Platform.isAndroid)
              await PushNotificationService().initialise();
            preference.setString(
                "token", json.decode(responce.body)["result"]["token"]);
            preference.setInt(
                "flatId", json.decode(responce.body)["result"]["flat_id"]);
            preference.setInt("communityID",
                json.decode(responce.body)["result"]["community_id"]);
            AppConstants.activeFlat = ActiveFlatModel.fromJson(json.decode(responce.body)["result"]);

            //navigateRemoveHistory(page: router.Dashboard);// getListofReidences
            Get.offAndToNamed(Routes.DASHBOARD);
          }
        } else {
          //show error
          // appResponse(
          //     msg: json.decode(responce.body)["responseException"]
          //         ["exceptionMessage"]);
        }
      } else {
        //appResponse(msg: "Please check your internet connection");
      }
    } catch (e) {
      //setAppState(AppState.Idle);
    }
    //setAppState(AppState.Idle);
    return token;
  }

  getLoggedinUser() async {}

  validate() async {
    //print("in validate : ${phone.text.length}");
    if (phone.text.length == 10 && agree) {
      isValid = true;
      showLoading = false;
      update();
    } else {
      isValid = false;
      update();
    }
  }

  setPinState() {
    CustomFullScreenDialog.cancelDialog();
    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
    //update();
    updateTtile();
  }

  verifyNumber(BuildContext context) async {
    CustomFullScreenDialog.showDialog();
    setPinState();

    if (!kIsWeb) {
      await _auth.verifyPhoneNumber(
        //timeout: Duration(seconds: 60),
        phoneNumber: "+91" + phone.text,
        verificationCompleted: (phoneAuthCredential) async {
          //signinwithPCredentials(); //
          showLoading = false;
          update();
          signInWithPhoneAuthCredential(phoneAuthCredential);
        },
        verificationFailed: (verificationFailed) async {
          CustomFullScreenDialog.cancelDialog();
          showErrorToast(verificationFailed.message);
        },
        codeSent: (verificationId, resendingToken) async {
          showLoading = false;
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } else {
      showLoading = false;

      final confirmationResult =
          await _auth.signInWithPhoneNumber("+91${phone.text}");
      final smsCode = await getSmsCodeFromUser(context);
      if (smsCode != null) {
        await confirmationResult.confirm(smsCode).then((uc) {
          if (uc.user != null) {
            //getActiveUser("+91${phone.text}");
          }
        });
      }
    }
  }

  Future<String?> getSmsCodeFromUser(context) async {
    String? smsCode;

    // Update the UI - wait for the user to enter the SMS code
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('SMS code:'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Sign in'),
            ),
            OutlinedButton(
              onPressed: () {
                smsCode = null;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                smsCode = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
          ),
        );
      },
    );

    return smsCode;
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      CustomFullScreenDialog.showDialog();
      await _auth
          .signInWithCredential(phoneAuthCredential)
          .then((authCredential) async {
        if (authCredential.user != null) {
          await authCredential.user!.getIdToken().then((val) {
            String firebaseToken;
            firebaseToken = val.toString();
            FBUidToken _user = FBUidToken(
                firebaseToken: firebaseToken,
               // fb_uid: authCredential.user!.uid,
                mobileNumber: authCredential.user!.phoneNumber);
                verifyPhone(_user);
          });

          otpcontroller.text = "";
          currentText = "";

          //VERIFY WHETHER USER EXITS AND DATA IS PRESENT OR NOT.
          //IF DATA IS PROPERLY ENTERED ALLOW TO SEE DASHBOAR
          //OR SHOW USER CREATION SCREEN.
          //;
          String mbl;
          mbl = "+91" + phone.text;
          //getActiveUser(mbl);

          //await isUserExists(mbl) == true ? getActiveUser(mbl) : movetoHome();

        } else {
          update();
          errmsg = "Please verify your pin";
          showErrorToast("Please verify your pin");
        }

        //   Navigator.push(
        //            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      });
    } on FirebaseAuthException catch (e) {
      otpcontroller.text = "";
      currentText = "";
      showLoading = false;
      errmsg = "Please verify your pin";
      CustomFullScreenDialog.cancelDialog();
      update();

      showErrorToast(e.message);
      return;
      // _scaffoldKey.currentState
      //     .showSnackBar(SnackBar(content: Text(e.message)));

    }
  }

  Future<bool> isUserExists(String mobile) async {
    return true;
  }

  getActiveUser(String mobile) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var fbtoken = await firebaseMessaging.getToken();

    // await FirebaseFirestore.instance
    //     .collection('appusers')
    //     .where('Mobile', isEqualTo: mobile)
    //     .limit(1)
    //     .get()
    //     .then((value) {
    //   if (value.docs.isNotEmpty) {
    //     ActiveUserValues.activeUser = AppUserModel.fromSnapshot(value.docs[0]);
    //     firebaseFirestore
    //         .collection("appusers")
    //         .doc(ActiveUserValues.activeUser.docId)
    //         .set({
    //       "FbToken": fbtoken,
    //     }, SetOptions(merge: true)).catchError((error) {
    //       CustomFullScreenDialog.cancelDialog();
    //       CustomSnackBar.showSnackBar(
    //           context: Get.context,
    //           title: "Error",
    //           message: error,
    //           backgroundColor: Colors.red);
    //     });

    //     Get.toNamed(Routes.HOME);
    //   }
    // });
  }

  movetoHome() {
    showLoading = false;
    update();
    //Get.offAllNamed(Routes.NEW_USER);
  }

  signinwithPCredentials() {
    // showLoading = false;
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
    verificationId: verificationId!, smsCode: currentText);
    signInWithPhoneAuthCredential(phoneAuthCredential);
    update();
  }

  onPinchange(value) {
    currentText = value;
    update();
  }

  setFormState() {
    CustomFullScreenDialog.cancelDialog();
    currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
    update();
  }
  void updateAgree() {
    agree = agree == true ? false : true;
    validate();
    update();
  }
}
