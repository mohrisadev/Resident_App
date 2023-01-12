import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/shared/appconstants.dart';

class WaitingforApprovalView extends GetView {
  const WaitingforApprovalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/mainheader.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "\n\Thank you",
                    style: AppConstants.appStyles.loginTitle,
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //FadeAnimation(1.3,
                  Text("Thank you",
                      style: AppConstants.appStyles.phoneNumberText),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Received your details, Please wait till admin approves your registration.",
                    style: AppConstants.appStyles.smallText,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Meanwhile you can relogin to the app to select your flat.",
                    style: AppConstants.appStyles.smallText,
                  ),
                  SizedBox(height: 20),
                  Center(
                      child: OutlinedButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: Text(
                            "  Exit  ",
                            style: AppConstants.appStyles.complaintTitle,
                          )))
                  //),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
