// To parse this JSON data, do
//
//     final residentDirectoryModel = residentDirectoryModelFromJson(jsonString);

import 'dart:convert';

ResidentDirectoryModel residentDirectoryModelFromJson(String str) =>
    ResidentDirectoryModel.fromJson(json.decode(str));

String residentDirectoryModelToJson(ResidentDirectoryModel data) =>
    json.encode(data.toJson());

class ResidentDirectoryModel {
  ResidentDirectoryModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.role,
    this.flatNumber,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? role;
  String? flatNumber;

  factory ResidentDirectoryModel.fromJson(Map<String, dynamic> json) =>
      ResidentDirectoryModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        role: json["role"],
        flatNumber: json["flat_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "role": role,
        "flat_number": flatNumber,
      };
}
