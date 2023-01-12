import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/payments_controller.dart';

class HousingScreenView extends GetView<PaymentsController>{
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
                                    label: Text("Housing Society",
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
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Select State',
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp)
                            ),
                            onSaved: (String? value) {

                            },

                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Select City',
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp)),
                            onSaved: (String? value) {

                            },

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

                                  },
                                  child: Text(
                                    'Continue',
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