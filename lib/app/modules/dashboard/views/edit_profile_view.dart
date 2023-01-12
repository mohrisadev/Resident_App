import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/dashboard_controller.dart';

class EditProfileView extends GetView<DashboardController> {
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
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  Edit Profile",
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
                        padding: EdgeInsets.all(10.0),
                        child: InkWell(
                            splashColor: AppConstants.appcolors.appOrange,
                            onTap: () {
                              controller.updateProfileImage();
                            },
                            child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                alignment: Alignment.center,
                                height: 200,
                                child: Stack(
                                  children: <Widget>[
                                    getProfileImage(),
                                    Positioned(
                                      bottom: 5,
                                      right: 10,
                                      child: Icon(
                                        Icons.edit,
                                        size: 35.0,
                                        color: AppConstants.appcolors.appOrange,
                                      ),
                                    ),
                                  ],
                                ))),
                      ),
                    ],
                  )));
        }));
  }

  Widget getProfileImage() {
    return controller.userProfile!.photos != null
        ? CircleAvatar(
            radius: 75.0,
            backgroundImage: NetworkImage(controller.userProfile!.photos!),
          )
        : CircleAvatar(
            radius: 75.0,
            backgroundImage: NetworkImage(controller.userProfile!.photos.toString()),
          );
  }
}
