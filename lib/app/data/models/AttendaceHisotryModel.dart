import 'dart:convert';

AttendanceHistoryModal attendanceHistoryModalFromJson(String str) =>
    AttendanceHistoryModal.fromJson(json.decode(str));

String attendanceHistoryModalToJson(AttendanceHistoryModal data) =>
    json.encode(data.toJson());

class AttendanceHistoryModal {
  AttendanceHistoryModal({
    this.presentOn,
  });

  DateTime? presentOn;

  factory AttendanceHistoryModal.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryModal(
        presentOn: DateTime.parse(json["present_on"]),
      );

  Map<String, dynamic> toJson() => {
        "present_on":
            "${presentOn!.year.toString().padLeft(4, '0')}-${presentOn!.month.toString().padLeft(2, '0')}-${presentOn!.day.toString().padLeft(2, '0')}",
      };
}
