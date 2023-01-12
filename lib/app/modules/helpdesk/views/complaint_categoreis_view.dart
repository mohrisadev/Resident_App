import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:get/get.dart';
import 'package:mykommunity/app/data/models/complaint_category.dart';
import 'package:mykommunity/app/modules/helpdesk/controllers/helpdesk_controller.dart';
import 'package:intl/intl.dart';
import '../../../../shared/appconstants.dart';

class ComplaintCategoriesView extends GetView<HelpdeskController> {
  const ComplaintCategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getListofComplaintCategories();
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
                      fit: BoxFit.cover,),
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
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  Select Category",
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
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: controller.complaintCategories.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                ComplaintCategory cc = controller
                                    .complaintCategories
                                    .elementAt(index);

                                return Card(
                                  child: InkWell(
                                      splashColor: Colors.orange[600],
                                      onTap: () {
                                        controller
                                            .updateStatsAndRaiseComplaint(cc);
                                      },
                                      child: ListTile(
                                          dense: true,
                                          title: Text('${cc.name}',
                                              style: AppConstants
                                                  .appStyles.sidehead))),
                                  //   ListTile(title: Text('${item['name']}'))
                                );
                              }))
                    ],
                  )));
        }));
  }
}
