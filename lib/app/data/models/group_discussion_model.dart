// To parse this JSON data, do
//
//     final groupDiscussionModel = groupDiscussionModelFromJson(jsonString);

import 'dart:convert';

GroupDiscussionModel groupDiscussionModelFromJson(String str) =>
    GroupDiscussionModel.fromJson(json.decode(str));

String groupDiscussionModelToJson(GroupDiscussionModel data) =>
    json.encode(data.toJson());

class GroupDiscussionModel {
  GroupDiscussionModel({
    this.id,
    this.startedBy,
    this.flat,
    this.groups,
    this.date,
    this.mobile,
    this.discussion,
    this.photo,
    this.file,
  });

  int? id;
  String? startedBy;
  String? flat;
  String? groups;
  DateTime? date;
  String? mobile;
  String? discussion;
  String? photo;
  dynamic? file;

  factory GroupDiscussionModel.fromJson(Map<String, dynamic> json) =>
      GroupDiscussionModel(
        id: json["id"],
        startedBy: json["started_by"],
        flat: json["flat"],
        groups: json["groups"],
        date: DateTime.parse(json["date"]),
        mobile: json["mobile"],
        discussion: json["discussion"],
        photo: json["photo"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "started_by": startedBy,
        "flat": flat,
        "groups": groups,
        "date": date,
        // "${date!.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "mobile": mobile,
        "discussion": discussion,
        "photo": photo,
        "file": file,
      };
}
