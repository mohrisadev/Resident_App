import 'dart:convert';

LocalServiceCategory localServiceCategoryFromJson(String str) =>
    LocalServiceCategory.fromJson(json.decode(str));

String localServiceCategoryToJson(LocalServiceCategory data) =>
    json.encode(data.toJson());

class LocalServiceCategory {
  LocalServiceCategory({this.id, this.name,});

  int? id;
  String? name;

  factory LocalServiceCategory.fromJson(Map<String, dynamic> json) =>
      LocalServiceCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
