
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/amenity_model.dart';

import '../../../../shared/appconstants.dart';
import '../controllers/payments_controller.dart';

class MobilePostPaidView extends GetView<PaymentsController> {
  final currentvalue = "N".obs;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<PaymentsController>(builder: (controller) {
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
                                      label: Text("Mobile Recharge",
                                        style: AppConstants.appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,),
                  isLoading: controller.isloading ? true : false,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Container(child: Text("Mobile Recharge or Bill Payments"),),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Radio(
                                  value: "D/C",
                                  groupValue: currentvalue.value,
                                  activeColor:Colors.orange[600],
                                  onChanged: (value) {
                                    currentvalue.value = value.toString();
                                  },
                                ),
                                Text("Prepaid")
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Radio(
                                  value: "D/C",
                                  groupValue: currentvalue.value,
                                  activeColor:Colors.orange[600],
                                  onChanged: (value) {
                                    currentvalue.value = value.toString();
                                  },
                                ),
                                Text("Postpaid")
                              ],
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search,color: Colors.orange[600]),
                          border: OutlineInputBorder(),
                          hintText: 'Search amenity name here.. ',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Recent Account"),),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 19,
                            itemBuilder: (BuildContext ctxt, int index){
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                  splashColor: Color(0xffECC7FE),
                                  child: Padding(
                                      padding: EdgeInsets.all(02.0),
                                      child:
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        ListTile(
                                            horizontalTitleGap: 02.0,
                                            leading: CircleAvatar(
                                              backgroundImage:AssetImage("assets/images/delivery.png"),
                                              radius: 30,
                                            ),
                                            title: Text(
                                              'Mukesh Gupta',
                                              style: AppConstants.appStyles.sidehead,
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "+916437644464",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff7E7E7E),
                                                  ),
                                                ),
                                                SizedBox(height: 5.0,),
                                                Text(
                                                  "Last Recharge ₹299 on jun 2022",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.orange[600],
                                                  ),
                                                ),

                                              ],
                                            )),

                                      ])),
                                  onTap: () {

                                  },
                                ),
                              );
                            }
                        ),
                      ),

                    ],
                  )
              )
          );
        }));
  }
}
