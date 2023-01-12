import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mykommunity/app/modules/dashboard/views/dashboard_buttons.dart';
import 'package:mykommunity/app/modules/dashboard/views/sidebar_view.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/quick_activity_model.dart';
import '../../../routes/app_pages.dart';

class QuickActivityView extends GetView<DashboardController> {
  const QuickActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    controller.updateScreenWidth(context);
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<DashboardController>(builder: (controller) {
          return Scaffold(
              floatingActionButton: RotationTransition(
                  turns: AlwaysStoppedAnimation(0 / 360),
                  child: FloatingActionButton(
                    backgroundColor: AppConstants.appcolors.appOrange,
                    // shape: ContinuousRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20.0),
                    // ),
                    onPressed: () {
                      //Get.back();
                      // controller.updateIndex();
                      // Get.toNamed(Routes.DASHBOARD);
                    },
                    child: IconButton(
                      icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          transitionBuilder: (child, anim) =>
                              RotationTransition(
                                turns: child.key == ValueKey('icon1')
                                    ? Tween<double>(begin: 0.75, end: 1)
                                        .animate(anim)
                                    : Tween<double>(begin: 1, end: 0.75)
                                        .animate(anim),
                                child:
                                    FadeTransition(opacity: anim, child: child),
                              ),
                          child: controller.currIndex == 0
                              ? Icon(Icons.add, size: 24, key: const ValueKey('icon1'))
                              : Icon(
                                  Icons.close, size: 24,
                                  key: const ValueKey('icon2'),
                                )),
                      onPressed: () {
                        controller.updateIndex();
                        Get.toNamed(Routes.DASHBOARD);
                        // setState(() {
                        //   _currIndex = _currIndex == 0 ? 1 : 0;
                        // });
                      },
                    ),
                  )),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: getAnimatedBottomNavigationBar(controller),

              drawer: SidebarView(),

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
                              child: Text("Quick Activity",
                                  style: AppConstants
                                      .appStyles.mediumPagetitle))))),
              body: Container(
                width: double.infinity,
                // height: 600.0,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: GridView.builder(
                        itemCount: controller.quickActiveMenus.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                        itemBuilder: (BuildContext context, int index) {
                          QuickActivityModel am = controller.quickActiveMenus.elementAt(index);
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
                                        controller.showOptions(am);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.0),
                                          Image.asset(am.imageurl!,
                                              fit: BoxFit.fill),
                                          SizedBox(height: 15.0),
                                          Text(
                                            am.label!,
                                            style: AppConstants
                                                .appStyles.quickActiveListItem,
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
