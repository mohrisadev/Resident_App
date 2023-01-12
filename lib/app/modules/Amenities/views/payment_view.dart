import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:slidable_button/slidable_button.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/amenities_controller.dart';

class PaymentView extends GetView<AmenitiesController> {
  final currentvalue = "N".obs;
  @override
  Widget build(BuildContext context) {
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
                                      icon: Icon(Icons.arrow_back,
                                        color: Colors.white, size: 24,),
                                      label: Text("Payment",
                                        style: AppConstants.appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: SingleChildScrollView(
                child: LoadingOverlay(
                    color: Colors.white,
                    progressIndicator: CircularProgressIndicator(
                      color: AppConstants.appcolors.primaryColor,),
                    isLoading: controller.isLoading ? true : false,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10),),
                            border: Border.all(width: 0.1,color: Colors.black38),
                            color: Colors.white,),
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:<Widget> [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:AssetImage("assets/images/app_logo.png"),
                                      radius: 30,
                                    ),
                                    SizedBox(width: 15,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:<Widget> [
                                        Text("Club House"),
                                        Text("Booked"),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:<Widget> [
                                        Text("Date : "),
                                        Text("15/09/2022"),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Time : "),
                                        Text("10:30 PM"),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Amount: "),
                                    Text("₹ 4000"),
                                  ],
                                ),

                              ],
                            ),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Debit from"),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                   child: Row(
                                     children: [
                                       Container(
                                         height:40,
                                         width: 40,
                                         child: Image.asset("assets/images/buttonimages/wallet.png"),
                                       ),
                                       Column(
                                         children: [
                                           Text("Paytm wallet"),
                                           Text("Total balance ₹ 4000"),
                                         ],
                                       )
                                     ],
                                   ),
                                 ),
                                 Radio(
                                   value: "N",
                                   groupValue: currentvalue.value,
                                   activeColor: Colors.orange[600],
                                   onChanged: (value) {
                                     currentvalue.value = value.toString();
                                   },
                                 ),
                               ],
                             ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          height:40,
                                          width: 40,
                                          child: Image.asset("assets/images/buttonimages/phonepay.png"),
                                        ),
                                        Column(
                                          children: [
                                            Text("Phonepay"),
                                            Text("Phonepay"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Radio(
                                    value: "U",
                                    groupValue: currentvalue.value,
                                    activeColor:Colors.orange[600],
                                    onChanged: (value) {
                                      currentvalue.value = value.toString();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ) ,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(08),),
                            border: Border.all(width: 0.1,color: Colors.black38),
                            color: Colors.white,),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HorizontalSlidableButton(
                                width: MediaQuery.of(context).size.width / 1,
                                buttonWidth: 80.0,
                                //color: Theme.of(context).accentColor.withOpacity(0.5),
                                color: Colors.black12,
                                //buttonColor: Theme.of(context).primaryColor,
                                buttonColor: Colors.orange[600],
                                dismissible: false,
                                label: Center(child: Text('Slide me')),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('UPI'),
                                      Text('Credit card'),
                                      Text('Debit card'),
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
                                    child: Row(
                                      children: [
                                        Container(
                                          height:40,
                                          width: 40,
                                          child: Image.asset("assets/images/buttonimages/Hdfc.png"),
                                        ),
                                        Column(
                                          children: [
                                            Text("HDFC Bank Credit Card"),
                                            Text("---- ---- 8976"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Radio(
                                    value: "D/C",
                                    groupValue: currentvalue.value,
                                    activeColor:Colors.orange[600],
                                    onChanged: (value) {
                                      currentvalue.value = value.toString();
                                    },
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          height:40,
                                          width: 40,
                                          child: Image.asset("assets/images/buttonimages/Icici.png"),
                                        ),
                                        Column(
                                          children: [
                                            Text("ICICI Bank Credit Card"),
                                            Text("---- ---- 9988"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Radio(
                                    value: "D",
                                    groupValue: currentvalue.value,
                                    activeColor: Colors.orange[600],
                                    onChanged: (value) {
                                      currentvalue.value = value.toString();
                                    },
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          height:40,
                                          width: 40,
                                          child: Image.asset("assets/images/buttonimages/bobbank.png"),
                                        ),
                                        Column(
                                          children: [
                                            Text("BOB Bank Credit Card"),
                                            Text("---- ---- 9988"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Radio(
                                    value: "D",
                                    groupValue: currentvalue.value,
                                    activeColor: Colors.orange[600],
                                    onChanged: (value) {
                                      currentvalue.value = value.toString();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ) ,
                        ),
                      ],
                    ),
                ),
              ),
            bottomNavigationBar: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children:<Widget> [
                      Text("₹ 4000"),
                      Text("Amount to be paid"),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 30,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(08),color:
                      Colors.orange[600],),
                      child: Row(
                        children: <Widget>[
                          Text("Pay Now"),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context, MaterialPageRoute(builder: (context) =>  PaymentSuccessView()),
                      // );
                      sucessButton();
                    },
                  ),
                ],
              )
            ),
          );
        }));
  }

  void sucessButton(){
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
                          image: AssetImage(AppConstants.appimages.topBackground),
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
                                Text('Payment Successfully',
                                    style: AppConstants.appStyles
                                        .bottomSheetTitle),
                              ],
                            ))),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      CircleAvatar(
                        backgroundImage:AssetImage("assets/images/app_logo.png"),
                        radius: 30,
                      ),
                      SizedBox(height: 10,),
                      Text("Club House",
                          style: TextStyle(color:AppConstants.appcolors.primaryColor,
                              fontSize: 22)),
                      Container(
                          height:60,
                          width: 60,
                          child: Image.asset("assets/images/buttonimages/bharatlogo.png")
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("₹ 4000",style:
                          TextStyle(color:AppConstants.appcolors.primaryColor, fontSize: 30),),
                          SizedBox(width: 10,),
                          Container(
                            height:50,
                            child: Image.asset("assets/images/buttonimages/success.png"),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Amenity Booked Successfully!",style:
                      TextStyle(color:AppConstants.appcolors.primaryColor, fontSize: 20),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(08),
                                color: Colors.black12),
                            child: Center(
                              child: Text("Cancel"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            height: 40,
                            decoration: BoxDecoration(borderRadius:
                            BorderRadius.circular(08),color:
                            Colors.orange[600],),
                            child: Row(
                              children: <Widget>[
                                Text("View Receipt",style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
          );
        }
    );
  }
}
