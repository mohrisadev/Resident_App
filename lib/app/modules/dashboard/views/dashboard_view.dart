import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykommunity/app/modules/dashboard/views/dashboard_buttons.dart';
import 'package:mykommunity/app/modules/dashboard/views/quick_activity_view.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';

import 'sidebar_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.sc_width = MediaQuery.of(context).size.width;
    controller.sc_height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: (() => controller.showExitDialog(context)),
        child: GetBuilder<DashboardController>(builder: (controller) {
          return Scaffold(
            floatingActionButton: RotationTransition(
                turns: AlwaysStoppedAnimation(0 / 360),
                child: FloatingActionButton(
                  backgroundColor: AppConstants.appcolors.primaryColor,
                  // shape: ContinuousRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  onPressed: () {
                    Get.toNamed(Routes.QUICK_ACTIVITY);
                  },
                  child: IconButton(
                    icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 100),
                        transitionBuilder: (child, anim) => RotationTransition(
                              turns: child.key ==
                                      ValueKey(controller.activeIconstring)
                                  ? Tween<double>(
                                          begin: controller.astart,
                                          end: controller.aend)
                                      .animate(anim)
                                  : Tween<double>(
                                          begin: controller.bstart,
                                          end: controller.bend)
                                      .animate(anim),
                              child:
                                  FadeTransition(opacity: anim, child: child),
                            ),
                        child: controller.currIndex == 0
                            ? Icon(Icons.add,
                                size: 24, key: const ValueKey('icon1'))
                            : Icon(
                                Icons.close,
                                size: 24,
                                key: const ValueKey('icon2'),
                              )),
                    onPressed: () {
                      controller.updateIndex();
                      Get.toNamed(Routes.QUICK_ACTIVITY);

                      // setState(() {
                      //   _currIndex = _currIndex == 0 ? 1 : 0;
                      // });
                    },
                  ),
                )),

            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // bottomNavigationBar: getBottomNavigationBar(),
            bottomNavigationBar: getAnimatedBottomNavigationBar(controller),

            // appBar: AppBar(
            //   title: Text('DashboardView'),
            //   centerTitle: true,
            // ),
            body: controller.getDashboardView(controller.bottomNavIndex),

            //  Container(
            //     //  height: 180.0,
            //     width: double.infinity,
            //     constraints: BoxConstraints.expand(),
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage(AppConstants.appimages.topBackground),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     child: Column(
            //       children: [
            //         Expanded(
            //             child: Container(
            //                 width: controller.sc_width,
            //                 decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.only(
            //                         topLeft: Radius.circular(25),
            //                         topRight: Radius.circular(25)),
            //                     image: DecorationImage(
            //                       colorFilter: ColorFilter.mode(
            //                           Colors.black.withOpacity(0.05),
            //                           BlendMode.dstATop),
            //                       image: AssetImage(
            //                           AppConstants.appimages.app_logo),
            //                       fit: BoxFit.contain,
            //                     )),
            //                 child: Padding(
            //                     padding: EdgeInsets.all(5),
            //                     child: ListView(
            //                       children: [Text("test")],
            //                     )))),
            //       ],
            //     )),
          );
        }));
  }

  // Widget getTitle() {
  //   return AppConstants.activeFlat!.flatId! > 0
  //       ? TextButton.icon(
  //           icon: Icon(
  //             FontAwesomeIcons.locationDot,
  //             color: Colors.white,
  //             size: 14,
  //           ),
  //           label: Text(
  //             '${AppConstants.activeFlat!.flatNumber!} - ${AppConstants.activeFlat!.communityName!}',
  //             style: AppConstants.appStyles.smallTextwhite,
  //           ),
  //           onPressed: () {},
  //         )
  //       : Text(
  //           AppConstants.appStrings.appName,
  //           style: AppConstants.appStyles.dashboardTitle,
  //         );
  // }

  Widget getBottomNavigationBar() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            splashColor: AppConstants.appcolors.appOrange,
            onTap: () {
              Get.back();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.home),
                Text("Home"), // <-- Text
              ],
            ),
          ),
          InkWell(
            splashColor: AppConstants.appcolors.appOrange,
            onTap: () {
              Get.back();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.people, color: Colors.white,),
                Text("Quick Act"), // <-- Text
              ],
            ),
          ),
          InkWell(
            splashColor: AppConstants.appcolors.appOrange,
            onTap: () {
              Get.back();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.people),
                Text("Household"), // <-- Text
              ],
            ),
          ),
          InkWell(
            splashColor: AppConstants.appcolors.appOrange,
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_city),
                Text("Community"), // <-- Text
              ],
            ),
          ),
        ],
      ),
    );
  }
}
