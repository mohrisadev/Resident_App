//     final preApprovedGuestModel = preApprovedGuestModelFromJson(jsonString);

import 'dart:convert';

PreApprovedGuestModel preApprovedGuestModelFromJson(String str) =>
    PreApprovedGuestModel.fromJson(json.decode(str));

String preApprovedGuestModelToJson(PreApprovedGuestModel data) =>
    json.encode(data.toJson());

class PreApprovedGuestModel {
  PreApprovedGuestModel({
    this.id,
    this.phone,
    this.name,
    this.passcode,
    this.visitorType,
    this.validFromDate,
    this.frequentEndDate,
    this.onceStartTime,
    this.onceValidFor,
    this.company,
    this.frequencyType,
    this.status,
    this.community,
    this.flat,
    this.visitingHelpCategory,
  });
  int? id;
  String? phone;
  String? name;
  String? passcode;
  int? visitorType;
  String? validFromDate;
  String? validToDate;
  String? onceStartTime;
  int? onceValidFor;
  String? company;
  int? frequencyType;
  String? frequentEndDate;
  bool? status;
  int? community;
  int? flat;
  String? visitingHelpCategory;

  factory PreApprovedGuestModel.fromJson(Map<String, dynamic> json) =>
      PreApprovedGuestModel(
        phone: json["phone"],
        name: json["name"],
        passcode: json["passcode"],
        visitorType: json["visitor_type"],
        validFromDate: json["valid_from_date"],
        onceStartTime: json["once_start_time"],
        onceValidFor: json["once_valid_for"],
        company: json["company"],
        frequencyType: json["frequency_type"],
        frequentEndDate: json["frequent_end_date"],
        status: json["status"],
        community: json["community"],
        flat: json["flat"],
        visitingHelpCategory: json["visiting_help_category"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "passcode": passcode,
        "visitor_type": visitorType,
        "valid_from_date": validFromDate,
        "once_start_time": onceStartTime,
        "once_valid_for": onceValidFor,
        "company": company,
        "frequency_type": frequencyType,
        "frequent_end_date": frequentEndDate,
        "status": status,
        "community": community,
        "flat": flat,
        "visiting_help_category": visitingHelpCategory,
      };
}
