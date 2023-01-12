import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../../../widgets/sizeconfig.dart';
import '../controllers/phone_auth_controller.dart';

class OnboardScreensView extends GetView<PhoneAuthController> {
  const OnboardScreensView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<PhoneAuthController>(builder: (controller) {
      controller.updateShowMessage();
      return Scaffold(
          body: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                      image: AssetImage(
                        AppConstants.appimages.background,
                      ))),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AnimatedPositioned(
                    width: SizeConfig.screenWidth,
                    duration: const Duration(seconds: 2),
                    curve: Curves.bounceInOut,
                    top: controller.showMessage ? 80 : 220,
                    child: getBouncingCircleImage(),
                  ),
                  AnimatedPositioned(
                    width: SizeConfig.screenWidth,
                    duration: const Duration(seconds: 2),
                    curve: Curves.slowMiddle,
                    top: controller.showMessage
                        ? SizeConfig.screenHeight! / 2
                        : 500,
                    child: mideleText(),
                  ),
                  AnimatedPositioned(
                    width: SizeConfig.screenWidth,
                    duration: const Duration(seconds: 2),
                    curve: Curves.decelerate,
                    bottom: controller.showMessage ? 80 : 120,
                    child: bottomButtom(),
                  ),
                ],
              )));
    });
  }

  Widget mideleText() {
    return Column(
      children: [
        Text("My Kommunity\nApp",
            textAlign: TextAlign.center,
            style: AppConstants.appStyles.onboardHead),
        Text(
          "Manage Guests, Visitor, Parcel\n and Helper.",
          textAlign: TextAlign.center,
          style: AppConstants.appStyles.onboardText,
        ),
      ],
    );
  }

  Widget bottomButtom() {
    return Center(
        child: IconButton(
      icon: Image.asset(
        AppConstants.appimages.onboardBtn,
      ),
      iconSize: 70,
      onPressed: () {
        Get.offAndToNamed(Routes.WELCOME_SCREENS);
      },
    ));
  }

  Widget getBouncingCircleImage() {
    return Center(
        child: IconButton(
      icon: Image.asset(
        AppConstants.appimages.onboardLogo,
      ),
      iconSize: 250,
      onPressed: () {},
    ));
  }

  // Widget getBouncingCircleImage() {
  //   return Center(
  //       child: CircleAvatar(
  //           radius: 150,
  //           backgroundColor: AppConstants.appcolors.primaryColor,
  //           child: CircleAvatar(
  //             radius: 144,
  //             backgroundColor: Colors.white,
  //             child: Padding(
  //               padding: const EdgeInsets.all(5.0), // Border radius
  //               child: CircleAvatar(
  //                   radius: 100,
  //                   child: Image.asset(
  //                     AppConstants.appimages.app_logo,
  //                     fit: BoxFit.fitHeight,
  //                   )),
  //             ),
  //           )));
  // }
}
