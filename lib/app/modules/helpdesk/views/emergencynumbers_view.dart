import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/shared/appconstants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../controllers/helpdesk_controller.dart';

class EmergencynumbersView extends GetView<HelpdeskController> {
  @override
  Widget build(BuildContext context) {
    controller.getListofEmergencyContacts();
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
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
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  Emergency Contacts",
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
                  child: ListView.builder(
                      itemCount: controller.emergency_contacts_list.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Card(
                          margin: EdgeInsets.all(6.0),
                          elevation: 4,
                          child: Stack(children: <Widget>[
                            InkWell(
                              splashColor: AppConstants.appcolors.primaryColor,
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${controller.emergency_contacts_list[index].title}',
                                                  style: AppConstants.appStyles
                                                      .emergencyContact,
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                getFormatedPhoneNumber(controller
                                                    .emergency_contacts_list[
                                                        index]
                                                    .contact
                                                    .toString()),
                                              ]),
                                          trailing: Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                            size: 32.0,
                                          ),
                                        ),

                                        //   getImages(controller.confirmed_complaintsList[index].photos.toList()),
                                      ])),
                              onTap: () {
                                Future.delayed(Duration(milliseconds: 100), () {
                                  controller.makePhoneCall(controller
                                      .emergency_contacts_list[index].contact
                                      .toString());
                                });
                              },
                            ),
                          ]),
                        );
                      })));
        }));
  }

  Widget getFormatedPhoneNumber(p) {
    if (p == null) {
      return Text(
        "Phone : na",
        style: AppConstants.appStyles.smallText,
      );
    }

    if (p.toString().length <= 10) {
      return Text(
        p,
        style: AppConstants.appStyles.smallText,
      );
    } else {
      String formattedPhoneNumber = p.substring(0, 3) +
          " " +
          p.substring(3, 8) +
          " " +
          p.substring(8, p.length);

      return Text(
        formattedPhoneNumber,
        style: AppConstants.appStyles.smallText,
      );
    }
  }
}
