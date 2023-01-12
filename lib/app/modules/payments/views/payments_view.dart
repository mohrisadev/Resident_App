import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/buttons_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/app_widgets.dart';
import '../controllers/payments_controller.dart';

class PaymentsView extends GetView<PaymentsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentsController>(builder: (controller) {
      controller.updateScreenWidth(context);
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  controller.sc_height / 5), // here the desired height
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
                          padding:
                              EdgeInsets.only(top: controller.sc_height * .09),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          SizedBox(width: 25.0,),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25.0,
                            child: ClipRRect(borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(AppConstants.appimages.sampleimage,)),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                          controller.getgreetingString(),
                                          style: AppConstants.appStyles.screenTitle)),
                                  Padding(padding: EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: [
                                          Text('Customer Name',
                                              style: AppConstants.appStyles.smallTextwhite),
                                          Icon(Icons.verified, color: Colors.blue),
                                        ],
                                      )),
                                  Row(
                                    children: [
                                      getTitle(),
                                    ],
                                  ),
                                ],
                              ),
                          Spacer(), //
                          Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                          mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                                    children: [
                                      getalertIcon(),
                                      SizedBox(width: 10.0)
                                    ]),
                              ),
                            ],
                          ))
                    ],
                  ),),),
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
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: controller.isloading ? true : false,
                  child: ListView(
                    children: [
                      Expanded(
                          child: Container(
                              width: controller.sc_width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10,
                                      top: 10.0, bottom: 5.0),
                                  child: Column(
                                    children: [
                                      Card(
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Bill payments & Mobile Recharges",
                                                      style: AppConstants.appStyles.textweight600,
                                                    ),
                                                    trailing: Image.asset(
                                                      AppConstants.appimages
                                                          .bharatpaylogo,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                              SizedBox(
                                                  child: GridView.builder(
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      primary: true,
                                                      itemCount: controller
                                                          .BillsandPhonePaymentsList.length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                      ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        ButtonsModel b = controller
                                                                .BillsandPhonePaymentsList
                                                            .elementAt(index);
                                                        return paymentScreenButtons(
                                                            b, controller);
                                                      }
                                                      )
                                              ),
                                            ],
                                          )),
                                      SizedBox(height: 10.0,),
                                      Card(
                                      elevation: 10.0,
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),),
                                          child: Column(
                                            children: [
                                            Padding(padding: EdgeInsets.all(5.0),
                                            child: ListTile(
                                            title: Text("Home & Utility Bills",
                                            style: AppConstants.appStyles.textweight600,),)),
                                            SizedBox(
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: controller
                                              .homeUitlityBills.length,
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,),
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                  ButtonsModel b =
                                                    controller.homeUitlityBills.elementAt(index);
                                                  return paymentScreenButtons(b, controller);
                                                  })),
                                            ],
                                          )),
                                      SizedBox(height: 10.0,),
                                      Card(
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Health",
                                                      style: AppConstants
                                                          .appStyles
                                                          .textweight600,
                                                    ),
                                                  )),
                                              SizedBox(
                                                  child: GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .healthItems.length,
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                      ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        ButtonsModel b = controller
                                                                .healthItems
                                                            .elementAt(index);
                                                        return paymentScreenButtons(
                                                            b, controller);
                                                      })),
                                            ],
                                          )),

                                      SizedBox(height: 10.0,),
                                      Card(
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Finance",
                                                      style: AppConstants
                                                          .appStyles
                                                          .textweight600,
                                                    ),
                                                  )),
                                              SizedBox(
                                                  child: GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .financeItems.length,
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                      ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        ButtonsModel b = controller
                                                                .financeItems
                                                            .elementAt(index);
                                                        return paymentScreenButtons(
                                                            b, controller);
                                                      })),
                                            ],
                                          )),
                                     SizedBox(height: 10.0,),
                                      Card(
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Others",
                                                      style: AppConstants
                                                          .appStyles
                                                          .textweight600,
                                                    ),
                                                  )),
                                              SizedBox(
                                                  child: GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .othersItems.length,
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                      ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        ButtonsModel b = controller
                                                                .othersItems
                                                            .elementAt(index);
                                                        return paymentScreenButtons(
                                                            b, controller);
                                                      })),
                                            ],
                                          )),
                                    SizedBox(height: 10.0,),
                                      Card(
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Insurance",
                                                      style: AppConstants
                                                          .appStyles
                                                          .textweight600,
                                                    ),
                                                  )),
                                              SizedBox(
                                                  child: GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .insuranceItems.length,
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                      ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        ButtonsModel b = controller
                                                                .insuranceItems
                                                            .elementAt(index);
                                                        return paymentScreenButtons(
                                                            b, controller);
                                                      })),
                                            ],
                                          )),
                                    ],
                                  )))),
                    ],
                  )
              )
          ),
        bottomNavigationBar: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Icon(Icons.home),
               Icon(Icons.search),
               InkWell(
                 child: Icon(Icons.history),
                 onTap: (){
                   print("anita");
                   Get.toNamed(Routes.HISTORYDETAILS);
                 },
               ),
              ],
            )
        ),
      );
    });
  }
  Widget getalertIcon() {
    return InkWell(
      splashColor: AppConstants.appcolors.appOrange,
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  color: Colors.grey.shade200,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Icon(
                  Icons.notifications,
                  color: AppConstants.appcolors.appOrange,
                  size: 30,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: AppConstants.appcolors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text(
                       '5',
                    style: AppConstants.appStyles.smallTextwhite,
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget getTitle() {
    return AppConstants.activeFlat!.flatId! > 0
        ? TextButton.icon(
            icon: Icon(
          FontAwesomeIcons.locationDot,
              color: AppConstants.appcolors.appOrange,
              size: 14,
            ),
        label: Text(
        '${AppConstants.activeFlat!.flatNumber!} - ${AppConstants.activeFlat!.communityName!}',
            style: AppConstants.appStyles.smallTextwhite,),
            onPressed: () {

            },
          )
        :Text(AppConstants.appStrings.appName,
        style: AppConstants.appStyles.dashboardTitle,);
  }
}
