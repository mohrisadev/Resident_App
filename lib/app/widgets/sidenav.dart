import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Center(
                  child: Text(
                    "Vakup",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.read_more),
            title: Text('Leer datos'),
            onTap: () {
              if (Get.currentRoute == Routes.DASHBOARD) {
                Get.back();
              } else {
                Get.toNamed(Routes.DASHBOARD);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text('Registrar animal'),
            onTap: () {
              // if (Get.currentRoute == Routes.NEWANIMAL) {
              //   Get.back();
              // } else {
              //   Get.toNamed(Routes.NEWANIMAL);
              // }
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Lista movimientos'),
            onTap: () {
              // if (Get.currentRoute == Routes.MOVEMENTS) {
              //   Get.back();
              // } else {
              //   //Get.to
              //   Get.toNamed(Routes.MOVEMENTS);
              // }
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Lista animales'),
            onTap: () {
              // if (Get.currentRoute == Routes.LISTOFANIMALS) {
              //   Get.back();
              // } else {
              //   Get.toNamed(Routes.LISTOFANIMALS);
              // }
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Grabar datos'),
            onTap: () {
              // if (Get.currentRoute == Routes.GRABADO) {
              //   Get.back();
              // } else {
              //   Get.toNamed(Routes.GRABADO);
              // }
            },
          ),
          ListTile(
            leading: Icon(Icons.bluetooth),
            title: Text('Conexion BT'),
            onTap: () {
              // if (Get.currentRoute == Routes.CONEXIONBT) {
              //   Get.back();
              // } else {
              //   Get.toNamed(Routes.CONEXIONBT);
              // }
            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Exportar Datos'),
            onTap: () {
              // if (Get.currentRoute == Routes.EXPORT) {
              //   Get.back();
              // } else {
              //   Get.toNamed(Routes.EXPORT);
              // }
            },
          ),
          ListTile(
            leading: Icon(Icons.recent_actors_rounded),
            title: Text('Acerca de'),
            onTap: () {
              // if (Get.currentRoute == Routes.ACERCA) {
              //   Get.back();
              // } else {
              //   Get.toNamed(Routes.ACERCA);
              // }
            },
          ),
        ],
      ),
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
//           Expanded(
//             child: Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: Padding(
//                 padding: EdgeInsets.all(60.0),
//                 child: ListTile(
//                   enabled: false,
//                   title: FutureBuilder(
//                     future: getVersionNumber(),
//                     builder: (BuildContext context,
//                             AsyncSnapshot<String> snapshot) =>
//                         Text(
//                       "Version    ${snapshot.hasData ? snapshot.data : 'Loading ...'}",
//                       style: AppConstants.appStyles.smallSidehead,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
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

//   Future<String> getVersionNumber() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String version = packageInfo.version;

//     return version;
//   }

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
