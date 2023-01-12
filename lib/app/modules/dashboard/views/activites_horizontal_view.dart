import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mykommunity/app/modules/home/controllers/home_controller.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../../../data/models/activities_model.dart';
import '../../../widgets/app_widgets.dart';

class ActivitesHorizontalView extends GetView<DashboardController> {
  //const ActivitesHorizontalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return controller.isrecentActivitesLoading == true
          ? SizedBox(
              width: 200,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppConstants.appcolors.primaryColor,
                ),
              ),
            )
          : Scaffold(
              body: Container(
                  height: 220,
                  color: Color(0xffFBF4FF),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.activities.length > 5
                        ? 5
                        : controller.activities.length,
                    itemBuilder: (BuildContext context, int index) {
                      ActivitiesModel am =
                          controller.activities.elementAt(index);
                      ////print(am.category);

                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              elevation: 5.0,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: getCard(am))));
                    },
                  )));
    });
  }

  Widget getCard(ActivitiesModel am) {
    return Container(
        width: MediaQuery.of(Get.context!).size.width * .6,
        child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                        NetworkImage(getCompanyImageUrl(am.data!.company!)),
                    backgroundColor: Colors.transparent,
                  ),
                  title: getCompany(am),
                  subtitle: getNameorCategory(am),
                  trailing: getVisitorType(am),
                ),

                getDetails(am),

                // getVisitorType(am),
                // //getTimeSlots(am),
                // getStartDate(am),
                // // getTemperature(am),
                // // iswearingmask(am),
                // getValidHours(am),

                // // getNameorCategory(am),

                // getVehicleNumber(am),
              ],
            ),
            onTap: () {
              // AwesomeDialog(
              //   context: context,
              //   //dialogBackgroundColor: Colors.red,

              //   animType: AnimType.SCALE,
              //   dialogType: DialogType.NO_HEADER,
              //   body: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Center(
              //           child: Text(getactvityHeader(am),
              //               style: AppConstants.appStyles.sidehead)),
              //       Center(child: getVisitorType(am)),
              //       Divider(),
              //       Text('${am.data.company}',
              //           style: AppConstants.appStyles.smallSidehead),
              //       Text(
              //         '${am.data.phone}',
              //         style: AppConstants.appStyles.smallText,
              //       ),
              //       Divider(),
              //       getTimeSlots(am),
              //       Divider(),
              //       getTemperature(am),
              //       iswearingmask(am),
              //       getVehicleNumber(am),
              //     ],
              //   ),

              //   btnOkOnPress: () {},
              // )..show();
            }));
  }

  Widget getCompany(ActivitiesModel am) {
    return Text(
      am.data!.company!.toUpperCase() == ''
          ? am.data!.activity!.toUpperCase().toString()
          : am.data!.company!.toUpperCase(),
      style: AppConstants.appStyles.listTileHead,
    );
  }

  Widget getDetails(ActivitiesModel am) {
    // if (am.data.visitorType != null || am.data.visitorType != "") {
    switch (am.category) {
      case "cab":
        {
          return cabActivityCard(am);
        }
        break;

      case "delivery":
        {
          return deliveryactivity(am);
        }
        break;

      case "visitor":
        {
          return
              // Text(
              //   'Visiting Help\n${am.data.activity.toString()}',
              //   style: AppConstants.appStyles.smallSidehead,
              // )
              Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 20,
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.red,
              ),
              child: Text(
                "Visitor",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        break;

      default:
        {
          return defaultActivityCard(am);
        }
        break;
    }
  }

  Widget defaultActivityCard(ActivitiesModel am) {
    return Wrap(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Ref : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '#${am.id.toString()}',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Date : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        Jiffy(am.createdAt).yMMMMd,
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(height: 10.0),
      getStatusRow(am)
    ]);
  }

  Widget getStatusRow(ActivitiesModel am) {
    return am.data!.status != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text(
                    "Status : ",
                    textAlign: TextAlign.right,
                    style: AppConstants.appStyles.generalText,
                  )),
              Expanded(
                  flex: 2,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '${am.data!.status != null ? am.data!.status : ''}',
                            style: AppConstants.appStyles.generalText,
                          )))),
            ],
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  Widget deliveryactivity(ActivitiesModel am) {
    return Wrap(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Order ID : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '#${am.id.toString()}',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Time : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        am.data!.onceStartTime ?? "",
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Date : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        Jiffy(am.createdAt).yMMMMd,
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Vehicle : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${am.data!.vehicleNumber}',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Valid for : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${am.data!.onceValidFor} Hours',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Status : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${am.data!.approvalstatus != null ? am.data!.approvalstatus : ''}',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
    ]);
  }

  Widget cabActivityCard(ActivitiesModel am) {
    return Wrap(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Order ID : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '#${am.id.toString()}',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Time : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        am.data!.onceStartTime ?? "",
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Date : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        Jiffy(am.createdAt).yMMMMd,
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Vehicle : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${am.data!.vehicleNumber}',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Valid for : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${am.data!.onceValidFor} Hours',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Status : ",
                textAlign: TextAlign.right,
                style: AppConstants.appStyles.generalText,
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${am.data!.approvalstatus != null ? am.data!.approvalstatus : ''}',
                        style: AppConstants.appStyles.generalText,
                      )))),
        ],
      ),
    ]);
  }

  Widget getVisitorType(ActivitiesModel am) {
    // if (am.data.visitorType != null || am.data.visitorType != "") {
    switch (am.data!.visitorType) {
      case 1:
        {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 20,
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.green,
              ),
              child: Text(
                "Delivery",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        break;

      case 2:
        {
          return
              // Text(
              //   'CAB\n${am.data.activity}',
              //   style: AppConstants.appStyles.smallSidehead,
              // )
              Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 20,
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.amber[700],
              ),
              child: Text(
                "CAB/TAXI",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        break;

      case 3:
        {
          return
              // Text(
              //   'Visiting Help\n${am.data.activity.toString()}',
              //   style: AppConstants.appStyles.smallSidehead,
              // )
              Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 20,
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.red,
              ),
              child: Text(
                "Visitor",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        break;

      default:
        {
          return
              //Text(
              //   am.data.activity.toString(),
              //   style: AppConstants.appStyles.smallSidehead,
              // )
              Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 20,
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppConstants.appcolors.appPincColor),
              child: Text(
                'Others',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        break;
    }
  }

  Widget getStartDate(ActivitiesModel am) {
    return (am.data!.validFromDate != null)
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child:
                Text("${Jiffy(am.data!.validFromDate, "dd, MMM yyyy").yMMMMd}",
                    //'${am.data.validFromDate}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7E7E7E),
                    )),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text("${Jiffy(am.createdAt, "dd, MMM yyyy").yMMMMd}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7E7E7E),
                )),
          );
  }

  Widget getValidHours(ActivitiesModel am) {
    return (am.data!.onceStartTime != null && am.data!.onceStartTime != "")
        ? Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Text(
                  "Entry Valid :",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff7E7E7E),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    '${am.data!.onceValidFor} hours',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  Widget getVehicleNumber(ActivitiesModel am) {
    return am.data!.vehicleNumber != ""
        ? Row(
            children: [
              Text(
                "Vehicle No :",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7E7E7E),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    '${am.data!.vehicleNumber}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  )),
            ],
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  Widget getNameorCategory(ActivitiesModel am) {
    return am.data!.name != ""
        ? Text('${am.data!.name}', style: AppConstants.appStyles.generalText)
        : Text(
            '${am.data!.name}',
            style: AppConstants.appStyles.generalText,
          );
  }
}
