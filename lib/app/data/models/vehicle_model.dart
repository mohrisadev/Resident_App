import 'dart:convert';

Vehiclemodel vehiclemodelFromJson(String str) =>
    Vehiclemodel.fromJson(json.decode(str));

String vehiclemodelToJson(Vehiclemodel data) => json.encode(data.toJson());

class Vehiclemodel {
  Vehiclemodel({
    this.id,
    this.photo,
    this.name,
    this.vehicleNumber,
    this.vehicleType,
    this.notificationEnabled,
  });

  int? id;
  String? photo;
  String? name;
  String? vehicleNumber;
  String? vehicleType;
  bool? notificationEnabled;

  factory Vehiclemodel.fromJson(Map<String, dynamic> json) => Vehiclemodel(
        id: json["id"],
        photo: json["photo"],
        name: json["name"],
        vehicleNumber: json["vehicle_number"],
        vehicleType: json["vehicle_type"],
        notificationEnabled: json["notification_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "name": name,
        "vehicle_number": vehicleNumber,
        "vehicle_type": vehicleType,
        "notification_enabled": notificationEnabled,
      };
}
