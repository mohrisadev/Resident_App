import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/quick_activity_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class NewfamilymemberView extends GetView<DashboardController> {
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
                                        "Allow Resident",
                                        style: AppConstants
                                            .appStyles.mediumPagetitle,
                                      ))),
                              OutlinedButton(
                                onPressed: () {
                                  // Get.toNamed(Routes.NEW_FAMILY_MEMBER);
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: getContactButton(
                                        controller.newResident)),
                              ),
                            ],
                          )))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: controller.isLoading ? true : false,
                  child: ListView(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                              height: 40.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Resident Details",
                                      style: AppConstants.appStyles.sidehead),
                                ],
                              ))),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: controller.getFirstName()),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: controller.getLastName()),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: controller.getPhoneNumber()),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: controller.getEmailFiled()),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              elevation: 5,
                              // shape: Border.all(
                              //     color: AppConstants.appcolors.primaryColor,
                              //     width: 1),
                              child: ListTile(
                                onTap: () {
                                  getRoleSheet(context, controller);
                                },
                                dense: true,
                                trailing: Icon(
                                  Icons.arrow_drop_down_circle_sharp,
                                  color: AppConstants.appcolors.appOrange,
                                ),
                                title: Text('${controller.selectedRole}',
                                    style:
                                        AppConstants.appStyles.smallSidehead),
                              ),
                            ),
                          ))),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              elevation: 5,
                              // shape: Border.all(
                              //     color: AppConstants.appcolors.primaryColor,
                              //     width: 1),
                              child: ListTile(
                                onTap: () {
                                  getOccupancyStatusSheet(context, controller);
                                },
                                dense: true,
                                trailing: Icon(
                                  Icons.arrow_drop_down_circle_sharp,
                                  color: AppConstants.appcolors.appOrange,
                                ),
                                title: Text('${controller.occupancyStatus}',
                                    style:
                                        AppConstants.appStyles.smallSidehead),
                              ),
                            ),
                          ))),
                      ListTile(
                        onTap: () {
                          controller.swapOptin();
                        },
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        leading: Icon(
                          controller.selectedOptIn == true
                              ? Icons.check_circle_outline
                              : Icons.circle_outlined,
                          color: AppConstants.appcolors.appOrange,
                          size: 35.0,
                        ),
                        title: Text(
                          "Connect OPT in",
                          style: AppConstants.appStyles.smallTextPrimary,
                        ),
                      ),
                      Spacer(),
                      Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.Addresident();
                              },
                              child: Text(
                                ' Update ',
                                style: AppConstants.appStyles.buttonText,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppConstants.appcolors.appOrange,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          )),
                    ],
                  )));
        }));
  }

  void getRoleSheet(context, controller) {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
            height: 280,
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppConstants.appimages.topBackground),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.00))),
                height: 80,
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Material(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Role of the Resident',
                                style: AppConstants.appStyles.bottomSheetTitle),
                            Text('Select One',
                                style: AppConstants.appStyles.smallTextwhite),
                          ],
                        ))),
              ),
              SizedBox(height: 20.0),
              getRoles(context, controller)
            ]),
          );
        });
  }

  Widget getContactButton(QuickActivityModel? qv) {
    return InkWell(
      splashColor: AppConstants.appcolors.appOrange,
      onTap: () async {
        if (controller.contacts!.isNotEmpty) {
          Get.toNamed(Routes.GET_CONTACTS);
        } else {
          final PermissionStatus permissionStatus = await _getPermission();
          if (permissionStatus == PermissionStatus.granted) {
            controller
                .refreshContacts()
                .then((value) => Get.toNamed(Routes.GET_CONTACTS));
          } else {}
        }
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
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Icon(
                  Icons.contact_phone,
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

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission == PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();

      return permissionStatus[Permission.contacts] ??
          PermissionStatus.restricted;
    } else {
      return permission;
    }
  }

  Widget getRoles(context, controller) {
    return Container(
        height: 100.0,
        child: Center(
            child: Wrap(direction: Axis.horizontal, children: [
          for (var item in controller.role)
            Padding(
              padding: EdgeInsets.all(5.0),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    controller.updateRole(item);
                  },
                  color: controller.selectedRole == item
                      ? Colors.red
                      : Colors.white,
                  textColor: controller.selectedRole == item
                      ? Colors.white
                      : Colors.black,
                  child: Text(
                    item,
                    style: AppConstants.appStyles.smallTextbs,
                  )),
            )
        ])));
  }

  void getOccupancyStatusSheet(context, controller) {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
            height: 280,
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppConstants.appimages.topBackground),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.00))),
                height: 80,
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Material(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Occupancy Status',
                                style: AppConstants.appStyles.bottomSheetTitle),
                            Text('Select One',
                                style: AppConstants.appStyles.smallTextwhite),
                          ],
                        ))),
              ),
              SizedBox(height: 20.0),
              getOccupancyList(context, controller)
            ]),
          );
        });
  }

  Widget getOccupancyList(context, controller) {
    return Container(
        height: 100.0,
        child: Center(
            child: Wrap(direction: Axis.horizontal, children: [
          for (var item in controller.occupancyStatusList)
            Padding(
              padding: EdgeInsets.all(5.0),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    controller.updateOccupancyStatus(item);
                  },
                  color: controller.occupancyStatus == item
                      ? Colors.red
                      : Colors.white,
                  textColor: controller.occupancyStatus == item
                      ? Colors.white
                      : Colors.black,
                  child: Text(
                    item,
                    style: AppConstants.appStyles.smallTextbs,
                  )),
            )
        ])));
  }
}
