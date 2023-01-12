import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/notices_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../shared/appconstants.dart';
import '../controllers/notice_board_controller.dart';

class NoticeBoardView extends GetView<NoticeBoardController> {
  @override
  Widget build(BuildContext context) {
    controller.getListofNotiecBoardItems();

    return WillPopScope(
        onWillPop: (() => controller.showDashboard()),
        child: GetBuilder<NoticeBoardController>(builder: (controller) {
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
                                        "  Notice Board",
                                        style: AppConstants
                                            .appStyles.mediumPagetitle,
                                      )),
                                )),
                          ]))),
              body: LoadingOverlay(
                  color: Colors.white,
                  progressIndicator: CircularProgressIndicator(
                    color: AppConstants.appcolors.primaryColor,
                  ),
                  isLoading: controller.isloading ? true : false,
                  child: getNoticesList()));
        }));
  }

  Widget getNoticesList() {
    if (controller.noticeboardItems.isNotEmpty) {
      return ListView.builder(
          //scrollDirection: Axis.horizontal,
          itemCount: controller.noticeboardItems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            Noticesmodel lsm = controller.noticeboardItems[index];
            return getCardView(lsm);
          });
    } else {
      return Center(
          child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Center(
              child: Text(
            AppConstants.appStrings.noLocalService,
            style: AppConstants.appStyles.sidehead,
          ))
        ],
      ));
    }
  }

  Widget getCardView(Noticesmodel ni) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10.0,
      child: InkWell(
        splashColor: Color(0xffECC7FE),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                  horizontalTitleGap: 10.0,
                  leading: Icon(
                    Icons.assignment_rounded,
                    color: AppConstants.appcolors.appOrange,
                  ),
                  title: Text(
                    '${ni.subject}',
                    style: AppConstants.appStyles.sidehead,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Jiffy(ni.publishedAt).yMMMMdjm,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff7E7E7E),
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Html(
                        data: '${ni.message}',
                      ),
                    ],
                  )),
              getmediaButtons(ni)
            ])),
        onTap: () {
          dispalyNotice(ni);
        },
      ),
    );
  }

  Widget getmediaButtons(Noticesmodel ni) {
    if (ni.media!.length > 0) {
      return Column(
        children: [
          Divider(thickness: 0.8),
          Row(
              children: ni.media!
                  .map((item) => Padding(
                        child: RaisedButton.icon(
                            onPressed: () {
                              launch(item['media']);
                              //launchURL('https://www.irs.gov/pub/irs-pdf/i1040gi.pdf');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            label: Text(
                              'Attachment',
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: FaIcon(
                              FontAwesomeIcons.paperclip,
                              color: Color(0xff747474),
                            ),
                            textColor: Colors.black,
                            //splashColor: Colors.red,
                            color: Color(0xffF0D3FE)),
                        padding: EdgeInsets.all(5.0)),
                  )
                  .toList()),
        ],
      );

      // ni.media.forEach((element) {

      //         //print(element['media']);
      //         });

    } else {
      return Container(
        width: 0,
        height: 0,
      );

      // return Column(
      //   children: [
      //     Divider(thickness: 0.8),
      //     Text(
      //       "No Attachment",
      //       style: GoogleFonts.montserrat(
      //         fontWeight: FontWeight.w600,
      //         fontSize: 12,
      //         color: Colors.black45,
      //       ),
      //     ),
      //   ],
      // );
    }
  }

  void dispalyNotice(Noticesmodel ni) {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Container(
              height: 380,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(AppConstants.appimages.topBackground),
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
                                Text('${ni.subject}',
                                    style: AppConstants
                                        .appStyles.bottomSheetTitle),
                                Center(
                                    child: Text(
                                        '${Jiffy(ni.publishedAt).yMMMMEEEEdjm}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        )))
                              ],
                            ))),
                  ),
                  Container(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Html(
                            data: '${ni.message}',
                          ))),
                  Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              ' OK, Got it ',
                              style: AppConstants.appStyles.buttonText,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppConstants.appcolors.appOrange,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ));
        });
  }

  Widget getFormatedPhoneNumber(p) {
    if (p == null) {
      return Text(
        "Phone : na",
        style: AppConstants.appStyles.smallText,
      );
    }

    if (p.toString().length <= 10) {
      return Text(
        p,
        style: AppConstants.appStyles.smallText,
      );
    } else {
      String formattedPhoneNumber = p.substring(0, 3) +
          " " +
          p.substring(3, 8) +
          " " +
          p.substring(8, p.length);

      return Text(
        formattedPhoneNumber,
        style: AppConstants.appStyles.smallText,
      );
    }
  }
}
