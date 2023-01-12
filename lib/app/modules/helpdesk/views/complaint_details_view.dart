import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/modules/helpdesk/controllers/helpdesk_controller.dart';

import '../../../../shared/appconstants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/modules/helpdesk/controllers/helpdesk_controller.dart';
import 'package:intl/intl.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/confirmedComplaintModel.dart';
import '../../../routes/app_pages.dart';

class ComplaintDetailsView extends GetView<HelpdeskController> {
  const ComplaintDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (() => controller.back()),
        child: GetBuilder<HelpdeskController>(builder: (controller) {
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80), // here the desired height
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppConstants.appimages.topBackground),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.00))),
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
                                        Get.toNamed(Routes.HELPDESK);
                                      },
                                      icon: Icon(Icons.close,
                                        color: Colors.white, size: 24,),
                                      label: Text(
                                        "  Complaint Details",
                                        style: AppConstants.appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    // Put here all widgets that are not slivers.
                    child: getComplaintDetails(),
                  ),

                  SliverToBoxAdapter(
                    // Put here all widgets that are not slivers.
                    child: getCommentsHead(),
                  ),
                  // Replace your ListView.builder with this:
                  getComments(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return postCommentButton();
                    }, childCount: 1),
                  ),
                ],
              ));
        }));
  }

  Widget getCommentsHead() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        "Comments",
        style: AppConstants.appStyles.complaintHead,
        textAlign: TextAlign.center,
      )
    ]);
  }

  Widget getComplaintDetails() {
    return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://dummyimage.com/60"),
                ),
                title: Text('${controller.sc!.category}',
                    style: AppConstants.appStyles.complaintHead),
                subtitle: Text('${controller.sc!.subCategory}',
                    style: AppConstants.appStyles.smallSidehead),
                trailing: getStatuswidget(controller.sc!.status.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Ticket ',
                        style: AppConstants.appStyles.smallText)),
                Expanded(
                  flex: 2,
                  child: Text('#${controller.sc!.ticketNumber}',
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
                  child: Text('Created On',
                      style: AppConstants.appStyles.smallText)),
              Expanded(
                  flex: 2,
                  child: getDateTime(controller.sc!.createdAt.toString())),
            ]),
            SizedBox(
              height: 5.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Last Update',
                      style: AppConstants.appStyles.smallText)),
              Expanded(
                  flex: 2,
                  child: getDateTime(controller.sc!.modifiedAt.toString())),
            ]),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Category ',
                      style: AppConstants.appStyles.smallText),
                ),
                Expanded(
                  flex: 2,
                  child: Text('${controller.sc!.category}',
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Sub Category ',
                      style: AppConstants.appStyles.smallText),
                ),
                Expanded(
                  flex: 2,
                  child: Text('${controller.sc!.subCategory}',
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Description ',
                      style: AppConstants.appStyles.smallText),
                ),
                Expanded(
                  flex: 2,
                  child: Text('${controller.sc!.description}',
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child:
                      Text('Status ', style: AppConstants.appStyles.smallText),
                ),
                Expanded(
                  flex: 2,
                  child: getStatuswidget(controller.sc!.status.toString()),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Assignee ',
                      style: AppConstants.appStyles.smallText),
                ),
                Expanded(
                  flex: 2,
                  child: Text(controller.sc!.assignee ?? "-",
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Resolved by ',
                      style: AppConstants.appStyles.smallText),
                ),
                Expanded(
                  flex: 2,
                  child: Text(controller.sc!.resolvedBy ?? "-",
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ],
            ),
            Divider(),
            getComplaintImages(controller.sc!.photos!.toList()),
          ]),
        ));
  }

  Widget getComplaintImages(List<Photo> photos) {
    ////print(photos.length);

    if (photos.isNotEmpty) {
      return SizedBox(
          height: 80.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                    padding: EdgeInsets.all(5.0),
                    //  child: InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                          tag: photos[index],
                          child: InkWell(
                              onTap: () {
                                controller.heroTapped(index,
                                    photos[index].image.toString(), "NetWord");
                              },
                              child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                width: 80.0,
                                height: 80.0,
                                imageUrl: photos[index].image.toString(),
                                placeholder: (context, url) =>
                                    Icon(Icons.hourglass_bottom),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ))),

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

  Widget getComments() {
    if (controller.sc!.comments!.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext ctxt, int index) {
          //  if (index >= controller.complaint.comments.length) return null;

          return Padding(
              padding: EdgeInsets.all(5.0),
              //  child: InkWell(
              child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        ' Ref # ${controller.sc!.comments![index].id}',
                                        style:
                                            AppConstants.appStyles.smallText)),
                                Expanded(
                                    flex: 0,
                                    child: getDateTime(controller
                                        .sc!.comments![index].commentedAt
                                        .toString())),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      ' By :  ${controller.sc!.comments![index].commentedBy}',
                                      style: AppConstants
                                          .appStyles.iconButtonText),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      ' ${controller.sc!.comments![index].comment}',
                                      style:
                                          AppConstants.appStyles.commentText),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Divider(),
                            getComplaintImages(controller
                                .sc!.comments![index].photos!
                                .toList()),
                          ]))));
        }, childCount: controller.sc!.comments!.length),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ListTile(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text(
                  "No comments yet.",
                  style: AppConstants.appStyles.datehead,
                ),
                Text(
                  "Be the first one to post a comment.",
                  style: AppConstants.appStyles.datehead,
                )
              ]));
        }, childCount: 1),
      );
    }
  }

  Widget getDateTime(dateString) {
    if (dateString != null) {
      DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateString);
      DateFormat newFormat = DateFormat.yMMMd('en_US');
      DateFormat newTimeFormat = DateFormat.jm('en_US');

      //newFormat.format(tempDate);
      // DateTime newDate =   (dateString).DateFormat.yMMMMd('en_US');

      return Text(
        '${newFormat.format(tempDate)} ${newTimeFormat.format(tempDate)}',
        style: AppConstants.appStyles.smallText,
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  Widget getStatuswidget(String _status) {
    //return Text(_status, style: AppConstants.appStyles.smallTextPrimary);

    if (_status == "NEW_STATUS" || _status == "New" || _status == "1") {
      return Text("New", style: AppConstants.appStyles.smallSidehead);
    } else if (_status == "IN_PROGRESS_STATUS" ||
        _status == "In Progress" ||
        _status == "2") {
      return Text("In Progress", style: AppConstants.appStyles.smallSidehead);
    } else if (_status == "RESOLVED_STATUS" ||
        _status == "Resolved" ||
        _status == "3") {
      return Text("Resolved", style: AppConstants.appStyles.smallSidehead);
    } else if (_status == "ON_HOLD_STATUS" ||
        _status == "On Hold" ||
        _status == "4") {
      return Text("On Hold", style: AppConstants.appStyles.smallSidehead);
    } else if (_status == "REOPENED_STATUS" ||
        _status == "Re Opened" ||
        _status == "5") {
      return Text("Re Opened", style: AppConstants.appStyles.smallSidehead);
    } else {
      return Container(width: 0, height: 0);
    }
  }

  Widget postCommentButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: AppConstants.appcolors.appOrange)),
            onPressed: () {
              controller.clearImagesandGotoPostCommentScreen();
            },
            color: AppConstants.appcolors.appOrange,
            child: Text("Post a Comment".toUpperCase(),
                style: AppConstants.appStyles.smallTextwhite),
          )),
    );
  }
}
