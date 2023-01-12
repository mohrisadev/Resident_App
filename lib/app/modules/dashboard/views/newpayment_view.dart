import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../shared/appconstants.dart';
import '../../../../shared/shared_widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class NewpaymentView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
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
                                        "  New Payment",
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
                      newPaymentBox(),
                    ],
                  )));
        }));
  }

  Widget newPaymentBox() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext ctxt, int index) {
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
                          Text(
                            "Amount Details",
                            style: AppConstants.appStyles.smallSidehead,
                          ),
                          TextField(
                            minLines: 1,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            textInputAction: TextInputAction.done,
                            controller: controller.amountController,
                            style: AppConstants.appStyles.emergencyContact,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: '',
                                hintStyle: AppConstants.appStyles.smallSidehead,

                                //prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)))),
                          ),
                          SizedBox(height: 15),
                          Text("Reasons for Payment",
                              style: AppConstants.appStyles.smallSidehead),
                          TextField(
                            minLines: 3,
                            maxLines: 10,
                            keyboardType: TextInputType.multiline,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              controller.updaetPaymentRemarks(value);
                            },
                            controller: controller.commentController,
                            style: AppConstants.appStyles.tileText,
                            decoration: InputDecoration(
                                // labelText: "Reason for payment",
                                // hintText: "Reason for payment",
                                hintStyle: AppConstants.appStyles.smallText,
                                //prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)))),
                          ),
                          Divider(),
                          _paymentChips(),
                          Divider(),
                          SizedBox(height: 15),
                          Center(
                              child: ElevatedButton(
                            onPressed: () {
                              if (controller.paymentRemarks == null ||
                                  controller.paymentRemarks == "") {
                                Get.snackbar(
                                    'Error', 'Enter reason for payment',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppConstants.appcolors.appOrange,
                                    snackPosition: SnackPosition.TOP);
                                return;
                              }
                              controller.postPayment();
                            },
                            child: Text(
                              ' Save ',
                              style: AppConstants.appStyles.buttonText,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppConstants.appcolors.appOrange,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          )),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              "${controller.paymentRemarks}",
                              style: AppConstants.appStyles.commentText,
                            ),
                          )
                        ]))));
      }, childCount: 1),
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
            SizedBox(height: 10.0,),
            //  getComplaintImages(controller.complaint.photos),
          ]),
        ));
  }

  Widget getServantImage() {
    return SizedBox(
        height: 150,
        width: 150,
        child: Padding(padding: EdgeInsets.all(5.0),
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

  Widget _paymentChips() {
    return Container(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.paymentOptions.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(3.0),
              child: ChoiceChip(
                label: Text(controller.paymentOptions[index]),
                selected: controller.choiceIndex == index,
                selectedColor: Colors.green,
                onSelected: (bool selected) {
                  controller.updatePaymentoption(index);
                  print(controller.paymentOptions[index]);
                  controller.modeofPayment = controller.paymentOptions[index];
                },
                backgroundColor: Colors.grey,
                labelStyle: TextStyle(color: Colors.white),
              ));
        },
      ),
    );
  }
}
