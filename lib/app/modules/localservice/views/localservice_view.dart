import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/local_service_model.dart';
import '../controllers/localservice_controller.dart';

class LocalserviceView extends GetView<LocalserviceController> {
  @override
  Widget build(BuildContext context) {
    controller.getLocalService();

    return WillPopScope(
        onWillPop: (() => controller.goback()),
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
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        "  ${controller.slsc!.name}",
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
                  isLoading: controller.isloading ? true : false,
                  child: getServentsList()));
        }));
  }

  Widget getServentsList() {
    if (controller.localservices.isNotEmpty) {
      return ListView.builder(
          //scrollDirection: Axis.horizontal,
          itemCount: controller.localservices.length,
          itemBuilder: (BuildContext ctxt, int index) {
            LocalServiceModal lsm = controller.localservices[index];
            return getCardView(lsm);
          });
    } else {
      return Center(
          child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Center(
              child: Text(
            AppConstants.appStrings.noLocalService,
            style: AppConstants.appStyles.sidehead,
          ))
        ],
      ));
    }
  }

  Widget getCardView(LocalServiceModal lsm) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5.0,
      child: InkWell(
        splashColor: Color(0xffECC7FE),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
                leading: getPhoto(lsm),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          lsm.name!.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          '${lsm.category}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: getFormatedPhoneNumber(lsm.contactNumber)),
                      SizedBox(height: 5,),
                    ]),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Icon(Icons.arrow_right, size: 35,),
                  ],
                ))

            //                        getmediaButtons(ni)
            ),
        onTap: () {
          controller.showServantDetails(lsm);
          // context.read<LocalServicesController>().selectedServantId = lsm.id;
          // context
          //     .read<LocalServicesController>()
          //     .navigateReplacePage(page: router.LocalServiceDetails);
        },
      ),
    );
  }

  Widget getPhoto(LocalServiceModal lsm) {
    return lsm.photo != null
        ? Padding(
            padding: EdgeInsets.all(5.0),
            //  child: InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: lsm.photo!,
                placeholder: (context, url) => Icon(Icons.hourglass_bottom),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),

              // ),
              //      onTap:(){
              //_gotoDetailsPage(context,item, 'customer ' + customerImagesList.indexOf(item).toString());
              //       }
            )
            // )
            )
        : Container(width: 0, height: 0,);
       }

  Widget getFormatedPhoneNumber(p) {
    if (p == null) {
      return Text("Phone : na", style: AppConstants.appStyles.smallText,);
    }
    if (p.toString().length <= 10) {
      return Text(p, style: AppConstants.appStyles.smallText,);
    } else {
      String formattedPhoneNumber = p.substring(0, 3) +
          " " +
          p.substring(3, 8) +
          " " +
          p.substring(8, p.length);
      return Text(formattedPhoneNumber,
        style: AppConstants.appStyles.smallText,
      );
    }
  }
}
