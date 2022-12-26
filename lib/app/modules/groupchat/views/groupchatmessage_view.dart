import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../controllers/groupchat_controller.dart';

class GroupchatMessageView extends GetView<GroupchatController> {
  const GroupchatMessageView({Key? key}) : super(key: key);

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
                                        "  Group Discussion",
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
                    SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color: Colors.orange[600]),
                        border: OutlineInputBorder(),
                        hintText: "Search Here.. ",
                      ),
                    ),

                           Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),),
                                border: Border.all(
                                    width: 0.1, color: Colors.black38),
                                color: Colors.white,),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:AssetImage("assets/images/cab.png"),
                                        radius: 30,
                                      ),
                                      Column(
                                        children: [
                                          Text("Life is not work"),
                                          Text("Life is not work"),
                                        ],
                                      ),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                          color: Colors.red,
                                        ),
                                        child: Center(child: Text("Discusstion")),
                                      )
                                    ],
                                  ),
                                  PreferredSize(
                                    preferredSize: Size.infinite,
                                    child: Text("B Block Life is not working Properly.1St And 2nd floower "), ),
                                  SizedBox(height: 20,),
                                  Divider(),
                                  Column(
                                    children: [
                                      Row(
                                       children: [
                                         Text("Stated By:"),
                                         Text("Staveen Sing"),
                                       ],
                                      ) ,
                                      Row(
                                       children: [
                                         Text("Rroups:"),
                                         Text("Tentent Owner"),
                                       ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Date:"),
                                          Text("10 Jul,2022"),
                                        ],
                                      ) ,
                                      Row(
                                        children: [
                                          Text("Mobile:"),
                                          Text("91-74848936608"),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Discuttion:"),
                                          PreferredSize(
                                            preferredSize: Size.infinite,
                                            child: Text("B Block Life is not working"), ),

                                        ],
                                      ) ,
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.message),
                                          Text("3")
                                        ],
                                      ),
                                      Text("12 Share")
                                    ],
                                  ),

                                ],
                              )
                          ),
                  ],
                ),
              )
          );
        }));
  }
}
