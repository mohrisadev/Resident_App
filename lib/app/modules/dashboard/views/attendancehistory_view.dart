import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../shared/appconstants.dart';
import '../../../../shared/shared_widgets.dart';
import '../../../data/models/localservice_category.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class AttendancehistoryView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    controller.attadance_history();
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
                                        "  Attendance History",
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
                  isLoading: false, // controller.isloading ? true : false,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        // Put here all widgets that are not slivers.
                        child: getServantDetails(),
                      ),
                      //Replace your ListView.builder with this:

                      getAttadanceHistory(),
                    ],
                  )));
        }));
  }

  Widget getAttadanceHistory() {
    if (controller.attadanceHistoryList.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext ctxt, int index) {
          //  if (index >= controller.complaint.comments.length) return null;

          return Padding(
              padding: EdgeInsets.all(5.0),
              //  child: InkWell(
              child: Card(
                  elevation: 5.0,
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        '${Jiffy(controller.attadanceHistoryList[index].presentOn).yMMMMd}',
                                        style:
                                            AppConstants.appStyles.smallText)),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                          ]))));
        }, childCount: controller.attadanceHistoryList.length),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ListTile(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text(
                  "No attendance records found.",
                  style: AppConstants.appStyles.datehead,
                )
              ]));
        }, childCount: 1),
      );
    }
  }

  Widget getDateandTime(DateTime dt) {
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(dt);
    return Text('${date}', style: AppConstants.appStyles.smallText);
  }

  Widget getCardView(LocalServiceCategory lsm) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2.0,
      child: InkWell(
        splashColor: Color(0xffECC7FE),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
                leading: Text(lsm.id.toString()),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          '${lsm.name?.toUpperCase()}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ]),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_right,
                      size: 35,
                    ),
                  ],
                ))

            //                        getmediaButtons(ni)
            ),
        onTap: () {
          //controller.showServicePeople(lsm);
          // context.read<LocalServicesController>().selectedCategoryId = lsm.id;
          // context
          //     .read<LocalServicesController>()
          //     .navigateToPage(page: router.LocalServices);
        },
      ),
    );
  }

  Widget getServantDetails() {
    return Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            getServantImage(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Ref # ',
                        style: AppConstants.appStyles.smallSidehead)),
                Expanded(
                  flex: 2,
                  child: Text('${controller.lsm!.id}',
                      style: AppConstants.appStyles.emergencyContact),
                ),
              ],
            ),

            SizedBox(
              height: 5.0,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Name',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsm!.name}',
                    style: AppConstants.appStyles.nameHead),
              ),
            ]),

            SizedBox(
              height: 5.0,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Category',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsm!.category}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(
              height: 5.0,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Phone Number',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: getFormatedPhoneNumber(controller.lsm!.contactNumber),
              ),
            ]),

            SizedBox(
              height: 10.0,
            ),

            //  getComplaintImages(controller.complaint.photos),
          ]),
        ));
  }

  Widget getServantImage() {
    return SizedBox(
        height: 150,
        width: 150,
        child: Padding(
            padding: EdgeInsets.all(5.0),
            //  child: InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                width: 130.0,
                height: 130.0,
                imageUrl: controller.lsm!.photo != null
                    ? controller.lsm!.photo!
                    : "https://dummyimage.com/90",
                placeholder: (context, url) => Icon(Icons.hourglass_bottom),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),

              // ),
              //      onTap:(){
              //_gotoDetailsPage(context,item, 'customer ' + customerImagesList.indexOf(item).toString());
              //       }
            )
            // )
            ));
  }
}
