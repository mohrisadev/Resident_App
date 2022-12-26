import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../shared/appconstants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/groupchat_controller.dart';

class GroupchatpageView extends GetView<GroupchatController> {
  const GroupchatpageView({Key? key}) : super(key: key);

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
                      Expanded(
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return  Container(
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
                                              Text("Staveen.3 hours a go"),
                                            ],
                                          ),
                                          InkWell(
                                            child: Container(
                                              width: 90,
                                              height: 30,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                color: Colors.red,
                                              ),
                                              child: Center(child: Text("Discusstion")),
                                            ),
                                             onTap: ()  {
                                            Get.toNamed(Routes.GROUPCHATMESSAGEVIEW);
                                              },
                                          )
                                        ],
                                      ),
                                      PreferredSize(
                                        preferredSize: Size.infinite,
                child: Text("B Block Life is not working Properly.1St And 2nd floower "), ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.mail),
                                              Text("4")
                                            ],
                                          ),
                                          Text("12 Share")
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.mail),
                                              Text("Comment")
                                            ],
                                          ),Row(
                                            children: [
                                              Icon(Icons.share),
                                              Text("Share")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.remove_red_eye),
                                              Text("Hide"),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              );
                             },
                             ),
                      ),
                    ],
                  ),

              ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Get.toNamed(Routes.ADDGROUPCHAT);
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.orange[600],

            ),
          );
        }));
  }
}
