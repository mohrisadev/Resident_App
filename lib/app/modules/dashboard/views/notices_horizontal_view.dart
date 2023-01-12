// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mykommunity/shared/appconstants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/notices_model.dart';
import '../controllers/dashboard_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticesHorizontalView extends GetView<DashboardController> {
  const NoticesHorizontalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return controller.isrecentNoticesLoading == true
          ? SizedBox(
              width: 25.0,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppConstants.appcolors.primaryColor,
                ),
              ),
            )
          : Scaffold(
              body: Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.noticeboardItems.length > 2
                          ? 2
                          : controller.noticeboardItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if (controller.noticeboardItems.isNotEmpty) {
                        Noticesmodel ni = controller.noticeboardItems[index];
                        return Card(
                          margin: EdgeInsets.all(5.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          child: InkWell(
                            splashColor: Color(0xffECC7FE),
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Container(
                                            height: 30,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: AppConstants
                                                    .appcolors.primaryColor),
                                            child: TextButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.assignment,
                                                  size: 15.0,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  "Notice",
                                                  style: AppConstants
                                                      .appStyles.smallTextwhite,
                                                ))),

                                        //Date Time
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          child: Text(
                                            Jiffy(ni.publishedAt).yMMMMdjm,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff7E7E7E),
                                            ),
                                          ),
                                        ),
                                      ]),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: Html(
                                          data: '${ni.message}',
                                        ),
                                      ),

                                      getmediaButtons(ni)

                                      // Text('${ni.media}' ,style: AppConstants.appStyles.smallText,),
                                    ])),
                            onTap: () {
                              // AwesomeDialog(
                              //   context: context,
                              //   //dialogBackgroundColor: Colors.red,

                              //   animType: AnimType.SCALE,
                              //   dialogType: DialogType.NO_HEADER,
                              //   //title: '${ni.subject}',

                              //   body: Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.start,
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(
                              //             bottom: 5),
                              //         child: Center(
                              //             child: Text(
                              //           '${ni.subject}',
                              //           style: GoogleFonts.montserrat(
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 14,
                              //             color: Colors.black,
                              //           ),
                              //         )),
                              //       ),
                              //       Center(
                              //           child: Text(
                              //               '${Jiffy(ni.publishedAt).yMMMMEEEEdjm}',
                              //               style: TextStyle(
                              //                 fontSize: 12,
                              //                 fontWeight:
                              //                     FontWeight.w500,
                              //                 color: Color(0xff7E7E7E),
                              //               ))),
                              //       Divider(
                              //         thickness: 2,
                              //         color: Colors.purple[200],
                              //       ),
                              //       Padding(
                              //           padding:
                              //               const EdgeInsets.symmetric(
                              //                   horizontal: 8),
                              //           child: Html(
                              //             data: '${ni.message}',
                              //           )

                              //           // Text(
                              //           //   '${ni.message}',
                              //           //   style: GoogleFonts.montserrat(
                              //           //     fontWeight: FontWeight.w500,
                              //           //     fontSize: 12,
                              //           //     color: Colors.black,
                              //           //   ),
                              //           // ),
                              //           ),
                              //     ],
                              //   ),

                              //   btnOkOnPress: () {},
                              //   btnOkColor: Colors.purple[300],
                              // )..show();
                            },
                          ),
                        );
                      }
                      // else {
                      //   return Center(
                      //       child: ListView(
                      //     padding: const EdgeInsets.all(15.0),
                      //     children: [
                      //       Center(
                      //           child: Text(
                      //         AppConstants.appStrings.nonoticeboarditems,
                      //         style: AppConstants.appStyles.sidehead,
                      //       ))
                      //     ],
                      //   ));
                      // }
                      // }
                      )));
    });
  }

  Widget getmediaButtons(Noticesmodel ni) {
    if (ni.media!.isNotEmpty) {
      return Row(
          children: ni.media!
              .map(
                (item) => Padding(
                    child: RaisedButton.icon(
                        onPressed: () {
                          launchURL(item['media']);
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
              .toList());
    } else {
      return Container(
        width: 0,
        height: 0,
      );

      //  Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 4),
      //   child: Column(
      //     children: [
      //       Divider(thickness: 0.8),
      //       Text(
      //         "No Attachment",
      //         style: GoogleFonts.montserrat(
      //           fontWeight: FontWeight.w600,
      //           fontSize: 14,
      //           color: Colors.black45,
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    }
  }

  launchURL(String noticeurl) async {
    if (await canLaunch(noticeurl)) {
      await launch(noticeurl);
    } else {
      throw 'Could not open $noticeurl';
    }
  }
}
