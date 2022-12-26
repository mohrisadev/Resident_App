import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:slidable_button/slidable_button.dart';
import '../../../../shared/appconstants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/payments_controller.dart';

class RechargePlanView extends GetView<PaymentsController>{
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
                Card(
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    splashColor: Color(0xffECC7FE),
                    child: Padding(
                        padding: EdgeInsets.all(02.0),
                        child:
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                  horizontalTitleGap: 02.0,
                                  leading: CircleAvatar(
                                    backgroundImage:AssetImage("assets/images/app_logo.png"),
                                    radius: 30,
                                  ),
                                  title: Text(
                                    'My Number',
                                    style: AppConstants.appStyles.sidehead,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "+91-9878785312",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff7E7E7E),
                                        ),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Text(
                                        "Jio Prepaid",
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
                      //Get.toNamed(Routes.RECHARGEPLAN);
                    },
                  ),
                ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color: Colors.orange[600]),
                        border: OutlineInputBorder(),
                        hintText: 'Search For a Plan eg 665 or 84 days ',
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                        border: Border.all(width: 0.1,color: Colors.black38),
                        color: Colors.white,),
                        width: double.infinity,
                        child: InkWell(
                          child: Column(
                            children: [
                              HorizontalSlidableButton(
                                width: MediaQuery.of(context).size.width / 1,
                                buttonWidth: 80.0,
                                //color: Theme.of(context).accentColor.withOpacity(0.5),
                                color: Colors.black12,
                                //buttonColor: Theme.of(context).primaryColor,
                                buttonColor: Colors.orange[600],
                                dismissible: false,
                                label: Center(child: Text('Slid Me')),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Truly Packs'),
                                      Text('Data Packs'),
                                      Text('Rececomded'),
                                    ],
                                  ),
                                ),
                                onChanged: (position) {
                                  // setState(() {
                                  //   if (position == SlidableButtonPosition.end) {
                                  //     result = 'Button is on the right';
                                  //   } else {
                                  //     result = 'Button is on the left';
                                  //   }
                                  // });
                                },
                              ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("₹200",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange[600],
                          ),),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("Data"),
                                        Text("2GB/Day"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                   child: Column(
                                     children: [
                                       Text("Validity"),
                                       Text("28Days"),
                                     ],
                                   ),
                                  ),
                                ],),
                              SizedBox(height: 6,),
                              Text("Voice: Unlimited Calls | SMS: 100/days"),
                              SizedBox(height: 6,),
                              Text("Aditional Benefits"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(radius: 20,
                                          backgroundImage:AssetImage("assets/images/cab.png"),),
                                        SizedBox(width: 5,),
                                        CircleAvatar(radius: 20,
                                          backgroundImage:AssetImage("assets/images/cab.png"),),
                                        SizedBox(width: 5,),
                                        CircleAvatar(radius: 20,
                                        backgroundImage:AssetImage("assets/images/cab.png"),),
                                      ],
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
                              ),
                           Divider(thickness: 1,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("₹560",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange[600],
                          ),),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("Data"),
                                        Text("2GB/Day"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                   child: Column(
                                     children: [
                                       Text("Validity"),
                                       Text("28Days"),
                                     ],
                                   ),
                                  ),
                                ],),
                              SizedBox(height: 6,),
                              Text("Voice: Unlimited Calls | SMS: 100/days"),
                              SizedBox(height: 6,),
                              Text("Aditional Benefits"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(radius: 20,
                                          backgroundImage:AssetImage("assets/images/cab.png"),),
                                        SizedBox(width: 5,),
                                        CircleAvatar(radius: 20,
                                          backgroundImage:AssetImage("assets/images/cab.png"),),
                                        SizedBox(width: 5,),
                                        CircleAvatar(radius: 20,
                                        backgroundImage:AssetImage("assets/images/cab.png"),),
                                      ],
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
                              ), Divider(thickness: 1,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("₹560",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange[600],
                          ),),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("Data"),
                                        Text("2GB/Day"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                   child: Column(
                                     children: [
                                       Text("Validity"),
                                       Text("28Days"),
                                     ],
                                   ),
                                  ),
                                ],),
                              SizedBox(height: 6,),
                              Text("Voice: Unlimited Calls | SMS: 100/days"),
                              SizedBox(height: 6,),
                              Text("Aditional Benefits"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(radius: 20,
                                          backgroundImage:AssetImage("assets/images/cab.png"),),
                                        SizedBox(width: 5,),
                                        CircleAvatar(radius: 20,
                                          backgroundImage:AssetImage("assets/images/cab.png"),),
                                        SizedBox(width: 5,),
                                        CircleAvatar(radius: 20,
                                        backgroundImage:AssetImage("assets/images/cab.png"),),
                                      ],
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
                              ),
                            ],
                          ),
                          onTap: (){
                            Get.toNamed(Routes.SELECTRECHARGEVIEW);
                          },
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


