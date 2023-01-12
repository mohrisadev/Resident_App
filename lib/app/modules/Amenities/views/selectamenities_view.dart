import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/amenities_controller.dart';
import 'amenities_view.dart';

class SelectAmenitiesView extends GetView<AmenitiesController> {
  @override
  Widget build(BuildContext context) {
  controller.getAmenitiesClub();
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
                                      label: Text("Amenities",
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
                               children: <Widget>[
                                 CircleAvatar(
                                   backgroundImage:AssetImage("assets/images/app_logo.png"),
                                   radius: 30,
                                 ),
                                 SizedBox(width: 15,),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children:<Widget> [
                                    Text("${controller.bb?.amenityName.toString()}"),
                                    Text("${controller.bb?.booked.toString()}"),
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
                                      Text('${controller.bb?.date.toString()}'),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Time : "),
                                      Text('${controller.bb?.amenityName.toString()}'),
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
                                  Text("${controller.bb?.price}"),
                                ],
                              ),

                            ],
                          ),
                        ),
                       ),
                      const SizedBox(height: 30,),
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
                              Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>  AmenitiesView()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color:Colors.orange[600],),
                                  child: Icon(Icons.add,size: 15,
                                  color: AppConstants.appcolors.appWhite,),
                                ),
                                Text(
                                  'Book New Amenities',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "Netflix",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    letterSpacing: 0.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                    ],
                  )));
        }));
  }

}
