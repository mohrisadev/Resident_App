import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:slidable_button/slidable_button.dart';
import '../../../../shared/appconstants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/payments_controller.dart';
class HistoryDetailsView extends GetView<PaymentsController>{
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
                                    label: Text("Transaction History",
                                      style: AppConstants.appStyles.mediumPagetitle,
                                    ),),
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
                            Text('Transations'),
                            Text('Categories'),
                            Text('Status'),
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Text("Transation History"),),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 19,
                          itemBuilder: (BuildContext ctxt, int index){
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: InkWell(
                                splashColor: Color(0xffECC7FE),
                                child: Padding(
                                    padding: EdgeInsets.all(02.0),
                                    child:
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                              horizontalTitleGap: 10.0,
                                              leading: Container(
                                                   height: 45,
                                                   width: 45,
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.green,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_upward_sharp,
                                                    size: 20.0, color: Colors.white,
                                                  ),
                                              ),
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Electricity Bill',
                                                    style: AppConstants.appStyles.sidehead,
                                                  ),
                                                  Text('₹ 900.00',
                                                    style: AppConstants.appStyles.sidehead,
                                                  ),

                                                ],
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "10 Jul 2022",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xff7E7E7E),
                                                    ),
                                                  ),
                                                  Text(
                                                    "12:20 PM",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xff7E7E7E),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.0,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                           Icon(Icons.safety_check),
                                                          Text(
                                                            "Successful",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.green,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Credit From",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          Icon(Icons.food_bank_sharp)
                                                        ],
                                                      ),

                                                    ],
                                                  )


                                                ],
                                              )),

                                        ])),
                                onTap: () {
                                  Get.toNamed(Routes.BILLRECEIPT);
                                },
                              ),
                            );
                          }
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