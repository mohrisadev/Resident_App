// To parse this JSON data, do
//
//     final sosCategoriesModel = sosCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<SosCategoriesModel> sosCategoriesModelFromJson(String str) =>
    List<SosCategoriesModel>.from(json.decode(str).map((x) => SosCategoriesModel.fromJson(x)));

String sosCategoriesModelToJson(List<SosCategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SosCategoriesModel {
  SosCategoriesModel({
    this.id,
    this.dbcode,
    this.category,
    this.imageUrl,
  });

  int? id;
  String? dbcode;
  String? category;
  String? imageUrl;

  factory SosCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SosCategoriesModel(
        id: json["id"],
        dbcode: json["dbcode"],
        category: json["category"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dbcode": dbcode,
        "category": category,
        "image_url": imageUrl,
      };
}
