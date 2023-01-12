import 'dart:convert';

EmergencyContactsModal emergencyContactsModalFromJson(String str) =>
    EmergencyContactsModal.fromJson(json.decode(str));

String emergencyContactsModalToJson(EmergencyContactsModal data) =>
    json.encode(data.toJson());

class EmergencyContactsModal {
  EmergencyContactsModal({
    this.title,
    this.contact,
  });

  String? title;
  String? contact;

  factory EmergencyContactsModal.fromJson(Map<String, dynamic> json) =>
      EmergencyContactsModal(
        title: json["title"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "contact": contact,
      };
}
