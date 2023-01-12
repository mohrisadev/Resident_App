import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mykommunity/app/data/models/city_image_model.dart';
import 'package:mykommunity/app/modules/home/controllers/home_controller.dart';
import 'package:mykommunity/shared/appconstants.dart';

class CitiesView extends GetView<HomeController> {
  const CitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getCities();
    return GetBuilder<HomeController>(builder: (controller) {
      return LoadingOverlay(
          opacity: 0.9,
          color: Colors.white,
          progressIndicator: CircularProgressIndicator(),
          isLoading: controller.appState == AppState.Busy ? true : false,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppConstants.appcolors.primaryColor,
                leading: !controller.isSearching
                    ? IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white,),
                        onPressed: () {
                          Get.back();
                        },
                      )
                    : null,
                title: !controller.isSearching
                    ? Text(
                        AppConstants.appStrings.cities,
                        style: AppConstants.appStyles.dashboardTitle,
                      )
                    : TextField(
                        focusNode: controller.inputNode,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          // //print(value);
                          controller.filterSearchResults(value);
                        },
                        controller: controller.editingController,
                        style: AppConstants.appStyles.hintTopbar,
                        decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.white),
                            hintText: 'Enter a City name to search',
                            hintStyle: AppConstants.appStyles.hintTopbar)),
                actions: <Widget>[
                  IconButton(
                    icon: !controller.isSearching
                        ? Icon(Icons.search, color: Colors.white)
                        : Icon(Icons.cancel, color: Colors.white),
                    onPressed: () {
                      controller.itemSearching();
                    },
                  ),
                ],
              ),
              body: Column(children: [
                Expanded(child: filteredItems()),
              ]))
          //)
          );
    });
  }

  Widget getSelectedCities() {
    //print(controller.cityImageslist.length);
    return controller.showCities
        ? SizedBox(
            height: 300.0,
            child: GridView.builder(
                //  shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: controller.cityImageslist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  dynamic city = controller.cityImageslist.elementAt(index);
                  // print(city.image!);
                  return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: InkWell(
                        splashColor: AppConstants.appcolors.appOrange,
                        onTap: () {
                          controller.updateCity(city);
                          // controller.showCommunityWidget(am);
                        },
                        child: Image.asset(city.image!, fit: BoxFit.fill),
                        // Text(
                        //   "\n${city.cityname!}\n",
                        //   style: AppConstants
                        //       .appStyles.quickActiveListItem,
                        // )
                      ));
                }))
        : Container(
            width: 0,
            height: 0,
          );
  }

  Widget filteredItems() {
    if (controller.filteredItems.isNotEmpty) {
      return Container(
          color: Colors.white,
          width: double.maxFinite,
          padding: EdgeInsets.all(2),
          child: ListView(children: [
            Align(
                child: showCurentLocationButton(),
                alignment: Alignment.topLeft),

            getSelectedCities(),

            for (var item in controller.filteredItems)
              //FadeAnimation(.25,
              Card(
                child: InkWell(
                    splashColor: Colors.orange[600],
                    onTap: () async {
                      controller.updateCity(item);
                    },
                    child: ListTile(
                        dense: true,
                        title: Text('${item['name']}',
                            style: AppConstants.appStyles.tilesidehead))),
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

  Widget showCurentLocationButton() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.my_location,
                color: AppConstants.appcolors.appOrange, size: 28.0),
            label: Text(
              "Use your Current location",
              style: AppConstants.appStyles.iconButtonText,
            )));
  }
}
