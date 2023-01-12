import 'dart:convert';

VehicleLogModal vehicleLogModalFromJson(String str) =>
    VehicleLogModal.fromJson(json.decode(str));

String vehicleLogModalToJson(VehicleLogModal data) =>
    json.encode(data.toJson());

class VehicleLogModal {
  VehicleLogModal({
    this.entryType,
    this.createdAt,
  });

  String? entryType;
  DateTime? createdAt;

  factory VehicleLogModal.fromJson(Map<String, dynamic> json) =>
      VehicleLogModal(
        entryType: json["entry_type"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "entry_type": entryType,
        "created_at": createdAt?.toIso8601String(),
      };
}
