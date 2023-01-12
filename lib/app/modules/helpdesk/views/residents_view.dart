import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/ResidentsModel.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../../../data/models/resident_directory_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/helpdesk_controller.dart';

class ResidentsView extends GetView<HelpdeskController> {
  @override
  Widget build(BuildContext context) {
    controller.getListofResidents();
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
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  Residents Directory",
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
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.residentsSearchList.length,
                      //itemCount: controller.flatNumbers.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return getFlatDetails(controller.flatNumbers[index]);
                      })));
        }));
  }

  Widget getFlatDetails(String flatid) {
    return Card(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 10.0),
          Chip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(3),
            )),
            label: Text('${flatid}', style: AppConstants.appStyles.flatHead),
            labelPadding: EdgeInsets.all(5.0),
          ),
          Divider(),
          Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: getThlistofFlats(flatid))
        ],
      ),
      elevation: 10.0,
    );
  }

  Widget getThlistofFlats(String flatid) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: controller.residentsSearchList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          if (controller.residentsSearchList[index].flatNumber == flatid) {
            return ListTile(
                title: Text(
                  '${controller.residentsSearchList[index].firstName.toString()}'
                  ' ${controller.residentsSearchList[index].lastName.toString()}',
                  style: AppConstants.appStyles.nameHead,
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getResidentRole(controller.residentsSearchList[index].role
                          .toString()),
                      getFormatedPhoneNumber(controller
                          .residentsSearchList[index].phone
                          .toString()),
                      Divider(),
                    ]),
                trailing: CircleAvatar(
                  backgroundColor: AppConstants.appcolors.appOrange,
                  radius: 28.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 22.0,
                    ),
                  ),
                ),
                onTap: () {
                  Future.delayed(Duration(milliseconds: 100), () {
                    controller.makePhoneCall(
                        controller.residentsSearchList[index].phone.toString());
                  });
                });
          } else {
            return Container(
              width: 0,
              height: 0,
            );
          }
        });
  }

  Widget getResidentRole(String role) {
    return role.toLowerCase() == "owner"
        ? Chip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(5),
            )),
            label: Text(
              role,
              style: AppConstants.appStyles.smallTextwhite,
            ),
            backgroundColor: AppConstants.appcolors.primaryColor,
          )
        : Chip(
            label: Text(role, style: AppConstants.appStyles.smallTextPrimary),
            backgroundColor: Colors.white10);
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
        style: AppConstants.appStyles.sidehead,
      );
    } else {
      String formattedPhoneNumber = p.substring(0, 3) +
          " " +
          p.substring(3, 8) +
          " " +
          p.substring(8, p.length);

      return Text(
        formattedPhoneNumber,
        style: AppConstants.appStyles.textweight500,
      );
    }
  }
}
