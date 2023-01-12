import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mykommunity/app/modules/home/controllers/home_controller.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import '../../../../shared/appconstants.dart';
import '../../../data/models/flat_model.dart';

class AddflatView extends GetView<HomeController> {
  const AddflatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.setInitialFlatsValue();
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.appcolors.primaryColor,
            //automaticallyImplyLeading: false,

            leading: !controller.isSearching
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.BLOCKLIST);
                    },
                  )
                : null,
            title: !controller.isSearching
                ? Text(
                    AppConstants.appStrings.selectFlat,
                    style: AppConstants.appStyles.dashboardTitle,
                  )
                : TextField(
                    focusNode: controller.inputNode,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      controller.filterSearchflats(value);
                    },
                    controller: controller.flateditingController,
                    style: AppConstants.appStyles.hintTopbar,
                    decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.white),
                        hintText: 'Enter a Flat number to search',
                        hintStyle: AppConstants.appStyles.hintTopbar)),

            actions: <Widget>[
              IconButton(
                icon: !controller.isSearching
                    ? Icon(Icons.search, color: Colors.white)
                    : Icon(Icons.cancel, color: Colors.white),
                onPressed: () {
                  controller.flatsSearching();
                },
              ),
            ],
          ),
          body: Column(children: [
            Expanded(child: getFilterFlats()),
            Expanded(flex: 0,
              child: loadButton(),)
          ]));
    });
  }

  Widget loadButton() {
    if (controller.next_page != "" || controller.next_page != null) {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: () {
              controller.loadMore();
            }, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // icon
                Text("Load more..",
                    style: AppConstants.appStyles.sidehead), // text
              ],
            ),
          ));
    } else {
      return Container(
        width: 0,
      );
    }
  }
  Widget getFilterFlats() {
    if (controller.filteredFlatItems.isNotEmpty) {
      return ListView.builder(
          controller: controller.scrcontroller,
          itemCount: controller.filteredFlatItems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            Flat _flat = Flat.fromJson(controller.filteredFlatItems[index]);
            return Card(
              child: InkWell(

                  splashColor: Colors.orange[600],
                  onTap: () async {
                    controller.updateFlatinfo(_flat);
                  },
                  child: ListTile(
                      dense: true,
                      title: Text(_flat.name!,
                    style: AppConstants.appStyles.sidehead))),
            );
          });
    } else {
      return Center(
          child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Center(child: Text(
            AppConstants.appStrings.nodata,
            style: AppConstants.appStyles.sidehead,
          ))
        ],
      ));
    }
  }
}
