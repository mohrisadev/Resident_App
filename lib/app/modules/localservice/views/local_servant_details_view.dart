import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/localservice/controllers/localservice_controller.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/local_service_model.dart';
import '../../../routes/app_pages.dart';

class LocalServantDetailsView extends GetView<LocalserviceController> {
  @override
  Widget build(BuildContext context) {
    controller.get_lsm_details();
    return WillPopScope(
        onWillPop: (() => controller.goback()),
        child: GetBuilder<LocalserviceController>(builder: (controller) {
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
                                        Get.toNamed(Routes.LOCALSERVICE_CATEGORIES);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      label: Text(
                                        " ${controller.selectedServant!.name}  details",
                                        style: AppConstants.appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: controller.isloading ? true : false,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        // Put here all widgets that are not slivers.
                        child: getServantDetails(),
                      ),
                    ],
                  )
              ),
          );
        }
        )
    );
  }
  Widget getServantDetails() {
    return Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            getServantImage(controller.selectedServant!),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Ref # ',
                        style: AppConstants.appStyles.smallSidehead)),
                Expanded(
                  flex: 2,
                  child: Text('${controller.lsmDetails.id}',
                      style: AppConstants.appStyles.emergencyContact),
                ),
              ],
            ),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Name',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsmDetails.name}',
                    style: AppConstants.appStyles.nameHead),
              ),
            ]),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Category',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsmDetails.category}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Phone Number',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child:
                    getFormatedPhoneNumber(controller.lsmDetails.contactNumber),
              ),
            ]),
            SizedBox(height: 10.0,),
            Divider(),
            Text('House holds', style: AppConstants.appStyles.smallSidehead),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child: //Text(controller.lsmDetails.households.toString()),
                    gethouseholdlist(),
              ),
            ]),
            SizedBox(height: 10.0,),
            Divider(),
            bottomButtons(),
            Divider(),
            //  getComplaintImages(controller.complaint.photos),
            SizedBox(height: 10.0),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Ratings",
                      style: AppConstants.appStyles.sidehead,
                    ))),
            SizedBox(height: 10.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Rating',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsmDetails.ratings!.rating}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Rating Count',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsmDetails.ratings!.ratingCount}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Punctual Count',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsmDetails.ratings!.punctualCount!}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Regular Count',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsmDetails.ratings!.regularCount}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Exceptional Count',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text(
                    '${controller.lsmDetails.ratings!.exceptionalCount!}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(height: 5.0,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  flex: 1,
                  child: Text('Attitude Count',
                      style: AppConstants.appStyles.smallSidehead)),
              Expanded(
                flex: 2,
                child: Text('${controller.lsmDetails.ratings!.attitudeCount}',
                    style: AppConstants.appStyles.emergencyContact),
              ),
            ]),
            SizedBox(height: 15.0,),
            postRatingButton(),
          ]),
        ));
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

  Widget postRatingButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: AppConstants.appcolors.primaryColor)),
            onPressed: () {
              AwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.INFO,
                headerAnimationLoop: false,
                animType: AnimType.TOPSLIDE,
                title: 'Local Service Rating',
                desc: 'Would you like to provide rating to this local service',
                buttonsTextStyle: TextStyle(color: Colors.white),
                btnOkText: "Yes",
                btnCancelText: "No",
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();
            },
            color: AppConstants.appcolors.primaryColor,
            textColor: Colors.white,
            child: Text("Post Rating".toUpperCase(),
                style: AppConstants.appStyles.phoneNumberWhite),
          )),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.red),
    );
  }

  Widget getServantImage(LocalServiceModal selectedServant) {
    if (selectedServant.photo != null) {
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
                  imageUrl: selectedServant.photo!,
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
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  Widget gethouseholdlist() {
    if (controller.lsmDetails.households!.isNotEmpty) {
      return SizedBox(
          height: 100.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(5),
              itemCount: controller.lsmDetails.households!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 10.0,
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            '${controller.lsmDetails.households![index]["block_name"]}',
                            style: AppConstants.appStyles.titledarkhead,
                          ),
                          Divider(),
                          Text(
                            'Flat #  ${controller.lsmDetails.households![index]["flat_number"]}',
                            style: AppConstants.appStyles.smallSidehead,
                          ),
                        ],
                      )),
                );
              }));
    } else {
      return Container(width: 0, height: 0);
    }
  }

  Widget bottomButtons() {
    return SizedBox(
        height: 60,
        child: ListView(
          padding: EdgeInsets.all(5.0),
          scrollDirection: Axis.horizontal,
          children: [
            OutlinedButton(
              child: Text("Add to Household",
                  style: AppConstants.appStyles.sideheadblue),
              onPressed: () {
                AwesomeDialog(
                  context: Get.context!,
                  dialogType: DialogType.QUESTION,
                  headerAnimationLoop: false,
                  animType: AnimType.TOPSLIDE,
                  title: 'Add to Household',
                  desc: 'Do you really want to add this servent to your household ?',
                  buttonsTextStyle: TextStyle(color: Colors.white),
                  btnOkText: "Yes",
                  btnCancelText: "No",
                  showCloseIcon: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                  controller.addtoHouseHold();
                  },
                ).show();
              },
            ),
            SizedBox(width: 5.0,),
            OutlinedButton(
              child: Text("Remove from Household",
              style: AppConstants.appStyles.sideheadorange),
              onPressed: () {
                AwesomeDialog(
                  context: Get.context!,
                  dialogType: DialogType.QUESTION,
                  headerAnimationLoop: false,
                  animType: AnimType.TOPSLIDE,
                  title: 'Remove from Household',
                  desc: 'Do you really want to remove this servent from your household ?',
                  buttonsTextStyle: TextStyle(color: Colors.white),
                  btnOkText: "Yes",
                  btnCancelText: "No",
                  showCloseIcon: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    controller.removeFromHouseHold();
                    // context
                    //     .read<LocalServicesController>()
                    //     .removeFromHouseHold();
                  },
                ).show();
              },
            ),
          ],
        )
    );
  }
}
