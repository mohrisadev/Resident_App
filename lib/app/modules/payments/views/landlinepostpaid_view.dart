import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/payments_controller.dart';

class LandlinePostpaidView extends GetView<PaymentsController>{
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
                                    label: Text("LandLine",
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
                        hintText: "Search Your Landline Operator Name.. ",
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext ctxt, int index){
                            return InkWell(
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child:
                                // splashColor: Color(0xffECC7FE),
                                Padding(padding: EdgeInsets.all(02.0),
                                  child:
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                            horizontalTitleGap: 02.0,
                                            leading: CircleAvatar(
                                              backgroundImage:AssetImage("assets/images/cab.png"),
                                              radius: 30,
                                            ),
                                            title: Text(
                                              'BSNL Landline',
                                              style: AppConstants.appStyles.sidehead,
                                            ),
                                            subtitle: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Bill Payments",
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
                                                  child: Icon(Icons.keyboard_arrow_right,size: 15,
                                                    color: AppConstants.appcolors.appWhite,),
                                                ),
                                              ],
                                            )),
                                      ]
                                  ),
                                ),

                              ),
                              onTap: (){
                               // print("Anita");
                                //Get.toNamed(Routes.FASTTAPAGEGVIEW);

                              },
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