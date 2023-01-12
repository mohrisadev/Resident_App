import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/modules/home/controllers/home_controller.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import '../../../../shared/appconstants.dart';

class CommunitiesView extends GetView<HomeController> {
  const CommunitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    controller.getCommunities();
    return GetBuilder<HomeController>(builder: (controller) {
      return LoadingOverlay(
          opacity: 0.9,
          color: Colors.white,
          progressIndicator: CircularProgressIndicator(),
          isLoading: controller.appState == AppState.Busy ? true : false,
          child: Scaffold(
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
                          Get.toNamed(Routes.CITIES);
                        },
                      )
                    : null,
                title: !controller.isSearching
                    ? Text(
                        AppConstants.appStrings.communities,
                        style: AppConstants.appStyles.dashboardTitle,
                      )
                    : TextField(
                        focusNode: controller.inputNode,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          controller.communitySearchfilter(value);
                        },
                        controller: controller.editingCommunityController,
                        style: AppConstants.appStyles.hintTopbar,
                        decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.white),
                            hintText: 'Enter a Community name to search',
                            hintStyle: AppConstants.appStyles.hintTopbar)),

                actions: <Widget>[
                  IconButton(
                    icon: !controller.isSearching
                        ? Icon(Icons.search, color: Colors.white)
                        : Icon(Icons.cancel, color: Colors.white),
                    onPressed: () {
                      controller.updateCommunity();
                    },
                  ),
                ],
              ),
              body: Column(children: [
                Expanded(
                  child: getCommunitiesListWidget(),
                ),
              ])));
    });
  }

  Widget getCommunitiesListWidget() {
    if (controller.filteredCommunitiyItems.isNotEmpty) {
      return Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(2),
          child: ListView(children: [
            for (var item in controller.filteredCommunitiyItems)
              Card(
                child: InkWell(
                    splashColor: Colors.orange[600],
                    onTap: () async {
                      controller.setCommunity(item);
                    },
                    child: ListTile(
                        dense: true,
                        title: Text('${item['community_name']}',
                            style: AppConstants.appStyles.commentText))),
                //   ListTile(title: Text('${item['name']}'))
              ),
            //),
          ]));
    } else {
      return Center(
          child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Center(
              child: Text(
            AppConstants.appStrings.nodata,
            style: AppConstants.appStyles.sidehead,
          ))
        ],
      ));
    }
  }
}
