import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/modules/home/controllers/home_controller.dart';
import 'package:mykommunity/shared/appconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/sizeconfig.dart';

class NewuserView extends GetView<HomeController> {
  const NewuserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomeController>(builder: (controller) {
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
                            "\n\nNew User",
                            style: AppConstants.appStyles.loginTitle,
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Form(
                                key: controller.newUserForm,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Email',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.email,
                                            color: Colors.grey,
                                          ), // icon is 48px widget.
                                        ),
                                      ),
                                      onChanged: (value) {
                                        controller.updateEmail(value);
                                      },
                                      focusNode: controller.emailfc,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'First Name',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                          ), // icon is 48px widget.
                                        ),
                                      ),

                                      // prefixIcon: FontAwesomeIcons.user,
                                      onChanged: (value) {
                                        controller.updateFirstName(value);
                                      },

                                      focusNode: controller.firstName,
                                      keyboardType: TextInputType.name,

                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {},
                                      validator: (value) {
                                        // if (value.isEmptyOrNull) {
                                        //   return 'Enter Your First Name';
                                        // }
                                        // return null;
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Last Name',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                          ), // icon is 48px widget.
                                        ),
                                      ),
                                      onChanged: (value) {
                                        controller.updateLastName(value);
                                      },
                                      focusNode: controller.lastName,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (_) {
                                        controller.lastName!.unfocus();
                                      },
                                      validator: (value) {},
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: RaisedButton(
                                        color: AppConstants.appcolors.appOrange,
                                        onPressed: () async {
                                          controller.updateNewuser();
                                        },
                                        child: Text('Update',
                                            style: AppConstants
                                                .appStyles.buttonText),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ],
                ),
              )));
    });
  }
}
