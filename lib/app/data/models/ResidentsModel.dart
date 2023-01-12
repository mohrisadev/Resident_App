import 'dart:convert';

List<ResidentModel> residentModelFromJson(String str) =>
    List<ResidentModel>.from(
        json.decode(str).map((x) => ResidentModel.fromJson(x)));

String residentModelToJson(List<ResidentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResidentModel {
  ResidentModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.flatNumber,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? flatNumber;

  factory ResidentModel.fromJson(Map<String, dynamic> json) => ResidentModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        flatNumber: json["flat_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "flat_number": flatNumber,
      };
}
