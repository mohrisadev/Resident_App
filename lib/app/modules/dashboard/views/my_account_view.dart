import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/routes/app_pages.dart';

import '../../../../shared/appconstants.dart';
import '../../../../shared/shared_widgets.dart';
import '../controllers/dashboard_controller.dart';

class MyAccountView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<DashboardController>(builder: (controller) {
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80), // here the desired height
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                AppConstants.appimages.topBackground),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(25.00))),
                      width: double.infinity,
                      constraints: BoxConstraints.expand(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TextButton.icon(
                                      onPressed: () {
                                        Get.toNamed(Routes.DASHBOARD);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  My Account",
                                        style: AppConstants
                                            .appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: Container(
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10.0), child: profileCard()),
                    ],
                  )));
        }));
  }
  Widget profileCard() {
    return Card(
        elevation: 10.0,
        child: ListTile(
            horizontalTitleGap: 6.0,
            leading: getProfileImage(),
            title: Text(
                '${controller.userProfile!.firstName!} ${controller.userProfile!.lastName!}',
                style: AppConstants.appStyles.sidehead),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getFormatedPhoneNumber(
                  controller.userProfile!.phone,
                )
                // Text(controller.userProfile!.email!,
                //     style: AppConstants.appStyles.smallText),
              ],
            ),
            trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Get.toNamed(Routes.EDITPROFILE);
                })));
  }

  Widget getProfileImage() {
    // return CachedNetworkImage(
    //   imageUrl: controller.userProfile!.photos.toString(),
    //   placeholder: (context, url) => new CircularProgressIndicator(),
    //   errorWidget: (context, url, error) => new Icon(Icons.error),
    // );

    return controller.userProfile!.photos != null
        ? CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(controller.userProfile!.photos!),
          )
        : CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage("https://dummyimage.com/60"),
          );
  }
}
