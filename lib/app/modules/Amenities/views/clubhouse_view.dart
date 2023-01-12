import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/Amenities/views/payment_view.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/amenities_controller.dart';



class ClubHouseView extends GetView<AmenitiesController> {
  bool visible = false;
  bool _isShow = true;
  double sc_width = 0.0;
  double sc_height = 0.0;
  DateTime? currentDate = DateTime.now();
  DateTime? currentDate2 = DateTime.now();
  var onceStartTime = "time";
  String validhours = "pick";
  String? selectedDate;
  String validfromdate = "Select Date";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.getAmenities();
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<AmenitiesController>(builder: (controller) {
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80), // here the desired height
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                          image: AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,),
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
                                        Get.back();
                                      },
                                      icon: Icon(Icons.arrow_back,
                                        color: Colors.white, size: 24,),
                                      label: Text("Club House",
                                        style: AppConstants.appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,),
                  isLoading: controller.isLoading ? true : false,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),),
                            border: Border.all(width: 0.1, color: Colors.black38),
                            color: Colors.white,),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Description"),
                              SizedBox(height: 10,),
                              Text('${controller.aa?.amenityName}'),
                            ],
                          )
                      ),
                      const SizedBox(height: 30,),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),),
                            border: Border.all(width: 0.1, color: Colors.black38),
                            color: Colors.white,),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Paid"),
                              SizedBox(height: 10,),
                              Text("Max Days Per Flat"),
                              SizedBox(height: 10,),
                              Text("30 Days Per Month"),
                              Text("(30 Days Avalable this Month)"),
                              Divider(),
                              Text("Max Capacity"),
                              SizedBox(height: 10,),
                              Text("1 People"),
                              Divider(),
                              Text("Advance booking Limit"),
                              SizedBox(height: 10,),
                              Text("90 days"),
                              Divider(),
                              Text("Booking Type"),
                              SizedBox(height: 10,),
                              Text("Single"),
                              Divider(),
                              Text("Booking Details"),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("10 June 2022"),
                                  InkWell(
                                    onTap: () {
                                      dispalyCalender();
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                    ],
                  )));
        }));
  }

  void dispalyCalender() {
    DateTime? picked;
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        isScrollControlled: false,
        builder: (context) {
          return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,),
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.00))),
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Select Date',
                                    style: AppConstants.appStyles.bottomSheetTitle),
                              ],
                            ))),
                  ),
                  Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 20),
                          child: Html(data: 'Select Date',))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black12,
                        ),
                        child: Center(child: Text("Fri")),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black12,
                        ),
                        child: Center(child: Text("Fri")),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black12,
                        ),
                        child: Center(child: Text("Fri")),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              SizedBox(width: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Get.back();
                                },
                                child: Text(
                                  ' Cancel ',
                                  style: AppConstants.appStyles.buttonText,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black12,
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.00), // <-- Radius
                                  ),
                                ),
                              )
                            ],
                          )),
                      SizedBox(width: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(width: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  dispalyAmount();
                                },
                                child: Text(' Apply ',
                                  style: AppConstants.appStyles.buttonText,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: AppConstants.appcolors.appOrange,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.00), // <-- Radius
                                  ),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    height: 200,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        minimumYear: DateTime.now().year,
                        minimumDate: DateTime.now(),
                        maximumDate: DateTime.now().add(Duration(days: 60)),
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          picked = val;
                          //update();
                        }),
                  ),
                ],
              )
          );
        });
  }

  void dispalyAmount() {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                          AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.00))),
                       height: 80,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Select Slots',
                                    style: AppConstants.appStyles.bottomSheetTitle),
                              ],
                            ))),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 18,
                                    vertical: 10),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange[600],),
                                child: Icon(Icons.task_alt_rounded, size: 15,
                                  color: AppConstants.appcolors.appWhite,),
                              ),
                              Text("6AM-7PM"),
                            ],
                          ),
                          Text("4000"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 10),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.orange[600],),
                                  child: Icon(Icons.add, size: 15,
                                    color: AppConstants.appcolors.appWhite,),
                                ),
                                onTap: () {
                        Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>  PaymentView()),
                              );
                                  // Visibility(
                                  //   visible: _isShow,
                                  //   maintainSize: true, //NEW
                                  //   maintainAnimation: true, //NEW
                                  //   maintainState: true, //NEW
                                  //   child: Image.asset(
                                  //     'assets/images/hen.png',
                                  //     height: 300,
                                  //     width: 300,
                                  //   ),
                                  // );
                                },
                              ),
                            Text("6AM-7PM"),
                            ],
                          ),
                        Text("4000")
                        ],
                      ),
                    ],
                  )
                ],
              )
          );
        }
    );
  }
}