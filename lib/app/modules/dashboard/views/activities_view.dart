import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/activities_model.dart';
import '../../../data/models/quick_activity_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/app_widgets.dart';
import '../controllers/dashboard_controller.dart';

class ActivitiesView extends GetView<DashboardController> {
  const ActivitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    //  controller.getListofActivities();

    return LoadingOverlay(
        opacity: 0.9,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(),
        isLoading: controller.appState == AppState.Busy ? true : false,
        child: WillPopScope(
            onWillPop: (() => controller.showDashboard()),
            child: GetBuilder<DashboardController>(builder: (controller) {
              return Scaffold(
                  appBar: PreferredSize(
                      preferredSize:
                          Size.fromHeight(80), // here the desired height
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
                                  child: Text("Activities",
                                      style: AppConstants
                                          .appStyles.mediumPagetitle))))),
                  body: Container(
                    width: double.infinity,
                    // height: 600.0,
                    child: ListView.builder(
                        itemCount: controller.activities.length,
                        // gridDelegate:
                        //     SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount:
                        //             (orientation == Orientation.portrait)
                        //                 ? 2
                        //                 : 3),
                        itemBuilder: (BuildContext context, int index) {
                          ActivitiesModel am =
                              controller.activities.elementAt(index);

                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  elevation: 5.0,
                                  child: getCard(am)));
                        }),
                  ));
            })));
  }
}

Widget getVechileNumberRow(ActivitiesModel am) {
  return am.data!.vehicleNumber != null && am.data!.vehicleNumber != ""
      ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(
                  "Vehicle No : ",
                  textAlign: TextAlign.right,
                )),
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          am.data!.vehicleNumber!,
                          style: AppConstants.appStyles.iconButtonText,
                        )))),
          ],
        )
      : Container(width: 0, height: 0);
}

Widget getIsMaskwearing(ActivitiesModel am) {
  // ignore: unrelated_type_equality_checks
  return am.data!.isWearingMask != null && am.data!.isWearingMask != ""
      ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(
                  "Mask : ",
                  textAlign: TextAlign.right,
                )),
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Is wearing mask",
                          style: AppConstants.appStyles.iconButtonText,
                        )))),
          ],
        )
      : Container(width: 0, height: 0);
}

Widget getTemp(ActivitiesModel am) {
  return am.data!.temperature != null && am.data!.temperature != ""
      ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(
                  "Temperature : ",
                  textAlign: TextAlign.right,
                )),
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          am.data!.temperature,
                          style: AppConstants.appStyles.iconButtonText,
                        )))),
          ],
        )
      : Container(width: 0, height: 0);
}

Widget getCard(ActivitiesModel am) {
  return ExpansionTile(
    initiallyExpanded: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage:
                NetworkImage(getCompanyImageUrl(am.data!.company!)),
            backgroundColor: Colors.transparent,
          ),
          title: getCompany(am),
          subtitle: getNameorCategory(am),
          trailing: getVisitorType(am),
        ),

        getDetails(am),

        // getStartDate(am),
        // getTimeSlots(am),
        // getVehicleNumber(am),
        // getTempandMaskDetails(am),

        // Container(
        //     height: 30,
        //     child: Row(
        //       children: [
        //         getValidHours(am),
        //       ],
        //     )),
        //
      ],
    ),
    children: <Widget>[
      Divider(),
      Wrap(children: <Widget>[
        getVechileNumberRow(am),
        getIsMaskwearing(am),
        getTemp(am),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(
                  "Entry Time : ",
                  textAlign: TextAlign.right,
                )),
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [getStartDate(am), getTimeSlots(am)],
                        )))),
          ],
        ),
        getStatusRow(am),
        SizedBox(
          height: 10.0,
        )
      ]),
    ],
  );
}

Widget cabActivityCard(ActivitiesModel am) {
  return Wrap(children: <Widget>[
    getStartDate(am),
    getTimeSlots(am),
    getVehicleNumber(am),
    getTempandMaskDetails(am),
  ]);
}

