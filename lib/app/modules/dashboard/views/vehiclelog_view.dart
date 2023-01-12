import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:intl/intl.dart';
import '../../../../shared/appconstants.dart';
import '../../../../shared/shared_widgets.dart';
import '../../../data/models/localservice_category.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class VehiclelogView extends GetView<DashboardController> {
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
                                        "  Vehicle Log",
                                        style: AppConstants
                                            .appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: false, // controller.isloading ? true : false,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: getVehicleDetails(),
                      ),
                      //Replace your ListView.builder with this:
                      getVehicleLog(),
                    ],
                  )));
        }));
  }

  Widget getVehicleLog() {
    if (controller.vechileLog.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext ctxt, int index) {
          //  if (index >= controller.complaint.comments.length) return null;

          return Padding(
              padding: EdgeInsets.all(5.0),
              //  child: InkWell(
              child: ListTile(
                leading: Text('${controller.vechileLog[index].entryType}',
                    style: AppConstants.appStyles.smallSidehead),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getDateandTime(controller.vechileLog[index].createdAt!),
                    ]),
              ));
        }, childCount: controller.vechileLog.length),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ListTile(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text(
                  "No log found for this vehicle.",
                  style: AppConstants.appStyles.datehead,
                )
              ]));
        }, childCount: 1),
      );
    }
  }

  Widget getVehicleImage() {
    return controller.myVehicle!.photo != null
        ? SizedBox(
            height: 150,
            width: 150,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                //  child: InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    width: 130.0,
                    height: 130.0,
                    imageUrl: controller.myVehicle!.photo!,
                    placeholder: (context, url) => Icon(Icons.hourglass_bottom),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),

                  // ),
                  //      onTap:(){
                  //_gotoDetailsPage(context,item, 'customer ' + customerImagesList.indexOf(item).toString());
                  //       }
                )
                // )
                ))
        : SizedBox(
            height: 0,
            width: 0,
          );
  }

  Widget getVehicleDetails() {
    return Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            getVehicleImage(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Ref # ',
                        style: AppConstants.appStyles.smallTextPrimary)),
                Expanded(
                  flex: 2,
                  child: Text('${controller.myVehicle!.id!}',
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ],
            ),

            SizedBox(
              height: 5.0,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Name',
                      style: AppConstants.appStyles.smallTextPrimary)),
              Expanded(
                flex: 2,
                child: Text('${controller.myVehicle!.name}',
                    style: AppConstants.appStyles.smallTextPrimary),
              ),
            ]),

            SizedBox(
              height: 5.0,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Number',
                      style: AppConstants.appStyles.smallTextPrimary)),
              Expanded(
                flex: 2,
                child: Text('${controller.myVehicle!.vehicleNumber}',
                    style: AppConstants.appStyles.smallTextPrimary),
              ),
            ]),
            SizedBox(
              height: 5.0,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Type',
                      style: AppConstants.appStyles.smallTextPrimary)),
              Expanded(
                flex: 2,
                child: Text('${controller.myVehicle!.vehicleType} wheeler',
                    style: AppConstants.appStyles.smallTextPrimary),
              ),
            ]),
            SizedBox(
              height: 10.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Notification Status',
                      style: AppConstants.appStyles.smallTextPrimary)),
              Expanded(
                flex: 2,
                child: Text('${controller.myVehicle!.notificationEnabled}',
                    style: AppConstants.appStyles.smallTextPrimary),
              ),
            ]),

            SizedBox(
              height: 10.0,
            ),

            //  getComplaintImages(controller.complaint.photos),
          ]),
        ));
  }

  Widget getDateandTime(DateTime dt) {
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(dt);
    return Text('${date}', style: AppConstants.appStyles.smallText);
  }

  Widget getPaymentHistory() {
    if (controller.paymentHistoryList.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext ctxt, int index) {
          //  if (index >= controller.complaint.comments.length) return null;

          return Padding(
              padding: EdgeInsets.all(5.0),
              //  child: InkWell(
              child: ListTile(
                leading: Text('${controller.paymentHistoryList[index].mode}',
                    style: AppConstants.appStyles.smallText),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${controller.paymentHistoryList[index].whatFor}',
                          style: AppConstants.appStyles.smallText),
                      Text(
                          Jiffy(controller.paymentHistoryList[index].paidAt)
                              .yMMMMd,
                          style: AppConstants.appStyles.smallText),
                      Text(
                          Jiffy(controller.paymentHistoryList[index].paidAt).jm,
                          style: AppConstants.appStyles.smallText),
                    ]),
                trailing: Text(
                    '₹ ${controller.paymentHistoryList[index].amount}',
                    style: AppConstants.appStyles.emergencyContact),
              ));
        }, childCount: controller.paymentHistoryList.length),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ListTile(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text(
                  "No payment records found.",
                  style: AppConstants.appStyles.datehead,
                )
              ]));
        }, childCount: 1),
      );
    }
  }

  Widget getCardView(LocalServiceCategory lsm) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2.0,
      child: InkWell(
        splashColor: Color(0xffECC7FE),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
                leading: Text(lsm.id.toString()),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          '${lsm.name?.toUpperCase()}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ]),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_right,
                      size: 35,
                    ),
                  ],
                ))

            //                        getmediaButtons(ni)
            ),
        onTap: () {
          //controller.showServicePeople(lsm);
          // context.read<LocalServicesController>().selectedCategoryId = lsm.id;
          // context
          //     .read<LocalServicesController>()
          //     .navigateToPage(page: router.LocalServices);
        },
      ),
    );
  }
}
