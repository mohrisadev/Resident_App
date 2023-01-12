import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../controllers/helpdesk_controller.dart';

class RaisecomplaintView extends GetView<HelpdeskController> {
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
                                        Get.toNamed(Routes.HELPDESK);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  Provide  Details",
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
                  isLoading: controller.isLoading ? true : false,
                  child: Column(children: [
                    Expanded(
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.all(5),
                            child: ListView(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text('Category',
                                            style: AppConstants
                                                .appStyles.smallSidehead)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        '${controller.selectedComplaintCategory!.name}',
                                        style: AppConstants
                                            .appStyles.smallSidehead),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text('Subcategory',
                                            style: AppConstants
                                                .appStyles.smallSidehead)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: getSubcategoriesList(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text('Complaint Type',
                                            style: AppConstants
                                                .appStyles.smallSidehead)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: getComplaintType(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Description',
                                  style: AppConstants.appStyles.smallSidehead),
                              TextField(
                                minLines: 4,
                                maxLines: 7,
                                keyboardType: TextInputType.multiline,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  controller.remarks = value;
                                },
                                controller: controller.editControolerRemarks,
                                style: AppConstants.appStyles.messageText,
                                decoration: InputDecoration(
                                    labelText: "",
                                    hintText: "",
                                    //prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)))),
                              ),
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

                                        // // controller.submitComplaint();
                                        // AppConstants.appStrings.lastRoute =
                                        //     router.SubmitaComplaint;
                                        // context
                                        //     .read<SubmitaComplaintController>()
                                        //     .navigateToPage(
                                        //         page: router.CameraScreen);
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
                                        if (controller.remarks == null ||
                                            controller.remarks == "") {
                                          //controller.showAlert(context,"Test Message");
                                          // showSnackbar(context,"enter description");
                                          final snackBar = SnackBar(
                                              content:
                                                  Text("Enter description"));

                                          Scaffold.of(context)
                                              .showSnackBar(snackBar);
                                          return;
                                        }
                                        controller.submitComplaint();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Text(
                                          "SUBMIT COMPLAINT",
                                          style: AppConstants
                                              .appStyles.screenTitle,
                                        ),
                                      )))
                            ]))),
                  ])));
        }));
  }

  Widget getComplaintType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: controller.complaintTypeId,
          onChanged: (val) {
            controller.updateComplaintType(1, "Personal");
          },
        ),
        Text(
          'Personal',
          style: AppConstants.appStyles.smallText,
        ),
        Radio(
          value: 2,
          groupValue: controller.complaintTypeId,
          onChanged: (val) {
            controller.updateComplaintType(2, "Community");
          },
        ),
        Text(
          'Community',
          style: AppConstants.appStyles.smallText,
        ),
      ],
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.red),
    );
  }

  Widget getSubcategoriesList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: controller.subcatid,
          onChanged: (val) {
            controller.updateCatSubcat(1, "Complaint");
          },
        ),
        GestureDetector(
            onTap: () {
              controller.updateCatSubcat(1, "Complaint");
            },
            child: Text(
              'Complaint',
              style: AppConstants.appStyles.smallText,
            )),
        Radio(
          value: 2,
          groupValue: controller.subcatid,
          onChanged: (val) {
            controller.updateCatSubcat(2, "Request");
          },
        ),
        Text(
          'Request',
          style: AppConstants.appStyles.smallText,
        ),
      ],
    );
  }

  getCategoriesListView() {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              controller.filterSearchResults(value);
            },
            controller: controller.editingController,
            style: AppConstants.appStyles.tileText,
            decoration: InputDecoration(
                labelText: "",
                hintText: "",
                //prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)))),
          ),
        ]));
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
                        child: InkWell(
                          child: Image.file(
                            File(controller.newImages[index].localurl),
                          ),
                          onTap: () {
                            //print(controller.newImages[index].id);
                          },
                        )));
              }));
    } else {
      return Container(width: 0, height: 0);
    }
  }

}
