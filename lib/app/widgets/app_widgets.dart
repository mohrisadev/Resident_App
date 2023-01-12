import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../shared/appconstants.dart';
import '../data/models/buttons_model.dart';

void showErrorToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      //timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}

getCompanyImageUrl(String company) {
  switch (company.toString().toLowerCase().trim()) {
    case 'uber':
      return "https://devapi.mykommunity.in/photos/logo/uber_OkSnXOO.png";
    case 'ola':
      return "https://devapi.mykommunity.in/photos/logo/ola.jpg";
    case 'jio_mart':
      return "https://devapi.mykommunity.in/photos/logo/jiomart.png";
    case 'dtdc':
      return "https://devapi.mykommunity.in/photos/logo/dtdc.jpg";
    case 'delhivery':
      return "https://devapi.mykommunity.in/photos/logo/delhivery.jpg";
    case 'messho':
      return "https://devapi.mykommunity.in/photos/logo/messho.png";
    case 'snap_deal':
      return "https://devapi.mykommunity.in/photos/logo/Snapdeal.jpg";

    case 'flipkart':
      return "https://devapi.mykommunity.in/photos/logo/flipkart.png";

    case 'amazon':
      return "https://devapi.mykommunity.in/photos/logo/amazon.jpg";

    case 'myntra':
      return "https://devapi.mykommunity.in/photos/logo/myntra.png";

    default:
      return "https://dummyimage.com/60";
  }
}

Widget dynamicWidget(ButtonsModel btn, ctrl) {
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: InkWell(
        splashColor: AppConstants.appcolors.appOrange,
        onTap: () {
          ctrl.showScreen(btn.actionUrl);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 60.0,
                width: 60.0,
                color: Colors.white,
                child: Center(
                    child: Image.asset(
                  btn.icon!,
                  fit: BoxFit.fill,
                ))),

            Text(
              btn.label!,
              style: AppConstants.appStyles.iconButtonText,
              textAlign: TextAlign.center,
            ), // <-- Text
          ],
        )),
  );
}

Widget paymentScreenButtons(ButtonsModel btn, ctrl) {
  return Padding(
    padding: EdgeInsets.all(5.0),
    child: InkWell(
        splashColor: AppConstants.appcolors.appOrange,
        onTap: () {
          ctrl.showScreen(btn.actionUrl);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 60.0,
                color: Colors.white,
                child: Center(
                    child: Image.asset(
                  btn.icon!,
                  fit: BoxFit.fill,
                ))),

            Text(
              btn.label!,
              style: AppConstants.appStyles.iconButtonText,
              textAlign: TextAlign.center,
            ), // <-- Text
          ],
        )),
  );
}

class CustomSnackBar {
  static void showSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        messageText: Text(
          message,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        colorText: Colors.white,
        borderRadius: 8,
        margin: EdgeInsets.all(16));
  }
}

class CustomFullScreenDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Color(0xff141A31).withOpacity(.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}
