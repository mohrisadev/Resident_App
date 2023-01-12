import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/ResidentsModel.dart';
import 'package:mykommunity/app/data/models/residents_model.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../../../data/models/vehicle_model.dart';
import 'dailyhelplist_view.dart';

class HouseHoldView extends GetView<DashboardController> {
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
                          padding: EdgeInsets.all(30.0),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Household",
                                  style: AppConstants
                                      .appStyles.mediumPagetitle))))),
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
                                  Text("My Family",
                                      style: AppConstants.appStyles.sidehead),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.0,
                                          color:
                                              AppConstants.appcolors.appOrange),
                                    ),
                                    onPressed: () {
                                      Get.toNamed(Routes.NEW_FAMILY_MEMBER);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Add',
                                          style: AppConstants
                                              .appStyles.smallSideheadorange,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(Icons.add,
                                            color: AppConstants
                                                .appcolors.appOrange),
                                      ],
                                    ),
                                  ),
                                ],
                              ))),
                      Container(
                          height: 140.00,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.residents.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        Residentsmodel fm = controller.residents
                                            .elementAt(index);

                                        return getCardViewforResident(fm);
                                      }))
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                              height: 40.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("My Daily Help",
                                      style: AppConstants.appStyles.sidehead),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.0,
                                          color:
                                              AppConstants.appcolors.appOrange),
                                    ),
                                    onPressed: () {
                                      Get.toNamed(
                                          Routes.LOCALSERVICE_CATEGORIES);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Add',
                                          style: AppConstants
                                              .appStyles.smallSideheadorange,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(Icons.add,
                                            color: AppConstants
                                                .appcolors.appOrange),
                                      ],
                                    ),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: DailyHelp(),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            height: 40.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("My Vehicles",
                                    style: AppConstants.appStyles.sidehead),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 1.0,
                                        color:
                                            AppConstants.appcolors.appOrange),
                                  ),
                                  onPressed: () {
                                    twoWheeleerBottomSheet();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Add',
                                        style: AppConstants
                                            .appStyles.smallSideheadorange,
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.add,
                                          color:
                                              AppConstants.appcolors.appOrange),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                          height: 210.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.vechiles.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                Vehiclemodel vm =
                                    controller.vechiles.elementAt(index);
                                return getCardView(vm);
                              })),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  )));
        }));
  }

  Widget isApproved(Residentsmodel rs) {
    return rs.isApproved == true
        ? Icon(Icons.check_sharp, color: Colors.blue)
        : Icon(Icons.hourglass_top_outlined, color: Colors.red);
  }

  Widget getCardViewforResident(Residentsmodel rs) {
    return Container(
        width: MediaQuery.of(Get.context!).size.width / 1.5,
        height: 140.0,
        child: Card(
          margin: EdgeInsets.all(2.0),
          elevation: 4,
          child: InkWell(
            splashColor: AppConstants.appcolors.primaryColor,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                horizontalTitleGap: 6.0,
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage("https://dummyimage.com/60"),
                ),
                title: Text('${rs.first_name} ${rs.last_name}',
                    style: AppConstants.appStyles.sidehead),
                subtitle: Text(rs.role.toString(),
                    style: AppConstants.appStyles.smallText),
                trailing: isApproved(rs),
              ),
              Divider(),
              Center(
                  child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 0.0, color: Colors.transparent),
                ),
                onPressed: () {
                  displayResident(rs);
                },
                child: Text(
                  'Check Details',
                  style: AppConstants.appStyles.smallSideheadorange,
                ),
              )),
            ]),
            onTap: () {
              displayResident(rs);
            },
          ),
        ));
  }

  void displayResident(Residentsmodel rs) {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
              height: 380,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.00))),
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Family Member',
                                    style: AppConstants
                                        .appStyles.bottomSheetTitle),
                              ],
                            ))),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    horizontalTitleGap: 6.0,
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage("https://dummyimage.com/60"),
                    ),
                    title: Row(
                      children: [
                        Text('${rs.first_name} ${rs.last_name}',
                            style: AppConstants.appStyles.nameHead),
                        isApproved(rs)
                      ],
                    ),
                    subtitle: Text('Family Member',
                        style: AppConstants.appStyles.smallText),
                    trailing: Chip(
                      label: Text(
                        rs.role!,
                        style: AppConstants.appStyles.smallTextwhite,
                      ),
                      backgroundColor: AppConstants.appcolors.primaryColor,
                    ),
                  ),
                  Divider(),
                  Wrap(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Mobile : ",
                              textAlign: TextAlign.right,
                            )),
                        Expanded(
                            flex: 2,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "na",
                                      style:
                                          AppConstants.appStyles.iconButtonText,
                                    )))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Flat : ",
                              textAlign: TextAlign.right,
                            )),
                        Expanded(
                            flex: 2,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      '${rs.blockName} ${rs.flatNumber!}',
                                      style:
                                          AppConstants.appStyles.iconButtonText,
                                    )))),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ]),
                  Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              ' OK, Got it ',
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
                          )
                        ],
                      ))
                ],
              ));
        });
  }

  Widget DailyHelp() {
    return Container(
        height: 130.0, width: double.infinity, child: DailyhelplistView());
  }

  void twoWheeleerBottomSheet() {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return GetBuilder<DashboardController>(builder: (controller) {
            return Container(
                height: 300,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                AppConstants.appimages.topBackground),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.00))),
                      height: 90,
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Material(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Type of Vehicle',
                                      style: AppConstants
                                          .appStyles.bottomSheetTitle),
                                  Text('Select One',
                                      style: AppConstants
                                          .appStyles.smallTextwhite),
                                ],
                              ))),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                        height: 150.0,
                        child: ListView.builder(
                            itemCount: controller.vechicleTypes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  controller.selectVechileType(
                                      controller.vechicleTypes[index]);
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                leading: Icon(
                                  controller.selectedVechileType == controller.vechicleTypes[index]
                                      ? Icons.check_circle_outline
                                      : Icons.add_circle_outline_sharp,
                                  color: AppConstants.appcolors.appOrange,
                                  size: 32.0,
                                ),
                                title: Text(
                                  controller.vechicleTypes[index],
                                  style: AppConstants.appStyles.smallTextPrimary,
                                ),
                              );
                            })),
                  ],
                ));
          });
        });
  }

  Widget getCardView(Vehiclemodel vhicle) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8.0,
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: SizedBox(
            width: 260.0, //MediaQuery.of(Get.context!).size.width / 1.65,
            height: 210.0, // MediaQuery.of(Get.context!).size.height / 6,
            child: Column(children: [
              ListTile(
                horizontalTitleGap: 6.0,
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(vhicle.photo != null
                      ? vhicle.photo!
                      : "https://dummyimage.com/60"),
                ),
                title: Text('${vhicle.name!}',
                    style: AppConstants.appStyles.sidehead),
                subtitle: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(vhicle.vehicleNumber!,
                      style: TextStyle(
                        color: AppConstants.appcolors.primaryColor,
                      )),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text('Vehicle No : ',
                      style: AppConstants.appStyles.smallText),
                  Text(vhicle.vehicleNumber!,
                      style: AppConstants.appStyles.smallText),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text('Vehicle Type : ',
                      style: AppConstants.appStyles.smallText),
                  Text('${vhicle.vehicleType!} Wheeler',
                      style: AppConstants.appStyles.smallText),
                ],
              ),
              SizedBox(height: 5.0),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  color: Colors.white10,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0, color: Colors.white10)),
                                    child: Text("Veh Logs",
                                        style: AppConstants
                                            .appStyles.sideheadorange),
                                    onPressed: () {
                                      vehicleLogs(vhicle);
                                      //paymentBottomSheet(lsm);
                                    },
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  color: AppConstants.appcolors.appOrange,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.0,
                                          color:
                                              AppConstants.appcolors.appOrange),
                                    ),
                                    child: Text("Notifications",
                                        style: AppConstants
                                            .appStyles.smallTextwhite),
                                    onPressed: () {
                                      vehicleNotification(vhicle);
                                    },
                                  ))),
                        ],
                      )))),
            ]),
          ),
        ));
  }

  Widget getPhoto(String imgurl) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        //  child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),

          child: CachedNetworkImage(
            height: 80.0,
            fit: BoxFit.fitWidth,
            imageUrl: imgurl,
            placeholder: (context, url) => Icon(Icons.hourglass_bottom),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),

          // ),
          //      onTap:(){
          //_gotoDetailsPage(context,item, 'customer ' + customerImagesList.indexOf(item).toString());
          //       }
        )
        // )
        );
  }

  void vehicleLogs(Vehiclemodel lsm) {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
              height: 290,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.00))),
                    height: 90,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Vehicle Logs',
                                    style: AppConstants
                                        .appStyles.bottomSheetTitle),
                                Text('Check details',
                                    style:
                                        AppConstants.appStyles.smallTextwhite),
                              ],
                            ))),
                  ),
                  SizedBox(height: 20.0),
                  Text('Vehicle Log',
                      style: AppConstants.appStyles.mediumPrimaryhead),
                  Text('Would you like to see your vechicle log details',
                      style: AppConstants.appStyles.smallText),
                  Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              ' No ',
                              style: AppConstants.appStyles.buttonText,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              controller.selectVehicle(lsm);
                            },
                            child: Text(' Yes ', style: AppConstants.appStyles.buttonText,),
                            style: ElevatedButton.styleFrom(
                              primary: AppConstants.appcolors.appOrange,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(height: 20.0),
                ],
              ));
        });
  }

  void vehicleNotification(Vehiclemodel lsm) {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
              height: 290,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.00))),
                    height: 90,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Vehicle Notification',
                                    style: AppConstants
                                        .appStyles.bottomSheetTitle),
                                Text('Check details',
                                    style:
                                        AppConstants.appStyles.smallTextwhite),
                              ],
                            ))),
                  ),
                  SizedBox(height: 20.0),
                  Text('Notification Settings',
                      style: AppConstants.appStyles.mediumPrimaryhead),
                  Text('Would you like to notify your Vechicle log',
                      style: AppConstants.appStyles.smallText),
                  Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.selectVehicle(lsm);
                              Get.back();
                              controller.disableNotification();
                              Get.back();
                            },
                            child: Text(
                              ' Disable ',
                              style: AppConstants.appStyles.buttonText,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              controller.selectVehicle(lsm);
                              Get.back();
                              controller.enableNotification();
                              Get.back();
                            },
                            child: Text(
                              ' Yes, Notify me ',
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
                          )
                        ],
                      )),
                  SizedBox(height: 20.0),
                ],
              ));
        });
  }
}
