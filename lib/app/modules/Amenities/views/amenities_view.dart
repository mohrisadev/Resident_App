import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/amenity_model.dart';
import 'package:mykommunity/app/modules/Amenities/views/clubhouse_view.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/complaint_category.dart';
import '../controllers/amenities_controller.dart';

class AmenitiesView extends GetView<AmenitiesController> {
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
                      image: AssetImage(
                      AppConstants.appimages.topBackground),
                      fit: BoxFit.cover,),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.00))),
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
                                  label: Text("Select Amenities",
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
                    children: <Widget>[
                      SizedBox(height: 10,),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search,color: Colors.orange[600]),
                          border: OutlineInputBorder(),
                          hintText: 'Search amenity name here.. ',
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: controller.amenitiesList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                AmenityModel cc = controller.amenitiesList.elementAt(index);
                                return Card(
                                  child: InkWell(
                                      splashColor: Colors.orange[600],
                                      onTap: () {

                            // Navigator.push(context, MaterialPageRoute(builder:
                             //(context) =>  ClubHouseView()),);
                                 controller.showDetasils(cc);
                                      },
                                      child: ListTile(dense: true,
                                        title: Text(cc.amenityName.toString().toUpperCase(),
                                        style: AppConstants.appStyles.sidehead),
                                        subtitle: getpaidstatus(cc),
                                        trailing: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color:Colors.orange[600],),
                                            child: Icon(Icons.arrow_forward_ios_outlined,size: 15,
                                            color: AppConstants.appcolors.appWhite,),
                                        ),
                                      )),
                                  //   ListTile(title: Text('${item['name']}'))
                                );
                              }))
                    ],
                  )
              )
          );
        }));
  }
  Widget getpaidstatus(AmenityModel cc) {
    return cc.status == true
        ? Text('Paid', style: AppConstants.appStyles.smallText)
        : Text('', style: AppConstants.appStyles.sidehead);
  }
}


