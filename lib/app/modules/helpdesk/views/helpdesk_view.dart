import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/helpdesk/controllers/helpdesk_controller.dart';
import 'package:intl/intl.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/confirmedComplaintModel.dart';

class HelpdeskView extends GetView<HelpdeskController> {
  const HelpdeskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.setInitialValue();
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<HelpdeskController>(builder: (controller) {
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
                                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 24,),
                                      label: Text("  Help Desk",
                                        style: AppConstants.appStyles.mediumPagetitle,)),
                                )),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: controller.isLoading ? true : false,
                  child: Container(
                      width: double.infinity,
                      // height: 600.0,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: ListView.builder(
                                  itemCount: controller
                                      .confirmed_complaintsList.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    ConfirmedComplaintModal c = controller
                                        .confirmed_complaintsList
                                        .elementAt(index);
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      margin: EdgeInsets.all(8.0),
                                      elevation: 5,
                                      child: Column(children: <Widget>[
                                        InkWell(
                                          splashColor: AppConstants
                                              .appcolors.primaryColor,
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    getStatuswidget(
                                                        c.status.toString()),
                                                    getDateTime(
                                                        c.createdAt.toString()),
                                                    ListTile(
                                                        subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  c.subCategory
                                                                      .toString(),
                                                                  style: AppConstants
                                                                      .appStyles
                                                                      .smallText),
                                                              Text(
                                                                c.description
                                                                    .toString(),
                                                                style: AppConstants
                                                                    .appStyles
                                                                    .smallText,
                                                              ),
                                                            ]),
                                                        title: Text(
                                                          c.category.toString(),
                                                          style: AppConstants
                                                              .appStyles
                                                              .complaintTitle,
                                                        ),
                                                        trailing: Column(
                                                          children: [
                                                            //Text("Created On"),
                                                            Chip(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                  Radius.circular(5),
                                                                )),
                                                                backgroundColor:
                                                                    AppConstants
                                                                        .appcolors
                                                                        .appOrange,
                                                                label: Text(
                                                                  "Ticket # ${c.ticketNumber.toString()}",
                                                                  style: AppConstants
                                                                      .appStyles
                                                                      .smallTextwhite,
                                                                )),

                                                            // getResolveDate(controller.confirmed_complaintsList[index].created_at.toString())
                                                          ],
                                                        )),
                                                    getImages(
                                                        c.photos!.toList()),
                                                    Divider(),
                                                    Center(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              controller.showDetasils(c);
                                                            },
                                                            child: Text(
                                                              "Comments",
                                                              style: AppConstants
                                                                  .appStyles
                                                                  .commentsSection,
                                                            )))
                                                  ])),
                                          onTap: () {
                                            Future.delayed(
                                                Duration(milliseconds: 100),
                                                () {
                                              controller.showDetasils(c);
                                            });
                                          },
                                        ),
                                        // Positioned(
                                        //   top: 0,
                                        //   child: Container(
                                        //     padding: EdgeInsets.symmetric(
                                        //         vertical: 4, horizontal: 6),
                                        //     decoration: BoxDecoration(
                                        //         color: getStatusColor(controller
                                        //             .confirmed_complaintsList[index]
                                        //             .resolvedBy
                                        //             .toString()
                                        //             .trim()),
                                        //         borderRadius: BorderRadius.only(
                                        //           topLeft: Radius.circular(8),
                                        //           bottomRight: Radius.circular(8),
                                        //         ) // green shaped
                                        //         ),
                                        //     child: Text(
                                        //       "Ticket # ${controller.confirmed_complaintsList[index].ticketNumber.toString()}",
                                        //       style: AppConstants.appStyles.medium,
                                        //     ),
                                        //   ),
                                        // ),
                                      ]),
                                    );
                                  })),
                          Expanded(
                              flex: 0,
                              child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: AppConstants.appcolors.appOrange)),
                                    onPressed: () {
                                      Get.toNamed(Routes.COMPLAINT_CATEGORIES);
                                      // //print("test");

                                      // context
                                      //     .read<DashboardController>()
                                      //     .navigateToPage(page: router.RaiseComplaint);
                                    },
                                    color: AppConstants.appcolors.appOrange,
                                    textColor: Colors.white,
                                    child: Text("Raise Complaint".toUpperCase(),
                                        style:
                                            AppConstants.appStyles.buttonText),
                                  )
                              )
                          ),
                        ],
                      )

                      // for(var item in controller.confirmed_complaintsList)
                      // {
                      //     complaintWidget(item);
                      // }

                      // } else {
                      //   return Center(
                      //       child: new ListView(
                      //     padding: const EdgeInsets.all(20.0),
                      //     children: [
                      //       new Center(
                      //           child: new Text(
                      //         AppConstants.appStrings.noComplaints,
                      //         style: AppConstants.appStyles.sidehead,
                      //       ))
                      //     ],
                      //   ));
                      // },

                      //   Padding(
                      //       padding: EdgeInsets.all(20.0),
                      //       child: RaisedButton(
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(18.0),
                      //             side: BorderSide(
                      //                 color: AppConstants.appcolors.primaryColor)),
                      //         onPressed: () {
                      //           // //print("test");

                      //           // context
                      //           //     .read<DashboardController>()
                      //           //     .navigateToPage(page: router.RaiseComplaint);
                      //         },
                      //         color: AppConstants.appcolors.primaryColor,
                      //         textColor: Colors.white,
                      //         child: Text("Raise Complaint".toUpperCase(),
                      //             style: AppConstants.appStyles.medium),
                      //       ))
                      //// ])
                      )));
        }));
  }

  Widget getDateTime(dateString) {
    if (dateString != null) {
      ////print(dateString);
      DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateString);

      DateFormat newFormat = new DateFormat.yMMMd('en_US');
      DateFormat newTimeFormat = new DateFormat.jm('en_US');

      //newFormat.format(tempDate);
      // DateTime newDate =   (dateString).DateFormat.yMMMMd('en_US');

      return Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            '${newFormat.format(tempDate)} ${newTimeFormat.format(tempDate)}',
            style: AppConstants.appStyles.smallText,
          ));
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  Widget getImages(List<Photo> photos) {
    ////print(photos.length);

    if (photos.isNotEmpty) {
      // return Text("img");
      return SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: photos.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                    padding: EdgeInsets.all(5.0),
                    //  child: InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        width: 60.0,
                        height: 55.0,
                        imageUrl: photos[index].image.toString(),
                        placeholder: (context, url) =>
                            Icon(Icons.hourglass_bottom),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),

                      // ),
                      //      onTap:(){
                      //_gotoDetailsPage(context,item, 'customer ' + customerImagesList.indexOf(item).toString());
                      //       }
                    )
                    // )
                    );
              }));
    } else {
      return Container(width: 0, height: 0);
    }
  }

  Widget getStatuswidget(String _status) {
    //return Text(_status, style: AppConstants.appStyles.smallTextPrimary);

    if (_status == "NEW_STATUS" || _status == "New" || _status == "1") {
      return TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.tag,
            size: 15.0,
            color: AppConstants.appcolors.primaryColor,
          ),
          label: Text(
            "New",
            style: AppConstants.appStyles.smallTextPrimary,
          ));
    } else if (_status == "IN_PROGRESS_STATUS" ||
        _status == "In Progress" ||
        _status == "2") {
      return TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.error,
              size: 15.0, color: AppConstants.appcolors.darkOrange),
          label: Text(
            "In Progress",
            style: AppConstants.appStyles.smallTextorange,
          ));
    } else if (_status == "RESOLVED_STATUS" ||
        _status == "Resolved" ||
        _status == "3") {
      return TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.check,
            size: 15.0,
            color: AppConstants.appcolors.greenButton,
          ),
          label: Text(
            "Resolved",
            style: AppConstants.appStyles.smallTextGreen,
          ));
    } else if (_status == "ON_HOLD_STATUS" ||
        _status == "On Hold" ||
        _status == "4") {
      return TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.error,
            size: 15.0,
            color: AppConstants.appcolors.appPincColor,
          ),
          label: Text(
            "On Hold",
            style: AppConstants.appStyles.smallTextred,
          ));
    } else if (_status == "REOPENED_STATUS" ||
        _status == "Re Opened" ||
        _status == "5") {
      return TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.error,
            size: 15.0,
            color: AppConstants.appcolors.primaryColor,
          ),
          label: Text(
            "Re Opened",
            style: AppConstants.appStyles.smallTextPrimary,
          ));
    } else {
      return Container(width: 0, height: 0);
    }
  }

  Color getStatusColor(resolvedBy) {
    if (resolvedBy.isEmpty || resolvedBy == " ") {
      return AppConstants.appcolors.appOrange;
    } else {
      return Colors.green;
    }
  }
}
