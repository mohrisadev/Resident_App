import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/sos/sos_categories_model.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../../../../shared/appconstants.dart';

class SoscategoriesView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
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
                                    Get.back();
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
                    children: [
                      Expanded(
                          flex: 1,
                          child: ListView.builder(
                              itemCount: controller.sosCategoriesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                SosCategoriesModel am = controller
                                    .sosCategoriesList
                                    .elementAt(index) as SosCategoriesModel;

                                return Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 10.0,
                                        child: getCard(am)));
                                //getCard(controller.notestoGuardList[index])));
                              })),
                    ],
                  ))));
    });
  }

  Widget getCard(SosCategoriesModel am) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              onTap: () => controller.updateSOSCategory(am),
              leading: Image.asset(am.imageUrl!, width: 60, height: 60),
              title: Text(
                am.category!,
                style: AppConstants.appStyles.sidehead,
              ),
              trailing: Icon(
                Icons.arrow_circle_right,
                size: 40.0,
                color: AppConstants.appcolors.appOrange,
              )),
        ],
      ),
    );
  }
}
