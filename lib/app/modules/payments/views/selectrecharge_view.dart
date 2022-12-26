import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/payments_controller.dart';

class SelectRechargeView extends GetView<PaymentsController>{
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
                                  label: Text("Select a Recharge Plan",
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
                Container(
                   margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                   padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10),),
                    border: Border.all(width: 0.1,color: Colors.black38),
                    color: Colors.white,),
                  width: double.infinity,
                  child: Column(
                    children: <Widget> [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            CircleAvatar(
                              backgroundImage:AssetImage("assets/images/cab.png"),
                                radius: 30,),
                                Column(
                                  children: [
                                    Text("Jio Prepaid Mobile Recharge "),
                                    Text("Mobile Recharge "),
                                  ],
                                )
                              ],
                            ),
                       Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("TalkTime:"),
                              Text("00"),
                              Text("Data:"),
                              Text("1GB/Days") ,
                              Text("Validity:"),
                              Text("84Day")
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Voice:"),
                              Text("Unlimited Call"),
                              Text("SMS:"),
                              Text("100Sms") ,
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            Text("Plan:"),
                            Text("200"),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Additional Benefit:"),
                          CircleAvatar(
                          backgroundImage:AssetImage("assets/images/cab.png"),
                          radius: 15,),
                          CircleAvatar(
                          backgroundImage:AssetImage("assets/images/cab.png"),
                          radius: 15,),
                          CircleAvatar(
                          backgroundImage:AssetImage("assets/images/cab.png"),
                          radius: 15,),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}


