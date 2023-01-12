// To parse this JSON data, do
//
//     final sosAlertsModel = sosAlertsModelFromJson(jsonString);

import 'dart:convert';

List<SosAlertsModel> sosAlertsModelFromJson(String str) =>
    List<SosAlertsModel>.from(
        json.decode(str).map((x) => SosAlertsModel.fromJson(x)));

String sosAlertsModelToJson(List<SosAlertsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SosAlertsModel {
  SosAlertsModel({
    this.id,
    this.name,
    this.flats,
    this.phone,
    this.emergencyType,
    this.community,
    this.resolvedType,
    this.startTime,
    this.acknowledgedTime,
  });

  int? id;
  String? name;
  int? flats;
  String? phone;
  String? emergencyType;
  dynamic? community;
  int? resolvedType;
  DateTime? startTime;
  dynamic? acknowledgedTime;

  factory SosAlertsModel.fromJson(Map<String, dynamic> json) => SosAlertsModel(
        id: json["id"],
        name: json["name"],
        flats: json["flats"],
        phone: json["phone"],
        emergencyType: json["emergency_type"],
        community: json["community"],
        resolvedType: json["resolved_type"],
        startTime: DateTime.parse(json["start_time"]),
        acknowledgedTime: json["acknowledged_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "flats": flats,
        "phone": phone,
        "emergency_type": emergencyType,
        "community": community,
        "resolved_type": resolvedType,
        "start_time": startTime!.toIso8601String(),
        "acknowledged_time": acknowledgedTime,
      };
}
