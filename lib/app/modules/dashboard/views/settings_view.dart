import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../../../../shared/appconstants.dart';
import '../../../routes/app_pages.dart';

class SettingsView extends GetView<DashboardController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<DashboardController>(builder: (controller) {
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80.0),
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
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  Settings",
                                        style: AppConstants
                                            .appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body:
                  //isLoading: controller.isloading ? true : false,
                  ListView(
                children: [
                  //getProfileCard(),
                  getHouseCard(),

                  SizedBox(
                    height: 25.0,
                  ),

                  addFlatorVilla()
                ],
              ));
        }));
  }

  Widget addFlatorVilla() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: TextButton.icon(
            onPressed: () {
              Get.toNamed(Routes.CITIES);
            },
            icon: Icon(Icons.add_circle_rounded,
                color: AppConstants.appcolors.appOrange, size: 32.0),
            label: Text(
              "Add Your Flat / Villa",
              style: AppConstants.appStyles.iconButtonText,
            )));
  }

  Widget getHouseCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10.0,
      child: InkWell(
        splashColor: Color(0xffECC7FE),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                  horizontalTitleGap: 10.0,
                  leading: Icon(
                    Icons.home_outlined,
                    color: AppConstants.appcolors.appOrange,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppConstants.activeFlat!.blockName.toString()} - ${AppConstants.activeFlat!.flatNumber.toString()}',
                        style: AppConstants.appStyles.smallText,
                      ),
                      Text(
                        AppConstants.activeFlat!.communityName.toString(),
                        style: AppConstants.appStyles.sidehead,
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.activeFlat!.cityName.toString(),
                        style: AppConstants.appStyles.smallText,
                      ),
                      SizedBox(height: 5.0),
                    ],
                  )),
            ])),
        onTap: () {},
      ),
    );
  }
}
