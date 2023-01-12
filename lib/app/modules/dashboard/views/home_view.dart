import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/buttons_model.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mykommunity/app/modules/dashboard/views/activites_horizontal_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/dashboard_buttons.dart';
import 'package:mykommunity/app/modules/dashboard/views/notices_horizontal_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/quick_activity_view.dart';
import 'package:mykommunity/app/modules/dashboard/views/sidebar_view.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';

import '../../../widgets/app_widgets.dart';

class HomeView extends GetView<DashboardController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.updateScreenWidth(context);
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(

         drawer: SidebarView(),

          appBar: PreferredSize(
              preferredSize: Size.fromHeight(controller.sc_height / 5), // here the desired height
              child: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppConstants.appimages.topBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: 45.0, left: 25.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(child: Image.asset(
                                AppConstants.appimages.bblogotop,
                                fit: BoxFit.fill,
                              )),
                              Spacer(), //
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      getalertIcon(),
                                      SizedBox(width: 10.0),
                                      getSettingsButton(),
                                      SizedBox(width: 10.0)
                                    ]),
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                              children: [
                            Builder(
                              builder: (context) => IconButton(
                                icon: Icon(Icons.sort, color: Colors.white, size: 40,),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(
                                        '\n${controller.getgreetingString()}',
                                        style: AppConstants.appStyles.screenTitle)),
                                Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Row(
                                      children: [
                                        Text(getName(),
                                            style: AppConstants.appStyles.smallTextwhite),
                                        Icon(Icons.verified, color: Colors.blue),
                                      ],
                                    )),
                              ],
                            )
                          ])),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                getTitle(),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ))),
          body: Container(
              width: double.infinity,
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.appimages.topBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,),
                  isLoading: controller.loadingAdvertisements ? true : false,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                              width: controller.sc_width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                // image: DecorationImage(
                                //   colorFilter: ColorFilter.mode(
                                //       Colors.black.withOpacity(0.05),
                                //       BlendMode.dstATop),
                                //   image: AssetImage(
                                //       AppConstants.appimages.app_logo),
                                //   fit: BoxFit.contain,
                                // )
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: ListView(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Container(child: CarouselSlider(
                                            options: CarouselOptions(
                                              autoPlay: true,
                                              autoPlayInterval: Duration(seconds: 7),
                                              enlargeCenterPage: true,
                                              viewportFraction: 0.9,
                                              aspectRatio: 2.0,
                                              initialPage: 2,
                                            ),
                                            items: controller.advertisementsList
                                                .map((item) => GestureDetector(
                                                    onTap: () {
                                                  controller.openWebLink(item);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                                      height: 130.0,
                                                      width: controller.sc_width * .8,
                                                      child: Image.network(
                                                        item.photo!,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )))
                                                .toList(),
                                          ))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 1.0, left: 10.0),
                                        child: Text("VISITORS",
                                          style: AppConstants.appStyles.dashboardSideHeadText,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 105.0,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: controller.homepagebuttons.length,
                                              itemBuilder: (BuildContext context, int index) {
                                      ButtonsModel b = controller.homepagebuttons.elementAt(index);
                                                return paymentScreenButtons(b, controller);
                                              })),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 10.0),
                                            viewRecentActivitesButton(controller),
                                            SizedBox(width: 10.0),
                                            manageHouseHoldButton(controller),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text("RECENT ACTIVITIES",
                                              style: AppConstants.appStyles.dashboardSideHeadText,
                                            ),
                                          ),
                                          recentActivitesViewAllButton(controller),
                                        ],
                                      ),
                                      Container(
                                        height: 220,
                                          child: ActivitesHorizontalView()),
                                      SizedBox(height: 15),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              "NOTICE BOARD",
                                              style: AppConstants.appStyles.dashboardSideHeadText,
                                            ),
                                          ),
                                          noticeViewAllButton(),
                                        ],
                                      ),
                                      Container(
                                      height: 200,
                                      child: NoticesHorizontalView()),
                                      SizedBox(height: 25),
                                    ],
                                  )))),
                    ],
                  ))));
              });
         }
  getName() {
    return controller.userProfile != null
        ? '${controller.userProfile!.firstName} ${controller.userProfile!.lastName}'
        : 'Resident Name';
  }
  Widget getTitle() {
    return AppConstants.activeFlat!.flatId! > 0
        ? TextButton.icon(
            icon: Icon(FontAwesomeIcons.locationDot,
              color: AppConstants.appcolors.appOrange,
              size: 14,),
             label: Text(
              '${AppConstants.activeFlat!.flatNumber!} - ${AppConstants.activeFlat!.communityName!}',
              style: AppConstants.appStyles.smallTextwhite,
            ),
            onPressed: () {},
          )
        :Text(AppConstants.appStrings.appName,
        style: AppConstants.appStyles.dashboardTitle,
          );
  }
}
