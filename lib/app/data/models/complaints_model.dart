// {
//     ""category"": 1,
//     ""sub_category"": ""Complaint"",
//     ""complain_type"": ""Personal"",
//     ""description"": ""Complaint details goes here."",
//     ""photos"": [1, 2]
// }"

import 'package:flutter/foundation.dart';

class Complaints {
  int? categoryId;
  String? sub_category;
  String? complain_type;
  String? description;
  List<int>? photos;

  Complaints(
      {this.categoryId,
      this.sub_category,
      this.complain_type,
      this.description,
      this.photos});

  factory Complaints.fromJson(Map<String, dynamic> json) => Complaints(
      categoryId: json["category"],
      sub_category: json["sub_category"],
      complain_type: json["complain_type"],
      description: json["description"],
      photos: json["photos"]);

  Map<String, dynamic> toJson() => {
        "category": categoryId,
        "sub_category": sub_category,
        "complain_type": complain_type,
        "description": description,
        "photos": photos
      };
}
