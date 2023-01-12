import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../shared/appconstants.dart';
import '../controllers/payments_controller.dart';
class PipedgasView extends GetView<PaymentsController> {
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: (() => controller.showDashboard()),
      child: GetBuilder<PaymentsController>(builder: (controller){
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
                                    label: Text("Piped gas",
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
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color: Colors.orange[600]),
                        border: OutlineInputBorder(),
                        hintText: "Search Your Piped Gas provider.. ",
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Select Your Piped GAS Provider"),),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext ctxt, int index){
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: InkWell(
                                splashColor: Color(0xffECC7FE),
                                child: Padding(padding: EdgeInsets.all(02.0),
                                  child:
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          horizontalTitleGap: 02.0,
                                          leading: CircleAvatar(
                                            backgroundImage:AssetImage("assets/images/app_logo.png"),
                                            radius: 30,
                                          ),
                                          title: Text(
                                            'Adani Gas',
                                            style: AppConstants.appStyles.sidehead,
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "BillPayments",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff7E7E7E),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color:Colors.orange[600],),
                                                child: Icon(Icons.keyboard_arrow_right_outlined,size: 15,
                                                  color: AppConstants.appcolors.appWhite,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
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
      }
      ),
    );
  }
}