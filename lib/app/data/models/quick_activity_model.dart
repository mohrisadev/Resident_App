import 'dart:convert';

import 'package:flutter/cupertino.dart';

QuickActivityModel QuickActivityModelFromJson(String str) =>
    QuickActivityModel.fromJson(json.decode(str));

String QuickActivityModelToJson(QuickActivityModel data) =>
    json.encode(data.toJson());

class QuickActivityModel {
  QuickActivityModel({
    this.visitorCode,
    this.imageurl,
    this.label,
    this.actionType,
    this.actionUrl,
  });

  int? visitorCode;
  String? imageurl;
  String? label;
  String? actionType;
  String? actionUrl;

  factory QuickActivityModel.fromJson(Map<String, dynamic> json) =>
      QuickActivityModel(
        visitorCode: json["VISITOR_CODE"],
        imageurl: json["IMAGE_URL"],
        label: json["LABEL"],
        actionType: json["ACTIONTYPE"],
        actionUrl: json["ACTION"],
      );

  Map<String, dynamic> toJson() => {
        "VISITOR_CODE": visitorCode,
        "IMAGE_URL": imageurl,
        "LABEL": label,
        "ACTIONTYPE": actionType,
        "ACTION": actionUrl,
      };
}
