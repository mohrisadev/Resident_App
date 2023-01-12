import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../../../../shared/appconstants.dart';

class GetContactView extends GetView<DashboardController> {
  const GetContactView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
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
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  label: Text(
                                    "  Your contacts",
                                    style:
                                        AppConstants.appStyles.mediumPagetitle,
                                  )),
                            )),
                      ]))),
          body: ListView.builder(
            itemCount: controller.contacts!.length,
            itemBuilder: (BuildContext context, int index) {
              Contact c = controller.contacts!.elementAt(index);
              return Card(
                  child: ListTile(
                      onTap: () {
                        controller.fetchContactInformation(c);
                      },
                      leading: (c.avatar != null && c.avatar!.isNotEmpty)
                          ? CircleAvatar(
                              backgroundColor:
                                  AppConstants.appcolors.primaryColor,
                              backgroundImage: MemoryImage(c.avatar!))
                          : CircleAvatar(
                              backgroundColor:
                                  AppConstants.appcolors.primaryColor,
                              child: Text(c.initials())),
                      title: Text(c.displayName ?? "")));
              // trailing: AddFromContact(
              //     phoneNumbers: c.phones,
              //     contactName: c.displayName,
              //     memberType: controller.memberType));
            },
          ));
    });
  }
}
