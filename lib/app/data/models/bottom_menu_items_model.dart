import 'dart:convert';

import 'package:flutter/cupertino.dart';

MenuItemsModel menuItemsModelFromJson(String str) =>
    MenuItemsModel.fromJson(json.decode(str));

String menuItemsModelToJson(MenuItemsModel data) => json.encode(data.toJson());

class MenuItemsModel {
  MenuItemsModel({required this.icon, this.label, this.action,});

  IconData icon;
  String? label;
  Widget? action;

  factory MenuItemsModel.fromJson(Map<String, dynamic> json) => MenuItemsModel(
        icon: json["ICON"],
        label: json["LABEL"],
        action: json["ACTION"],
      );

  Map<String, dynamic> toJson() => {
        "ICON": icon,
        "LABEL": label,
        "ACTION": action,
      };
}
