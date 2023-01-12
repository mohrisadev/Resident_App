import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../shared/appconstants.dart';

class DbheroviewView extends GetView<DashboardController> {
  const DbheroviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80), // here the desired height
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppConstants.appimages.topBackground),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25.00))),
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
                                  "  Detailed Image View",
                                  style: AppConstants.appStyles.mediumPagetitle,
                                )),
                          )),
                    ]))),
        body: Container(
            color: Colors.white,
            child: controller.hero_imageLocation == "local"
                ? localImage()
                : networkImage()));
  }

  Widget localImage() {
    return Hero(
        tag: controller.activeHeroTag!,
        child: Image.file(File(controller.heroImageUrl!)));
  }

  Widget networkImage() {
    return Hero(
        tag: controller.activeHeroTag!,
        child: PhotoView(
            backgroundDecoration: BoxDecoration(color: Colors.white),
            imageProvider: CachedNetworkImageProvider(
              controller.heroImageUrl!,
            )));
  }
}
