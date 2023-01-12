import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/data/models/quick_activity_model.dart';

import '../../../../shared/appconstants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class CommunityView extends GetView<DashboardController> {
  const CommunityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    controller.updateScreenWidth(context);
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<DashboardController>(builder: (controller) {
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
                      child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Community",
                                  style: AppConstants
                                      .appStyles.mediumPagetitle))))),
              body: Container(
                width: double.infinity,
                // height: 600.0,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: GridView.builder(
                        itemCount: controller.communityScreenMenus.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3),
                        itemBuilder: (BuildContext context, int index) {
                          QuickActivityModel am =
                              controller.communityScreenMenus.elementAt(index);

                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 10.0,
                              child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: InkWell(
                                      splashColor:
                                          AppConstants.appcolors.appOrange,
                                      onTap: () {
                                        controller.showCommunityWidget(am);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget> [
                                          Image.asset(am.imageurl!,
                                              fit: BoxFit.fill),
                                          SizedBox(height: 10.0),
                                          Text(am.label!,
                                            style: AppConstants.appStyles.quickActiveListItem,
                                          )
                                        ],
                                      ))));
                        })),
              ));
        }));
  }

  Widget sizedContainer(Widget child) {
    return SizedBox(
      width: 60.0,
      height: 100.0,
      child: Padding(padding: EdgeInsets.all(2.0), child: Center(child: child)),
    );
  }
}
