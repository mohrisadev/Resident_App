import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../shared/appconstants.dart';
import '../../../data/models/Note_To_GuardModel.dart';
import '../controllers/dashboard_controller.dart';

class NotestoguardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    controller.getNotesToguard();
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0), // here the desired height
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
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  label: Text(
                                    "  Notes",
                                    style:
                                        AppConstants.appStyles.mediumPagetitle,
                                  )),
                            )),
                      ]))),
          body: LoadingOverlay(
              opacity: 0.9,
              color: Colors.white,
              progressIndicator: CircularProgressIndicator(),
              isLoading: controller.appState == AppState.Busy ? true : false,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: getChatBoxWidget(),
                      ),
                      Expanded(
                          flex: 1,
                          child: ListView.builder(
                              itemCount: controller.notestoGuardList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var am = controller.notestoGuardList
                                    .elementAt(index);

                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 10.0,
                                        child: getCard(am)));
                                //getCard(controller.notestoGuardList[index])));
                              })),
                    ],
                  ))));
    });
  }

  Widget getChatBoxWidget() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.txtmsgController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2.0),
                    ),
                    hintText: "Type your message here..",
                    alignLabelWithHint: true,
                  ),
                  keyboardType: TextInputType.multiline,
                  style: AppConstants.appStyles.commentText,
                  maxLines: 4,
                ),
                Divider(),
                chartButtons()
              ],
            )));
  }

  Widget chartButtons() {
    return Row(
      children: [
        // TextButton.icon(
        //     onPressed: () {},
        //     icon: Icon(Icons.emoji_emotions_outlined,
        //         color: AppConstants.appcolors.appgrey, size: 30.0),
        //     label: Text('')),
        TextButton.icon(
            onPressed: () {
              controller.pickImagefromGallery();
            },
            icon: Icon(Icons.attach_file,
                color: AppConstants.appcolors.appgrey, size: 30.0),
            label: Text('')),
        TextButton.icon(
            onPressed: () {
              controller.showCamera();
            },
            icon: Icon(Icons.camera_alt_outlined,
                color: AppConstants.appcolors.appgrey, size: 30.0),
            label: Text('')),
        Spacer(),
        TextButton.icon(
            onPressed: () {
              controller.sendNotesToGuard();
            },
            icon: Icon(Icons.send,
                color: AppConstants.appcolors.appOrange, size: 30.0),
            label: Text('')),
      ],
    );
  }

  getName(am) {
    return AppConstants.activeFlat!.flatNumber == am.flatNumber
        ? "You"
        : am.userName;
  }

  Widget getCard(am) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              getName(am),
              style: AppConstants.appStyles.sidehead,
            ),
            subtitle: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.location_city,
                        color: AppConstants.appcolors.appOrange, size: 20.0),
                    label: Text(
                      am.flatNumber!,
                      style: AppConstants.appStyles.smallTextgrey,
                    ))),
            trailing: Text(
              Jiffy(am.date!).yMMMMd,
              style: AppConstants.appStyles.sidehead,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                am.text,
                style: AppConstants.appStyles.textweight500,
                textAlign: TextAlign.start,
              )),
          Divider(),
          getImage(am)
        ],
      ),
    );
  }

  Widget getImage(am) {
    ////print(photos.length);

    if (am.photo != null) {
      return SizedBox(
          height: 80,
          child: Padding(
              padding: EdgeInsets.all(5.0),
              child: InkWell(
                  onTap: () {
                    controller.heroTapped(0, am.photo, "");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      width: 60.0,
                      height: 55.0,
                      imageUrl: am.photo,
                      placeholder: (context, url) =>
                          Icon(Icons.hourglass_bottom),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ))));
      // )

    } else {
      return Container(width: 0, height: 0);
    }
  }
}
