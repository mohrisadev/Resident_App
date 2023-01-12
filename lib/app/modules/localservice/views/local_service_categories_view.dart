import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/localservice/controllers/localservice_controller.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/localservice_category.dart';
import '../../../routes/app_pages.dart';

class LocalServiceCategoriesView extends GetView<LocalserviceController> {
  @override
  Widget build(BuildContext context) {
    controller.getLocalServiceCategoriesList();
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<LocalserviceController>(builder: (controller) {
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
                                        Get.toNamed(Routes.DASHBOARD);
                                      },
                                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 24,),
                                      label: Text("  Local Service Categories",
                                      style: AppConstants.appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                  color: AppConstants.appcolors.primaryColor,),
                  isLoading: controller.isloading ? true : false,
                  child: getCategories()));
        }));
  }

  Widget getCategories() {
    if (controller.localServiceCategoryList.isNotEmpty) {
      return ListView.builder(
          //scrollDirection: Axis.horizontal,
          itemCount: controller.localServiceCategoryList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            LocalServiceCategory lsm =
                controller.localServiceCategoryList[index];
            return getCardView(lsm);
          });
    } else {
      return Center(
          child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Center(
              child: Text(
            AppConstants.appStrings.noCategories,
            style: AppConstants.appStyles.sidehead,
          ))
        ],
      ));
    }
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
                      SizedBox(height: 5,),
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
                    Icon(Icons.arrow_right, size: 35,),
                  ],
                ))

            //                        getmediaButtons(ni)
            ),
        onTap: () {
          controller.showServicePeople(lsm);

          // context.read<LocalServicesController>().selectedCategoryId = lsm.id;
          // context
          //     .read<LocalServicesController>()
          //     .navigateToPage(page: router.LocalServices);
        },
      ),
    );
  }
}
