import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/sos/sos_categories_model.dart';
import '../controllers/dashboard_controller.dart';

class SoscountdownView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    controller.displayCoundonwImages();
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0), // here the desired height
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstants.appimages.topBackground),
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
                                    controller.clearTimerandClose();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  label: Text(
                                    "  SOS Alert",
                                    style:
                                        AppConstants.appStyles.mediumPagetitle,
                                  )),
                            )),
                      ]))),
          body: LoadingOverlay(
              opacity: 0.9,
              color: Colors.white,
              progressIndicator: CircularProgressIndicator(),
              isLoading: controller.appState == AppState.Busy ? true : false,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.0),
                      Image.asset(controller.selectedSOScategory!.imageUrl!,
                          fit: BoxFit.fill, width: 75, height: 75),
                      Text(
                        controller.selectedSOScategory!.category!,
                        style: AppConstants.appStyles.mediumPrimaryhead,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'User SOS only in case of emergency',
                        style: AppConstants.appStyles.commentText,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Image.asset(controller.counterImage,
                          fit: BoxFit.fill, width: 200, height: 200),
                      Spacer(),
                      Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      AppConstants.appcolors.appredcolor,
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Cancel Alert",
                                        style: AppConstants
                                            .appStyles.phoneNumberWhite)),
                                onPressed: () {
                                  controller.clearTimerandClose();
                                },
                              ))),
                    ],
                  ))));
    });
  }
}
