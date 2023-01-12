import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/helpdesk/controllers/helpdesk_controller.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/confirmedComplaintModel.dart';

class PostCommentView extends GetView<HelpdeskController> {
  const PostCommentView({Key? key}) : super(key: key);
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
                                      Icons.close,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    label: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 25.0),
                                            child: Text(
                                              "  Post a comment",
                                              style: AppConstants
                                                  .appStyles.mediumPagetitle,
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "     Add your views",
                                              style: AppConstants
                                                  .appStyles.smallTextwhite,
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: controller.isLoading ? true : false,
                  child: Column(children: [
                    Expanded(
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.all(15),
                            child: ListView(children: [
                              Text("Write a Comment",
                                  style: AppConstants.appStyles.smallSidehead),
                              TextField(
                                minLines: 5,
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  controller.updateCommentString(value);
                                },
                                controller: controller.commentController,
                                style: AppConstants.appStyles.tileText,
                                decoration: InputDecoration(
                                    labelText: "",
                                    hintText: "Enter your comments",
                                    hintStyle:
                                        AppConstants.appStyles.smallTextPrimary,
                                    //prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)))),
                              ),
                              Divider(),
                              getCapturedImages(controller),
                              Divider(),
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                      child: Row(children: [
                                        Icon(
                                          FontAwesomeIcons.image,
                                          color: AppConstants
                                              .appcolors.primaryColor,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text("Attach Photo..",
                                            style: AppConstants
                                                .appStyles.smallTextorange),
                                      ]),
                                      onTap: () {
                                        controller.showCamera();
                                      })),
                              Divider(),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: RaisedButton(
                                      color:
                                          AppConstants.appcolors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: AppConstants
                                                  .appcolors.primaryColor)),
                                      onPressed: () {
                                        if (controller.commenetsString ==
                                                null ||
                                            controller.commenetsString == "") {
                                          //controller.showAlert(context,"Test Message");
                                          // showSnackbar(context,"enter description");

                                          Get.snackbar(
                                              'Error', 'Enter comments',
                                              snackPosition:
                                                  SnackPosition.BOTTOM);

                                          return;
                                        }
                                        controller.postComment();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Text(
                                          "Post a Comment",
                                          style: AppConstants
                                              .appStyles.screenTitle,
                                        ),
                                      ))),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "${controller.commenetsString}",
                                  style: AppConstants.appStyles.commentText,
                                ),
                              )
                            ])))
                  ])));
        }));
  }

  getCapturedImages(controller) {
    if (controller.newImages.length > 0) {
      return SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(5),
              itemCount: controller.newImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 150,
                    child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Hero(
                            tag: controller.newImages[index].toString(),
                            child: InkWell(
                              child: Image.file(
                                File(controller.newImages[index].localurl),
                              ),
                              onTap: () {
                                controller.heroTapped(
                                    index,
                                    controller.newImages[index].localurl
                                        .toString(),
                                    "local");
                              },
                            ))));
              }));
    } else {
      return Container(width: 0, height: 0);
    }
  }
}
