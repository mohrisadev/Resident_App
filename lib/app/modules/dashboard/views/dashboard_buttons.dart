import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../../../routes/app_pages.dart';

Widget noticeViewAllButton() {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
          splashColor: AppConstants.appcolors.appOrange,
          onTap: () {
            Get.toNamed(Routes.NOTICE_BOARD);
          },
          child: Text(
            "See All >",
            style: AppConstants.appStyles.buttonUnderLineText,
          )));
}

Widget recentActivitesViewAllButton(controller) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
          splashColor: AppConstants.appcolors.appOrange,
          onTap: () {
            controller.updateBottomIndex(1);
          },
          child: Text(
            "View All >",
            style: AppConstants.appStyles.buttonUnderLineText,
          )));
}

Widget manageHouseHoldButton(controller) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        color: Colors.grey.shade100,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: TextButton.icon(
          onPressed: () {
            controller.updateBottomIndex(2);
          },
          icon: Image.asset(
            AppConstants.appimages.peoplebtn,
            fit: BoxFit.fill,
          ),
          label: Text(
            "Manage Household",
            style: AppConstants.appStyles.iconButtonText,
          )));
}

Widget viewRecentActivitesButton(controller) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        color: Colors.grey.shade100,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: TextButton.icon(
          onPressed: () {
            controller.updateBottomIndex(1);
          },
          icon: Image.asset(
            AppConstants.appimages.clockbtn,
            fit: BoxFit.fill,
          ),
          label: Text("View all Activities",
            style: AppConstants.appStyles.iconButtonText,
          )));
}

Widget getAutoApprove() {
  return InkWell(
    splashColor: AppConstants.appcolors.appOrange,
    onTap: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                FontAwesomeIcons.clipboardCheck,
                color: AppConstants.appcolors.primaryColor,
                size: 40,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  // border: Border.all(width: 2, color: Colors.orange),
                  color: AppConstants.appcolors.appOrange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0),
        Text(
          "Auto\nApprove",
          style: AppConstants.appStyles.iconButtonText,
          textAlign: TextAlign.center,
        ), // <-- Text
      ],
    ),
  );
}

Widget addPreApprove() {
  return InkWell(
    splashColor: AppConstants.appcolors.appOrange,
    onTap: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: AppConstants.appcolors.primaryColor,
                size: 45,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  // border: Border.all(width: 2, color: Colors.orange),
                  color: AppConstants.appcolors.appOrange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0),
        Text(
          "Pre-Approve",
          style: AppConstants.appStyles.iconButtonText,
          textAlign: TextAlign.center,
        ), // <-- Text
      ],
    ),
  );
}

Widget getAnimatedBottomNavigationBar(controller) {
  return AnimatedBottomNavigationBar.builder(
    itemCount: controller.bottomMenuItems.length,
    tabBuilder: (int index, bool isActive) {
      final color = isActive ? AppConstants.appcolors.appOrange : Colors.grey;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            controller.bottomMenuItems[index].icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Text(
              controller.bottomMenuItems[index].label!,
              maxLines: 1,
              style: isActive
                  ? AppConstants.appStyles.smallSidehead
                  : AppConstants.appStyles.smallText,
              //group: controller.autoSizeGroup,
            ),
          )
        ],
      );
    },

    backgroundColor: Colors.white,
    activeIndex: controller.bottomNavIndex,

    splashColor: AppConstants.appcolors.primaryColor,

    //notchAndCornersAnimation: controller.animation,
    splashSpeedInMilliseconds: 300,
    notchSmoothness: NotchSmoothness.defaultEdge,
    gapLocation: GapLocation.center,
    leftCornerRadius: 25,
    rightCornerRadius: 25,
    height: controller.sc_height * .10,

    onTap: (index) {
      controller.updateBottomIndex(index);
    },
  );

  // Container(
  //   height: 100,
  //   decoration: BoxDecoration(
  //     color: Colors.green,
  //     borderRadius: const BorderRadius.only(
  //       topLeft: Radius.circular(20),
  //       topRight: Radius.circular(20),
  //     ),
  //   ),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       InkWell(
  //         splashColor: Colors.orange,
  //         onTap: () {},
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(Icons.home),
  //             Text("Home"), // <-- Text
  //           ],
  //         ),
  //       ),
  //       InkWell(
  //         splashColor: Colors.orange,
  //         onTap: () {},
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(
  //               Icons.people,
  //               color: Colors.white,
  //             ),
  //             Text("Quick Act"), // <-- Text
  //           ],
  //         ),
  //       ),
  //       InkWell(
  //         splashColor: Colors.orange,
  //         onTap: () {},
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(Icons.people),
  //             Text("Household"), // <-- Text
  //           ],
  //         ),
  //       ),
  //       InkWell(
  //         splashColor: Colors.orange,
  //         onTap: () {},
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(Icons.location_city),
  //             Text("Community"), // <-- Text
  //           ],
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}

Widget addDailyHelp() {
  return InkWell(
    splashColor: AppConstants.appcolors.appOrange,
    onTap: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                Icons.person_outline_rounded,
                color: AppConstants.appcolors.primaryColor,
                size: 45,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  // border: Border.all(width: 2, color: Colors.orange),
                  color: AppConstants.appcolors.appOrange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0),

        Text(
          "Add Daily\nHelp",
          style: AppConstants.appStyles.iconButtonText,
          textAlign: TextAlign.center,
        ), // <-- Text
      ],
    ),
  );
}

Widget getalertIcon() {
  return InkWell(
    splashColor: AppConstants.appcolors.appOrange,
    onTap: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                Icons.notifications,
                color: AppConstants.appcolors.appOrange,
                size: 30,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: AppConstants.appcolors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(
                  '5',
                  style: AppConstants.appStyles.smallTextwhite,
                )),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget getSettingsButton() {
  return InkWell(
    splashColor: AppConstants.appcolors.appOrange,
    onTap: () {
      Get.toNamed(Routes.SETTINGS);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                Icons.settings,
                color: AppConstants.appcolors.appOrange,
                size: 25,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
