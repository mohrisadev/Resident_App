import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mykommunity/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mykommunity/shared/appconstants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class SidebarView extends GetView<DashboardController> {
  const SidebarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
              height: 125.0,
              child: DrawerHeader(
                margin: EdgeInsets.all(0.0),
                child: Row(children: [
                  Container(
                      decoration: BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      height: 240,
                      child: Stack(
                        children: <Widget>[
                          getProfileImage(),
                          Positioned(
                            bottom: 0, right: 0, //give the values according to your requirement
                            child: Icon(Icons.verified_user,
                            color: Colors.blue,),
                          ),
                        ],
                      )),
                  // Center(
                  //     child: CircleAvatar(
                  //   radius: 32,
                  //   backgroundImage: AssetImage('assets/images/app_logo.png'),
                  // )),
                  SizedBox(width: 10.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          controller.getgreetingString(),
                          textAlign: TextAlign.center,
                          style: AppConstants.appStyles.sidehead,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${controller.userProfile!.firstName} ${controller.userProfile!.lastName}',
                          textAlign: TextAlign.center,
                          style: AppConstants.appStyles.sideheadblue,
                        ),
                      ),

                      // Center(
                      //   child: Text(
                      //     'ABC',
                      //     textAlign: TextAlign.center,
                      //     style: AppConstants.appStyles.sideheadblue,
                      //   ),
                      // ),

                    ],
                  )
                ]),
          decoration: BoxDecoration(color: Colors.white,),)),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(Icons.home_outlined,
            color: AppConstants.appcolors.textBlue,),
            title: Text('HOME', style: AppConstants.appStyles.sideheadblue,),
            onTap: () {
              if (Get.currentRoute == Routes.DASHBOARD) {
                Get.back();
              } else {
                Get.toNamed(Routes.DASHBOARD);
              }
            },
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(
              Icons.account_circle_outlined,
              color: AppConstants.appcolors.textBlue,
            ),
            title: Text('MY ACCOUNT', style: AppConstants.appStyles.sideheadblue,),
            onTap: () {
              if (Get.currentRoute == Routes.MYACCOUNT) {
                Get.back();
              } else {
                Get.toNamed(Routes.MYACCOUNT);
              }
            },
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(
              Icons.lock_outline,
              color: AppConstants.appcolors.textBlue,
            ),
            title: Text(
              'PRIVACY POLICY',
              style: AppConstants.appStyles.sideheadblue,
            ),
            onTap: () {
              controller.launchURL();
            },
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(
              Icons.logout,
              color: AppConstants.appcolors.textBlue,
            ),
            title: Text(
              'LOGOUT',
              style: AppConstants.appStyles.sideheadblue,
            ),
            onTap: () async {
              var preference = await SharedPreferences.getInstance();
             preference.setString("token", "");
              preference.setInt("flatId", 0);
             FirebaseAuth.instance.signOut();
             Get.offAndToNamed(Routes.WELCOME_SCREENS);
            },

            // onTap: () async {
            //   if (
            //   Get.currentRoute == Routes.DASHBOARD) {
            //     final pref = await SharedPreferences.getInstance();
            //     await pref.clear();
            //     pref.setString("intro", "123");
            //     Get.toNamed(Routes.DASHBOARD);
            //
            //     Get.back();
            //   } else {
            //   Get.toNamed(Routes.DASHBOARD);
            //   }
            // },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(60.0),
                child: ListTile(
                  enabled: false,
                  title: FutureBuilder(
                      future: getVersionNumber(),
                      builder: (BuildContext context,AsyncSnapshot<String> snapshot) =>
                          Column(
                            children:<Widget>[
                              Divider(),
                              Text("Version ${snapshot.hasData ? snapshot.data : 'Loading ...'}",
                              style: AppConstants.appStyles.smallSidehead,),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getProfileImage() {
    // return CachedNetworkImage(
    //   imageUrl: controller.userProfile!.photos.toString(),
    //   placeholder: (context, url) => new CircularProgressIndicator(),
    //   errorWidget: (context, url, error) => new Icon(Icons.error),
    // );

        return controller.userProfile!.photos != null
        ? CircleAvatar(
          radius: 45,
        child: ClipOval(
        child: CachedNetworkImage(
               imageUrl: controller.userProfile!.photos!,
               fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),
          )
       : CircleAvatar(backgroundImage: AssetImage(AppConstants.appimages.app_logo),
         radius: 45.0,
    );
  }
}



// class Sidenav extends StatelessWidget {
//   final Function setIndex;
//   final int selectedIndex;

//   Sidenav(this.selectedIndex, this.setIndex);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: Container(
//       child: ListView(
//         children: <Widget>[
//           DrawerHeader(
//               padding: EdgeInsets.zero,
//               child: UserAccountsDrawerHeader(
//                 decoration: BoxDecoration(color: Colors.white),
//                 currentAccountPicture: CircleAvatar(
//                   backgroundImage: AssetImage(AppConstants.appimages.app_logo),
//                 ),
//                 margin: EdgeInsets.zero,
//                 accountName: Text(
//                   'My Kommunity',
//                   style: AppConstants.appStyles.drawerHead,
//                 ),
//                 accountEmail: null,
//               )),
//           Divider(color: Colors.orange.shade400),
//           _navItem(context, Icons.question_answer, 'Privacy Policy', onTap: () {
//             _navItemClicked(context, 1);

//             _launchURL();
//           }, selected: selectedIndex == 1),
//           _navItem(context, Icons.exit_to_app, 'Log out', onTap: () {
//             _navItemClicked(context, 2);
//             _logout(context);
//           }, selected: selectedIndex == 2),
// Expanded(
//   child: Align(
//     alignment: FractionalOffset.bottomCenter,
//     child: Padding(
//       padding: EdgeInsets.all(60.0),
//       child: ListTile(
//         enabled: false,
//         title: FutureBuilder(
//           future: getVersionNumber(),
//           builder: (BuildContext context,
//                   AsyncSnapshot<String> snapshot) =>
//               Text(
//             "Version    ${snapshot.hasData ? snapshot.data : 'Loading ...'}",
//             style: AppConstants.appStyles.smallSidehead,
//           ),
//         ),
//       ),
//     ),
//   ),
//  ),
//         ],
//       ),
//     ));
//   }

//   _logout(context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Are you sure?'),
//         content: Text('Do you want to Log out from App'),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('No'),
//           ),
//           FlatButton(
//             onPressed: () {
//               logoutAndClearSessions(context);
//             },
//             child: Text('Yes'),
//           ),
//         ],
//       ),
//     );
//   }

//   logoutAndClearSessions(context) async {
//     var preference = await SharedPreferences.getInstance();
//     preference.setString("token", "");
//     preference.setInt("flatId", 0);
//     FirebaseAuth.instance.signOut();

//     Get.offAndToNamed(Routes.PHONE_AUTH);
//   }

//   _launchURL() async {
//     const _url = 'https://mohrisa.com/privacy-policy';
//     await launch(_url);
//   }

Future<String> getVersionNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  return version;
}

//   _navItem(BuildContext context, IconData icon, String text,
//           {Text? suffix, onTap, bool selected = false}) =>
//       Container(
//         color: selected ? Colors.grey.shade300 : Colors.transparent,
//         child: ListTile(
//           leading: Icon(icon,
//               color: selected
//                   ? AppConstants.appcolors.primaryColor
//                   : AppConstants.appcolors.primaryColor),
//           trailing: suffix,
//           title: Text(
//             text,
//             style: AppConstants.appStyles.sidehead,
//           ),
//           selected: selected,
//           onTap: onTap,
//         ),
//       );

//   _navItemClicked(BuildContext context, int index) {
//     setIndex(index);
//     Get.back();
//   }
// }