Widget deliveryactivity(ActivitiesModel am) {
  return Wrap(children: <Widget>[
    getStartDate(am),
    getTimeSlots(am),
    getVehicleNumber(am),
    getTempandMaskDetails(am),
  ]);
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

Widget getNameorCategory(ActivitiesModel am) {
  return am.data!.name != ""
      ? Text('${am.data!.name}', style: AppConstants.appStyles.smallText)
      : Text(
          '${am.data!.name}',
          style: AppConstants.appStyles.smallText,
        );
}

Widget getStartDate(ActivitiesModel am) {
  return (am.data!.validFromDate != null)
      ? Container(
          height: 34,
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.calendar_today,
              size: 15.0,
              color: AppConstants.appcolors.appOrange,
            ),
            label: Text(
              Jiffy(am.data!.validFromDate, "dd, MMM yyyy").yMMMMEEEEd,
              style: AppConstants.appStyles.iconButtonText,
            ),
          ))
      : Container(
          height: 30,
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.calendar_today,
              size: 15.0,
              color: AppConstants.appcolors.appOrange,
            ),
            label: Text(
              Jiffy(am.createdAt, "dd, MMM yyyy").yMMMMd,
              style: AppConstants.appStyles.iconButtonText,
            ),
          ));
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

Widget getValidHours(ActivitiesModel am) {
  return (am.data!.onceStartTime != null && am.data!.onceStartTime != "")
      ? Padding(
          padding: const EdgeInsets.only(bottom: 2),
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

Widget getCompany(ActivitiesModel am) {
  return Text(
      am.data!.company!.toUpperCase() == ''
          ? am.data!.activity!.toUpperCase().toString()
          : am.data!.company!.toUpperCase(),
      style: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700));
}

Widget getVisitorType(ActivitiesModel am) {
  switch (am.data?.visitorType) {
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
              color: Colors.purple[200],
            ),
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
  }
}

Widget getTempandMaskDetails(ActivitiesModel am) {
  return Container(
      height: 30,
      child: Row(
        children: [
          getTemperature(am),
          iswearingmask(am),
        ],
      ));
}

Widget getVehicleNumber(ActivitiesModel am) {
  return am.data!.vehicleNumber != ""
      ? Container(
          height: 30,
          child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.truck,
                size: 15.0,
                color: AppConstants.appcolors.appOrange,
              ),
              label: Text(
                am.data!.vehicleNumber,
                style: AppConstants.appStyles.iconButtonText,
              )))
      : Container(
          width: 0,
          height: 0,
        );
}

Widget getTemperature(ActivitiesModel am) {
  return (am.data!.temperature != null && am.data!.temperature != "")
      ? TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.device_thermostat_sharp,
            size: 18.0,
            color: AppConstants.appcolors.appOrange,
          ),
          label: Text(
            am.data!.temperature,
            style: AppConstants.appStyles.iconButtonText,
          ))
      : Container(width: 0, height: 0);
}

Widget iswearingmask(ActivitiesModel am) {
  return (am.data!.isWearingMask != null && am.data!.isWearingMask != "")
      ? TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.masks_outlined,
            size: 18.0,
            color: AppConstants.appcolors.appOrange,
          ),
          label: Text(
            'Is wearing mask',
            style: AppConstants.appStyles.iconButtonText,
          ))
      : Container(width: 0, height: 0);
}

Widget getTimeSlots(ActivitiesModel am) {
  return (am.data!.onceStartTime != null && am.data!.onceStartTime != "")
      ? TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.access_time_sharp,
            size: 18.0,
            color: AppConstants.appcolors.appOrange,
          ),
          label: Text(
            'Start Time : ${am.data!.onceStartTime},\nEntry valid for : ${am.data!.onceValidFor} hours',
            style: AppConstants.appStyles.iconButtonText,
          ))
      : Container(width: 0, height: 0);
}

Widget sizedContainer(Widget child) {
  return SizedBox(
    width: 60.0,
    height: 100.0,
    child: Padding(padding: EdgeInsets.all(2.0), child: Center(child: child)),
  );
}
