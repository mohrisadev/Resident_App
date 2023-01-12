import 'dart:convert';

LocalServiceModal localServiceModalFromJson(String str) =>
    LocalServiceModal.fromJson(json.decode(str));

String localServiceModalToJson(LocalServiceModal data) =>
    json.encode(data.toJson());

class LocalServiceModal {
  LocalServiceModal({
    this.name,
    this.contactNumber,
    this.id,
    this.category,
    this.categoryId,
    this.photo,
  });

  String? name;
  String? contactNumber;
  int? id;
  String? category;
  int? categoryId;
  String? photo;

  factory LocalServiceModal.fromJson(Map<String, dynamic> json) =>
      LocalServiceModal(
        name: json["name"],
        contactNumber: json["contactNumber"],
        id: json["id"],
        category: json["category"],
        categoryId: json["category_id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contactNumber": contactNumber,
        "id": id,
        "category": category,
        "category_id": categoryId,
        "photo": photo,
      };
}
