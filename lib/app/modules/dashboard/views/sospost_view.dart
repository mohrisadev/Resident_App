import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/sos/sos_categories_model.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/sos_alerts_model.dart';
import '../controllers/dashboard_controller.dart';

class SospostView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    controller.getSOSAlerts();
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
                              itemCount: controller.sosAlertsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                SosAlertsModel am = controller.sosAlertsList
                                    .elementAt(index) as SosAlertsModel;

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

  Widget getCard(SosAlertsModel am) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  am.name!,
                  style: AppConstants.appStyles.phoneNumberText,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  width: 75.0,
                  height: 75.0,
                  imageUrl: "https://dummyimage.com/60",
                  placeholder: (context, url) => Icon(Icons.hourglass_bottom),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(width: 5.0),
                Spacer(),
                SizedBox(
                    width: MediaQuery.of(Get.context!).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_city,
                              size: 18.0,
                              color: AppConstants.appcolors.appOrange,
                            ),
                            label: Text(
                              am.flats.toString(),
                              style: AppConstants.appStyles.smallSidehead,
                            )),
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.phone,
                              size: 18.0,
                              color: AppConstants.appcolors.appOrange,
                            ),
                            label: Text(
                              am.phone.toString(),
                              style: AppConstants.appStyles.textweight500,
                            )),
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.access_time,
                              size: 18.0,
                              color: AppConstants.appcolors.appOrange,
                            ),
                            label: Text(
                              Jiffy(am.startTime).yMMMMEEEEdjm,
                              style: AppConstants.appStyles.textweight500,
                            )),
                      ],
                    ))
              ],
            ),
            Center(
                child: TextButton.icon(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: getbtnBackgounrColor(am)),
                    onPressed: () {},
                    icon: Image.asset(
                      getsosImage(am),
                      fit: BoxFit.fill,
                    ),
                    label: Text(
                      getSOSmesasge(am),
                      //am.emergencyType!.toString(),
                      style: AppConstants.appStyles.phoneNumberWhite,
                    ))),
          ],
        ));
  }

  getSOSmesasge(SosAlertsModel s) {
    int cnt = controller.sosCategoriesList
        .where((el) => el.dbcode! == s.emergencyType!)
        .length;

    if (cnt > 0) {
      SosCategoriesModel es = controller.sosCategoriesList
          .where((el) => el.dbcode! == s.emergencyType!)
          .first;
      return es.category;
    } else {
      return "OTHER EMERGENCY";
    }
  }

  getsosImage(SosAlertsModel s) {
    int cnt = controller.sosCategoriesList
        .where((el) => el.dbcode! == s.emergencyType!)
        .length;

    if (cnt > 0) {
      SosCategoriesModel es = controller.sosCategoriesList
          .where((el) => el.dbcode! == s.emergencyType!)
          .first;
      return es.imageUrl;
    } else {
      return AppConstants.appimages.other;
    }
  }

  getbtnBackgounrColor(SosAlertsModel s) {
    if (s.resolvedType == 1) {
      return AppConstants.appcolors.greenButton;
    } else if (s.resolvedType == 2) {
      return AppConstants.appcolors.appredcolor;
    } else {
      return AppConstants.appcolors.appOrange;
    }
  }
}
