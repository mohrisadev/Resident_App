import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/groupchat_controller.dart';

class AddGroupchatView extends GetView<GroupchatController> {
  const AddGroupchatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getGroupChatMessages();

    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<GroupchatController>(builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
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
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    label: Text(
                                      "Start Discusstion",
                                      style: AppConstants
                                          .appStyles.mediumPagetitle,
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
                        child: Text("Tittle", style: AppConstants.appStyles.nameHead,),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                        decoration: BoxDecoration(color: Colors.white),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Write here tittle',
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
                                dispalyBroadbrandDetails();
                              },
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                        child: Text("Description", style: AppConstants.appStyles.nameHead,),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                        decoration: BoxDecoration(color: Colors.white),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Write Here',
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
                                dispalyStateDetails();
                              },
                            ),
                          ),
                          style: TextStyle(color: Colors.white),

                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                        child: Text("Participation", style: AppConstants.appStyles.nameHead,),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                        decoration: BoxDecoration(color: Colors.white),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select Group',
                            suffixIcon: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:Colors.orange[600],),
                              child: Icon(Icons.arrow_drop_down,size: 20,
                                color: AppConstants.appcolors.appWhite,),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Row(
                                children: [
                                Text("Take Photo"),
                                Icon(Icons.camera_alt),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Row(
                                children: [
                                Text("Upload Image"),
                                Icon(Icons.camera_alt),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   child: Text(
                      //     'Featch Bill Details',
                      //     style: TextStyle(
                      //         decoration: TextDecoration.underline,color: Colors.orange[600]
                      //     ),
                      //   ),
                      // ),
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
                              'Submit Discusstion',
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
          );
        }));
  }
  void dispalyBroadbrandDetails() {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        isScrollControlled: false,
        builder: (context) {
          return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,),
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
                                Text('Select Your BroadBrand', style: AppConstants.appStyles.bottomSheetTitle),
                              ],
                            ))),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext ctxt, int index){
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:Colors.orange[600],),
                                  child: Icon(Icons.add,size: 15,
                                    color: AppConstants.appcolors.appWhite,),
                                ),
                                SizedBox(width: 10,),
                                Text("Kolkata")
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ],
              )
          );
        });
  }
  void dispalyStateDetails() {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        isScrollControlled: false,
        builder: (context) {
          return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppConstants.appimages.topBackground),
                          fit: BoxFit.cover,),
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
                                Text('Select Your State', style: AppConstants.appStyles.bottomSheetTitle),
                              ],
                            ))),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext ctxt, int index){
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:Colors.orange[600],),
                                  child: Icon(Icons.add,size: 15,
                                    color: AppConstants.appcolors.appWhite,),
                                ),
                                SizedBox(width: 10,),
                                Text("Andrapradesh")
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ],
              )
          );
        });
  }
}
