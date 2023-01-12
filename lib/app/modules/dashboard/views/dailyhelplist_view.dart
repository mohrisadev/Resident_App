import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/local_service_model.dart';
import '../../../routes/app_pages.dart';

class DailyhelplistView extends GetView<DashboardController> {
  const DailyhelplistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(Get.context!).size.height / 4,
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.myDailyHelp.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        LocalServiceModal dh =
                            controller.myDailyHelp.elementAt(index);

                        return getCardView(dh);
                      }))
            ],
          )),
    );
  }

  Widget getPhoto(LocalServiceModal lsm) {
    return lsm.photo != null
        ? Padding(
            padding: EdgeInsets.all(5.0),
            //  child: InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 80.0,
                width: 80.0,
                fit: BoxFit.fitWidth,
                imageUrl: lsm.photo!,
                placeholder: (context, url) => Icon(Icons.hourglass_bottom),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )
            // )
            )
        : Container(width: 0, height: 0);
  }

  Widget getCardView(LocalServiceModal lsm) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8.0,
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: SizedBox(
            width: 250.0, //MediaQuery.of(Get.context!).size.width / 1.65,
            height: 130.0, // MediaQuery.of(Get.context!).size.height / 6,
            child: Column(children: [
              ListTile(
                horizontalTitleGap: 6.0,
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(lsm.photo != null
                      ? lsm.photo!
                      : "https://dummyimage.com/60"),
                ),
                title: Text(lsm.name.toString().toUpperCase(),
                    style: AppConstants.appStyles.sidehead),
                subtitle: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Wrap(
                      children: <Widget>[
                        Chip(
                            backgroundColor:
                                AppConstants.appcolors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            )),
                            label: Text(
                              lsm.category!,
                              style: AppConstants.appStyles.smallTextwhite,
                            ))
                        // Container(
                        //     padding: EdgeInsets.all(4.0),
                        //     decoration: BoxDecoration(
                        //       color: AppConstants.appcolors.primaryColor,
                        //       shape: BoxShape.rectangle,
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),

                        //  C(
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(
                        //     Radius.circular(3),
                        //   )),
                        //   alignment: WrapAlignment.center,
                        //   crossAxisAlignment: WrapCrossAlignment.center,
                        //   children: <Widget>[
                        //     Text(lsm.category!,
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //         )),
                        //     InkWell(
                        //         onTap: () {},
                        //         child: Icon(
                        //           Icons.check_circle,
                        //           color: Colors.green,
                        //         )),
                        //   ],
                        //)
                      ],
                    )),
              ),
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
                                    child: Text("Payment",
                                        style: AppConstants
                                            .appStyles.sideheadorange),
                                    onPressed: () {
                                      paymentBottomSheet(lsm);
                                      // ignore: avoid_single_cascade_in_expression_statements
                                      // AwesomeDialog(
                                      //   context: Get.context!,
                                      //   dialogType: DialogType.INFO,
                                      //   headerAnimationLoop: false,
                                      //   animType: AnimType.TOPSLIDE,
                                      //   title: 'New Payment Information',
                                      //   desc:
                                      //       'View payment history & Make new payments',
                                      //   buttonsTextStyle:
                                      //       TextStyle(color: Colors.white),
                                      //   btnOkText: "New Payment",
                                      //   btnCancelText: "Payment History",
                                      //   showCloseIcon: true,
                                      //   btnCancelOnPress: () {
                                      //     // context
                                      //     //     .read<LocalServicesController>()
                                      //     //     .selectedServantId = lsm.id;

                                      //     // context
                                      //     //     .read<LocalServicesController>()
                                      //     //     .navigateReplacePage(
                                      //     //         page: router.PaymentHistory);
                                      //   },
                                      //   btnOkOnPress: () {
                                      //     // context
                                      //     //     .read<LocalServicesController>()
                                      //     //     .selectedServantId = lsm.id;

                                      //     // context
                                      //     //     .read<LocalServicesController>()
                                      //     //     .navigateReplacePage(
                                      //     //         page: router.NewPaymentPage);
                                      //   },
                                      // )..show();
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
                                    child: Text("Attendance",
                                        style: AppConstants
                                            .appStyles.smallTextwhite),
                                    onPressed: () {
                                      attendenceBottomSheet(lsm);
                                    },
                                  ))),
                        ],
                      )))),
            ]),
          ),
        ));
  }

  void attendenceBottomSheet(LocalServiceModal lsm) {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
              height: 280,
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
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Attendance Info',
                                    style: AppConstants
                                        .appStyles.bottomSheetTitle),
                              ],
                            ))),
                  ),
                  SizedBox(height: 20.0),
                  Text('Attendance Information',
                      style: AppConstants.appStyles.mediumPrimaryhead),
                  Text('Record or View attendance history of this Person',
                      style: AppConstants.appStyles.smallText),
                  Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.updateLSM(lsm);
                              Get.toNamed(Routes.ATTENDENCE_HISTORY);
                            },
                            child: Text(
                              ' Check History ',
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
                              controller.markasPresent(lsm);
                            },
                            child: Text(
                              ' Mark Present ',
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

  void paymentBottomSheet(LocalServiceModal lsm) {
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
                                Text('Payment Information',
                                    style: AppConstants
                                        .appStyles.bottomSheetTitle),
                                Text('check details',
                                    style:
                                        AppConstants.appStyles.smallTextwhite),
                              ],
                            ))),
                  ),
                  SizedBox(height: 20.0),
                  Text('Payment Information',
                      style: AppConstants.appStyles.mediumPrimaryhead),
                  Text('View Payment History or make New Payments',
                      style: AppConstants.appStyles.smallText),
                  Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.updateLSM(lsm);
                              Get.toNamed(Routes.PAYMENT_HISTORY);
                            },
                            child: Text(
                              ' Payment History ',
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
                              controller.updateLSM(lsm);
                              Get.toNamed(Routes.NEW_PAYMENT_PAGE);
                            },
                            child: Text(
                              ' New Payment ',
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
}
