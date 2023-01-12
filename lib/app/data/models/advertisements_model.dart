import 'dart:convert';

import 'package:flutter/cupertino.dart';

AdvertisementsModel AdvertisementsModelFromJson(String str) =>
    AdvertisementsModel.fromJson(json.decode(str));

String AdvertisementsModelToJson(AdvertisementsModel data) =>
    json.encode(data.toJson());

class AdvertisementsModel {
  AdvertisementsModel({
    this.sort_order,
    this.imageurl,
    this.label,
    this.action,
  });

  int? sort_order;
  String? imageurl;
  String? label;
  Widget? action;

  factory AdvertisementsModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementsModel(
        sort_order: json["SORT_ORDER"],
        imageurl: json["IMAGE_URL"],
        label: json["LABEL"],
        action: json["ACTION"],
      );

  Map<String, dynamic> toJson() => {
        "SORT_ORDER": sort_order,
        "IMAGE_URL": imageurl,
        "LABEL": label,
        "ACTION": action,
      };
}
