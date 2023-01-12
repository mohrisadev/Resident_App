import 'dart:io';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../controllers/dashboard_controller.dart';

class NewvehicleView extends GetView<DashboardController> {
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
                      child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
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
                                        "Add your Vehicle",
                                        style: AppConstants
                                            .appStyles.mediumPagetitle,
                                      ))),
                            ],
                          )))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: controller.isLoading ? true : false,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 15,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SizedBox(
                              height: 80.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.addNewVehicle();
                                },
                                child: Text(
                                  '   Add New Vehicle   ',
                                  style: AppConstants.appStyles.buttonText,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: AppConstants.appcolors.appOrange,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 100.0, top: 20.0, left: 20.0, right: 20.0),
                        child: ListView(
                          children: [
                            Text(
                              "\nVehicle Details",
                              style: AppConstants.appStyles.menuSidehead,
                            ),
                            TextField(
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {},
                              controller: controller.controllerVehicleName,
                              style: AppConstants.appStyles.tileText,
                              decoration: InputDecoration(
                                  labelText: "Vehicle Name",
                                  hintText: "Vehicle Name",
                                  hintStyle: AppConstants.appStyles.smallText,
                                  //prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)))),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {},
                              controller: controller.controllerVehicleNumber,
                              style: AppConstants.appStyles.tileText,
                              decoration: InputDecoration(
                                  labelText: "Vehicle Number",
                                  hintText: "Vehicle Number",
                                  hintStyle: AppConstants.appStyles.smallText,
                                  //prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)))),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 0.0,
                                        color:
                                            AppConstants.appcolors.appOrange),
                                  ),
                                  onPressed: () {
                                    controller.showCamera();
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Take Photo', style: AppConstants
                                              .appStyles.smallTextPrimary,
                                          ),
                                          SizedBox(width: 5),
                                          Icon(Icons.camera_alt_outlined,
                                              color: AppConstants
                                                  .appcolors.appOrange),
                                        ],
                                      )),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 0.0,
                                        color: AppConstants.appcolors.appOrange),
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Upload Image',
                                            style: AppConstants
                                                .appStyles.smallTextPrimary,
                                          ),
                                          SizedBox(width: 5),
                                          Icon(Icons.image_outlined,
                                              color: AppConstants
                                                  .appcolors.appOrange),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            Divider(),
                            getCapturedImages(),
                          ],
                        ),
                      )
                    ],
                  )));
        }));
  }

  getCapturedImages() {
    if (controller.newImages.isNotEmpty) {
      return SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(5),
              itemCount: controller.newImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 200,
                    child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: InkWell(
                          child: Image.file(
                            File(controller.newImages[index].localurl!),
                          ),
                          onTap: () {
                            controller.heroTapped(
                                index,
                                controller.newImages[index].localurl.toString(),
                                "local");
                          },
                        )));
              }));
    } else {
      return Container(width: 0, height: 0);
    }
  }
}
