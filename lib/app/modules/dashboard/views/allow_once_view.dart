import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/data/models/quick_activity_model.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_share/flutter_share.dart';
import '../../../data/models/guests/pre_approved_guest_model.dart';

class AllowOnceView extends GetView<DashboardController> {
  AllowOnceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0), // here the desired height
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstants.appimages.topBackground),
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
                                    Get.back();
                                  },
                                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 24,),
                                  label: Text(
                                    "  Allow Once",
                                    style:
                                        AppConstants.appStyles.mediumPagetitle,
                                  )),
                            )),
                        Padding(
                            padding: EdgeInsets.only(right: 30.0, top: 30.0),
                            child: getContactButton(
                                controller.selectedVisitorTypeOnce)),
                      ]))),
          body: Container(
              color: Colors.white, width: double.infinity, child: getformBody()
              //Padding(padding: EdgeInsets.all(5), child: Text("Allow once")),
              ));
    });
  }

  Widget getContactButton(QuickActivityModel? qv) {
    if (qv!.visitorCode == 1) {
      return InkWell(
        splashColor: AppConstants.appcolors.appOrange,
        onTap: () async {
          if (controller.contacts!.isNotEmpty) {
            Get.toNamed(Routes.GET_CONTACTS);
          } else {
            final PermissionStatus permissionStatus = await _getPermission();
            if (permissionStatus == PermissionStatus.granted) {
              controller.refreshContacts().then((value) => Get.toNamed(Routes.GET_CONTACTS));
            } else {}
          }
        },
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
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Icon(
                    Icons.contact_phone,
                    color: AppConstants.appcolors.appOrange,
                    size: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(width: 0, height: 0,);
    }
  }

  Widget getformBody() {
    switch (controller.selectedVisitorTypeOnce!.visitorCode) {
      case 1:
        return guestVisitorOnce();
      case 2:
        return guestCabOnce();
      case 3:
        return guestDeliveryOnce();
      case 4:
        return visitingHelpOnce();
      case 5:
        return Container(width: 0, height: 0);
      case 6:
        return Container(width: 0, height: 0);
      default:
        return Container(width: 0, height: 0);
    }
  }

  Widget visitingHelpOnce() {
    return ListView(
      children: [
        SizedBox(height: 15.0),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                AppConstants.appimages.visitingHelpCircle,
              )),
        ),
        Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Visiting / Help  Details",
              style: AppConstants.appStyles.menuSidehead,
            )),
        Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(12.0),
            //decoration: myBoxDecoration(), //             <--- BoxDecoration here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                shape: Border.all(color: Colors.white38, width: 1),
                child: ListTile(
                  onTap: () {
                   // controller.getFromDateTimepickerWidget();
                    controller.showDatePickerIosStyle();
                  },
                  dense: true,
                  trailing: Icon(Icons.arrow_drop_down_circle_rounded, size: 40.0,
                  color: AppConstants.appcolors.appOrange,),
                  title: Text('${controller.validfromdate}',
                  style: AppConstants.appStyles.smallSidehead),
                ),
              ),
            )),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Start Time",
            style: AppConstants.appStyles.smallText,
          ),
          Text(
            "Valid for Next",
            style: AppConstants.appStyles.smallText,
          ),
        ]),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          getTimeWidget(),
          getHourlySlot(),
        ]),
        Divider(),
        Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            //decoration: myBoxDecoration(), //             <--- BoxDecoration here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                shape: Border.all(
                    color: AppConstants.appcolors.primaryColor, width: 1),
                child: ListTile(
                  onTap: () {
                    displayVisitingHelpCategoriesBottomSheet();
                  },
                  dense: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  title: Text(controller.selectedCategory,
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ),
            )),
        Divider(),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                if ((controller.validfromdate == "Select Date") ||
                    (controller.validfromdate == "")) {
                  Fluttertoast.showToast(
                      msg: "Select date",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }

                if (controller.onceValidForinHrs == null) {
                  Fluttertoast.showToast(
                      msg: "Set Time & Vlidity",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }
                controller.submitAllowVisitingOnce();
              },
              child: Text(
                ' Update ',
                style: AppConstants.appStyles.buttonText,
              ),
              style: ElevatedButton.styleFrom(
                primary: AppConstants.appcolors.appOrange,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ))
      ],
    );
  }

  Widget guestDeliveryOnce() {
    return ListView(
      children: [
        SizedBox(height: 15.0),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                AppConstants.appimages.deliveryCircle,
              )),
        ),
        Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Delivery Details",
              style: AppConstants.appStyles.menuSidehead,
            )),
        Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(12.0),
            //decoration: myBoxDecoration(), //             <--- BoxDecoration here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                shape: Border.all(color: Colors.white38, width: 1),
                child: ListTile(
                  onTap: () {
                    //controller.getFromDateTimepickerWidget();
                    controller.showDatePickerIosStyle();
                  },
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_drop_down_circle_rounded,
                    size: 40.0,
                    color: AppConstants.appcolors.appOrange,
                  ),
                  title: Text('${controller.validfromdate}',
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ),
            )),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Start Time",
            style: AppConstants.appStyles.smallText,
          ),
          Text(
            "Valid for Next",
            style: AppConstants.appStyles.smallText,
          ),
        ]),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          getTimeWidget(),
          getHourlySlot(),
        ]),
        Divider(),
        Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            //decoration: myBoxDecoration(), //             <--- BoxDecoration here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                shape: Border.all(
                    color: AppConstants.appcolors.primaryColor, width: 1),
                child: ListTile(
                  onTap: () {
                    displayDeliveryCompanyBottomSheet();
                  },
                  dense: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  title: Text(controller.selectedDeliveryVendor!,
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ),
            )),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                    controller.leavePackageAtGate == true
                        ? Icons.check_box_sharp
                        : Icons.check_box_outline_blank,
                    size: 35.0,
                    color: AppConstants.appcolors.appOrange),
                onPressed: () {
                  controller.updateLeavePackageAtGate();
                },
              ),
              title: Text(
                "Leave Package at Gate",
                style: AppConstants.appStyles.tilesidehead,
              ),
              onTap: () {
                controller.updateLeavePackageAtGate();
              },
            )),
        Divider(),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                if ((controller.validfromdate == "Select Date") ||
                    (controller.validfromdate == "")) {
                  Fluttertoast.showToast(
                      msg: "Select date",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }

                if (controller.onceValidForinHrs == null) {
                  Fluttertoast.showToast(
                      msg: "Set Time & Vlidity",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }
                controller.submitAllowDeliveryOnce();
              },
              child: Text(
                ' Update ',
                style: AppConstants.appStyles.buttonText,
              ),
              style: ElevatedButton.styleFrom(
                primary: AppConstants.appcolors.appOrange,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ))
      ],
    );
  }

  Widget guestCabOnce() {
    return ListView(
      children: [
        SizedBox(height: 15.0),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                AppConstants.appimages.cabCircle,
              )),
        ),
        Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Cab Details",
              style: AppConstants.appStyles.menuSidehead,
            )),
        Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(12.0),
            //decoration: myBoxDecoration(), //             <--- BoxDecoration here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                shape: Border.all(color: Colors.white38, width: 1),
                child: ListTile(
                  onTap: () {
                    //controller.getFromDateTimepickerWidget();
                    controller.showDatePickerIosStyle();
                  },
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_drop_down_circle_rounded,
                    size: 40.0,
                    color: AppConstants.appcolors.appOrange,
                  ),
                  title: Text('${controller.validfromdate}',
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ),
            )),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Start Time",
            style: AppConstants.appStyles.smallText,
          ),
          Text(
            "Valid for Next",
            style: AppConstants.appStyles.smallText,
          ),
        ]),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          getTimeWidget(),
          getHourlySlot(),
        ]),
        Divider(),
        Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            //decoration: myBoxDecoration(), //             <--- BoxDecoration here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                shape: Border.all(
                    color: AppConstants.appcolors.primaryColor, width: 1),
                child: ListTile(
                  onTap: () {
                    displayCabCompanyBottomSheet();
                  },
                  dense: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  title: Text(controller.selectedCompany,
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ),
            )),
        if (controller.errMsg != null && controller.errMsg != "")
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                controller.errMsg!,
                style: AppConstants.appStyles.smallTextred,
              )),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Add last 4 ditis of vehicle no',
              style: AppConstants.appStyles.sidehead),
        ),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: OtpTextField(
                numberOfFields: 4,
                showFieldAsBox: true,
                borderColor: AppConstants.appcolors.primaryColor,
                focusedBorderColor: AppConstants.appcolors.appOrange,
                onSubmit: (String vechilecNunmber) {
                  controller.vehicleNo = vechilecNunmber;
                })),
        Divider(),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                if ((controller.validfromdate == "Select Date") ||
                    (controller.validfromdate == "")) {
                  Fluttertoast.showToast(
                      msg: "Select date",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }

                if (controller.onceValidForinHrs == null) {
                  Fluttertoast.showToast(
                      msg: "Set Time & Vlidity",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }
                controller.submitAllowCabOnce();
              },
              child: Text(
                ' Update ',
                style: AppConstants.appStyles.buttonText,
              ),
              style: ElevatedButton.styleFrom(
                primary: AppConstants.appcolors.appOrange,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ))
      ],
    );
  }

  Widget guestVisitorOnce() {
    return ListView(
      children: [
        SizedBox(height: 15.0),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                AppConstants.appimages.visitorCircle,
              )),
        ),
        Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Guest Details",
              style: AppConstants.appStyles.menuSidehead,
            )),
        if (controller.loadingContacts)
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 10),
              child: CircularProgressIndicator(
                color: AppConstants.appcolors.primaryColor,
              )),
        Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
                child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                                controller: controller.nameController,
                                cursorColor:
                                    AppConstants.appcolors.primaryColor,
                                autofocus: false,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  labelText: 'Enter Guest Name',
                                  hintStyle:
                                      AppConstants.appStyles.smallTextgrey,
                                  hintText: 'eg. Raja Ram',
                                  labelStyle: AppConstants.appStyles.smallText,
                                  // enabledBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color:
                                  //         AppConstants.appcolors.primaryColor,
                                  //   ),
                                  // ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppConstants.appcolors.primaryColor,
                                    ),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppConstants.appcolors.primaryColor,
                                    ),
                                  ),
                                ))),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                                controller: controller.phoneController,
                                maxLength: 15,
                                cursorColor:
                                    AppConstants.appcolors.primaryColor,
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Guest Phone Number',
                                  hintStyle:
                                      AppConstants.appStyles.smallTextgrey,
                                  hintText: 'Enter mobile number',
                                  counter: SizedBox.shrink(),
                                  labelStyle: AppConstants.appStyles.smallText,
                                  // enabledBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color:
                                  //         AppConstants.appcolors.primaryColor,
                                  //   ),
                                  // ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppConstants.appcolors.primaryColor,
                                    ),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppConstants.appcolors.primaryColor,
                                    ),
                                  ),
                                ))),
                      ],
                    )))),
        if (controller.errMsg != null && controller.errMsg != "")
          Text(
            controller.errMsg!,
            style: AppConstants.appStyles.smallTextred,
          ),
        Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(12.0),
            //decoration: myBoxDecoration(), //             <--- BoxDecoration here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                shape: Border.all(color: Colors.white38, width: 1),
                child: ListTile(
                  onTap: () {
                    //controller.getFromDateTimepickerWidget();
                    controller.showDatePickerIosStyle();
                  },
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_drop_down_circle_rounded,
                    size: 40.0,
                    color: AppConstants.appcolors.appOrange,
                  ),
                  title: Text('${controller.validfromdate}',
                      style: AppConstants.appStyles.smallSidehead),
                ),
              ),
            )),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Start Time",
            style: AppConstants.appStyles.smallText,
          ),
          Text(
            "Valid for Next",
            style: AppConstants.appStyles.smallText,
          ),
        ]),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          getTimeWidget(),
          getHourlySlot(),
        ]),
        Divider(),
        Padding(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                if (controller.nameController.text == "" ||
                    controller.phoneController.text == "") {
                  Fluttertoast.showToast(
                      msg: "Enter Guest Name and Mobile number",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }
                if ((controller.validfromdate == "Select Date") ||
                    (controller.validfromdate == "")) {
                  Fluttertoast.showToast(
                      msg: "Select date",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }

                if (controller.onceValidForinHrs == null ||
                    controller.onceValidForinHrs == 0) {
                  Fluttertoast.showToast(
                      msg: "Set Time & Vlidity",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                }

                controller.submitAllowGuestOnce().then((v) => getGuestInfo(v!));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppConstants.appcolors.appOrange),
              ),
              child: Text(
                ' Update ',
                style: AppConstants.appStyles.buttonTextBold,
              ),
            )),
      ],
    );
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission == PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.restricted;
    } else {
      return permission;
    }
  }

  Widget getHourlySlot() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Colors.red)),

      onPressed: () {
        //selectTime(context,controller);

        controller.shownexthoursmodel();
      },
      // color: Theme.of(context).accentColor,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              '${controller.validhours}',
              style: AppConstants.appStyles.smallText,
            ),
            Icon(
              Icons.arrow_drop_down,
            )
          ],
        ),
      ),
    );
  }

  Widget getTimeWidget() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Colors.red)),

      onPressed: () {
        //StateSetter setState;
        controller.selectTime();
      },
      // color: Theme.of(context).accentColor,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              controller.onceStartTime,
              style: AppConstants.appStyles.smallText,
            ),
            Icon(
              Icons.arrow_drop_down,
            )
          ],
        ),
      ),
    );
  }

  void getGuestInfo(PreApprovedGuestModel ag) {
    Get.bottomSheet(
      Container(
          height: controller.sc_height / 2,
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
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
                    height: 100,
                    width: controller.sc_width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Guest\nCheck the details",
                          style: AppConstants.appStyles.bottomSheetTitle),
                    ),
                  ),
                  Container(
                    width: controller.sc_width,
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Text(ag.name.toString(),
                                  style: AppConstants.appStyles.complaintTitle),
                              Divider(),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Mobile  ',
                                      style:
                                          AppConstants.appStyles.quickactions),
                                  Spacer(),
                                  Text(ag.phone.toString(),
                                      style:
                                          AppConstants.appStyles.quickactions)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Entry Date ',
                                      style:
                                          AppConstants.appStyles.quickactions),
                                  Spacer(),
                                  Text(ag.validFromDate.toString(),
                                      style:
                                          AppConstants.appStyles.quickactions)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Entry Time ',
                                      style:
                                          AppConstants.appStyles.quickactions),
                                  Spacer(),
                                  Text(ag.onceStartTime.toString(),
                                      style:
                                          AppConstants.appStyles.quickactions)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Valid For ',
                                      style:
                                          AppConstants.appStyles.quickactions),
                                  Spacer(),
                                  Text(ag.onceValidFor.toString(),
                                      style:
                                          AppConstants.appStyles.quickactions)
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Passcode ',
                                      style:
                                          AppConstants.appStyles.quickactions),
                                  Spacer(),
                                  Text(ag.passcode.toString(),
                                      style: AppConstants.appStyles.nameHead)
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      controller.clearVisitorFields();
                                      Get.toNamed(Routes.QUICK_ACTIVITY);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: AppConstants.appStyles.medium,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // <-- Radius
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.clearVisitorFields();

                                      FlutterShare.share(
                                          title: "Passcode",
                                          text:
                                              "Dear ${ag.name},\nPlease show this Passcode ${ag.passcode} to security guards at entrance.\nMyKommunity");
                                      Get.toNamed(Routes.QUICK_ACTIVITY);
                                    },
                                    child: Text(
                                      'Share passcode',
                                      style: AppConstants.appStyles.buttonText,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: AppConstants.appcolors.appOrange,
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // <-- Radius
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ])),
                  )
                ],
              ))),
      elevation: 20.0,
      enableDrag: false,
      backgroundColor: Colors.transparent,
    );
  }

  void displayCabCompanyBottomSheet() {
    showModalBottomSheet(
        //isScrollControlled: true,
        isDismissible: true,
        context: Get.context!,
        builder: (context) {
          return GetBuilder<DashboardController>(builder: (controller) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Delivery Details",
                    style: AppConstants.appStyles.smallpageTitle,
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showDialog(controller);
                      },
                    )
                  ],
                  backgroundColor: AppConstants.appcolors.primaryColor,
                  //title: Text('Select Cab Company name',
                  //   style: AppConstants.appStyles.sideheadwhite)
                ),
                body: Scaffold(
                    body: SizedBox(
                        height: MediaQuery.of(context).size.height * .95,
                        child: ListView.builder(
                            itemCount: controller.cabcompanies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                trailing: IconButton(
                                  icon: Icon(
                                    controller.selectedCabCompnayIndex == index
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    size: 30.0,
                                    color: AppConstants.appcolors.appOrange,
                                  ),
                                  onPressed: () {
                                    controller.updateCabcompnayIndex(index);
                                  },
                                ),
                                title: Text(
                                  controller.cabcompanies[index],
                                  style: AppConstants.appStyles.tilesidehead,
                                ),
                                onTap: () {
                                  controller.updateCabcompnayIndex(index);
                                  //controller.selectedCompany =
                                  //   controller.cabcompanies[index];
                                  //updated();
                                  //Navigator.pop(context);
                                  // Navigator.pop(context);
                                  // showCabOptions();
                                },
                              );
                            }))));
          });
        });
  }

  final newCompanyController = TextEditingController();

  _showDialog(controller) async {
    await showDialog<String>(
      builder: (context) => Padding(
        padding: EdgeInsets.all(5.0),
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                    controller: newCompanyController,
                    cursorColor: AppConstants.appcolors.primaryColor,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      hintStyle: AppConstants.appStyles.smallTextgrey,
                      hintText: 'eg. Amazon, Lyft, YesMadam',
                      labelStyle: AppConstants.appStyles.smallText,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppConstants.appcolors.primaryColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppConstants.appcolors.primaryColor,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppConstants.appcolors.primaryColor,
                        ),
                      ),
                    )),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child:
                    Text('Cancel', style: AppConstants.appStyles.smallSidehead),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child: Text('Add', style: AppConstants.appStyles.smallSidehead),
                onPressed: () {
                  controller.updateCabcompnay(newCompanyController.text);
                })
          ],
        ),
      ),
      context: Get.context!,
    );
  }

  void displayDeliveryCompanyBottomSheet() {
    showModalBottomSheet(
        //isScrollControlled: true,
        isDismissible: true,
        context: Get.context!,
        builder: (context) {
          return GetBuilder<DashboardController>(builder: (controller) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Delivery Vendor Name",
                    style: AppConstants.appStyles.smallpageTitle,
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showDialog(controller);
                      },
                    )
                  ],
                  backgroundColor: AppConstants.appcolors.primaryColor,
                  //title: Text('Select Cab Company name',
                  //   style: AppConstants.appStyles.sideheadwhite)
                ),
                body: Scaffold(
                    body: SizedBox(
                        height: MediaQuery.of(context).size.height * .95,
                        child: ListView.builder(
                            itemCount: controller.deliverycompanies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                      controller.selectedDeliveryCompnayIndex ==
                                              index
                                          ? Icons.check_circle_outline_sharp
                                          : Icons.add_circle_outline,
                                      size: 45.0,
                                      color: AppConstants.appcolors.appOrange),
                                  onPressed: () {
                                    controller
                                        .updateDeliverycompnayIndex(index);
                                  },
                                ),
                                title: Text(
                                  controller.deliverycompanies[index],
                                  style: AppConstants.appStyles.tilesidehead,
                                ),
                                onTap: () {
                                  controller.updateDeliverycompnayIndex(index);
                                  //controller.selectedCompany =
                                  //   controller.cabcompanies[index];
                                  //updated();
                                  //Navigator.pop(context);
                                  // Navigator.pop(context);
                                  // showCabOptions();
                                },
                              );
                            }))));
          });
        });
  }

  void displayVisitingHelpCategoriesBottomSheet() {
    showModalBottomSheet(
        //isScrollControlled: true,
        isDismissible: true,
        context: Get.context!,
        builder: (context) {
          return GetBuilder<DashboardController>(builder: (controller) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Visiting Help Category",
                    style: AppConstants.appStyles.smallpageTitle,
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showDialog(controller);
                      },
                    )
                  ],
                  backgroundColor: AppConstants.appcolors.primaryColor,
                  //title: Text('Select Cab Company name',
                  //   style: AppConstants.appStyles.sideheadwhite)
                ),
                body: Scaffold(
                    body: SizedBox(
                        height: MediaQuery.of(context).size.height * .95,
                        child: ListView.builder(
                            itemCount: controller.visitingHelpCategories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                      controller.selectedVisitingHelpIndex ==
                                              index
                                          ? Icons.check_circle_outline_sharp
                                          : Icons.add_circle_outline,
                                      size: 35.0,
                                      color: AppConstants.appcolors.appOrange),
                                  onPressed: () {
                                    controller.updateVisitingHelpIndex(index);
                                  },
                                ),
                                title: Text(
                                  controller.visitingHelpCategories[index].name!,
                                  style: AppConstants.appStyles.tilesidehead,
                                ),
                                onTap: () {
                                  controller.updateVisitingHelpIndex(index);
                                },
                              );
                            }))));
          });
        });
  }
}
