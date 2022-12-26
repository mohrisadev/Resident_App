import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/payments_controller.dart';

class CreditcardAddView extends GetView<PaymentsController>{
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
                                    label: Text("Axis Band Credit Card",
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      child: Text("Link Account", style: AppConstants.appStyles.nameHead,),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      decoration: BoxDecoration(color: Colors.white),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter account no./Mobile no./MAC ID',
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      child: Text("Nickname(Optional)", style: AppConstants.appStyles.nameHead,),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      decoration: BoxDecoration(color: Colors.white),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your Nickname',
                          suffix: InkWell(
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:Colors.orange[600],),
                              child: Icon(Icons.keyboard_arrow_down_sharp,size: 15,
                                color: AppConstants.appcolors.appWhite,),
                            ),
                            onTap: (){

                            },
                          ),
                        ),
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      child: Text("Eg.Name", style: AppConstants.appStyles.nameHead,),
                    ),


                    Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(10),),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.2),
                              spreadRadius: 4, blurRadius: 10, offset: Offset(0, 3),)
                          ]
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>  AmenitiesView()
                            // ),
                            // );
                          },
                          child: Text(
                            'Link Account',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Netflix",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
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