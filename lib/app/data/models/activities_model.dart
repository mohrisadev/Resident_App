// To parse this JSON data, do
//
//     final ActivitiesModel = ActivitiesModelFromJson(jsonString);

import 'dart:convert';

List<ActivitiesModel> ActivitiesModelFromJson(String str) =>
    List<ActivitiesModel>.from(
        json.decode(str).map((x) => ActivitiesModel.fromJson(x)));

String ActivitiesModelToJson(List<ActivitiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivitiesModel {
  ActivitiesModel({
    this.id,
    this.category,
    this.data,
    this.createdAt,
  });

  int? id;
  String? category;
  Data? data;
  DateTime? createdAt;

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) =>
      ActivitiesModel(
        id: json["id"],
        category: json["category"],
        data: Data.fromJson(json["data"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "data": data?.toJson(),
        "created_at": createdAt!.toIso8601String(),
      };
}

class Data {
  Data(
      {this.name,
      this.phone,
      this.photo,
      this.company,
      this.activity,
      this.temperature,
      this.vehicleNumber,
      this.isWearingMask,
      this.visitorType,
      this.onceValidFor,
      this.onceStartTime,
      this.validFromDate,
      this.visitingHelpCategory,
      this.approvalstatus,
      this.status});

  String? name;
  String? phone;
  int? photo;
  String? company;
  String? activity;
  dynamic? temperature;
  dynamic? vehicleNumber;
  bool? isWearingMask;
  int? visitorType;
  int? onceValidFor;
  String? onceStartTime;
  DateTime? validFromDate;
  String? visitingHelpCategory;
  String? approvalstatus;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? '' : json["name"],
        phone: json["phone"] == null ? '' : json["phone"],
        photo: json["photo"] == null ? 0 : json["photo"],
        company: json["company"] == null ? '' : json["company"],
        activity: json["activity"] == null ? '' : json["activity"],
        temperature: json["temperature"] == null ? '' : json["temperature"],
        vehicleNumber:
            json["vehicle_number"] == null ? '' : json["vehicle_number"],
        isWearingMask:
            json["is_wearing_mask"] == null ? null : json["is_wearing_mask"],
        visitorType: json["visitor_type"] == null ? 0 : json["visitor_type"],
        onceValidFor:
            json["once_valid_for"] == null ? 0 : json["once_valid_for"],
        onceStartTime:
            json["once_start_time"] == null ? null : json["once_start_time"],
        validFromDate: json["valid_from_date"] == null
            ? null
            : DateTime.parse(json["valid_from_date"]),
        visitingHelpCategory: json["visiting_help_category"] == null
            ? null
            : json["visiting_help_category"],
        approvalstatus:
            json["approval_status"] == null ? null : json["approval_status"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "photo": photo == null ? 0 : photo,
        "company": company,
        "activity": activity,
        "temperature": temperature == null ? null : temperature,
        "vehicle_number": vehicleNumber == null ? '' : vehicleNumber,
        "is_wearing_mask": isWearingMask == null ? null : isWearingMask,
        "visitor_type": visitorType == null ? null : visitorType,
        "once_valid_for": onceValidFor == null ? null : onceValidFor,
        "once_start_time": onceStartTime == null ? null : onceStartTime,
        "valid_from_date": validFromDate == null
            ? null
            : "${validFromDate!.year.toString().padLeft(4, '0')}-${validFromDate!.month.toString().padLeft(2, '0')}-${validFromDate?.day.toString().padLeft(2, '0')}",
        "visiting_help_category":
            visitingHelpCategory == null ? null : visitingHelpCategory,
        "approval_status": approvalstatus == null ? null : approvalstatus,
        "status": status == null ? null : status,
      };
}




// // To parse this JSON data, do
// //
// //     final ActivitiesModel = ActivitiesModelFromJson(jsonString);

// import 'dart:convert';

// ActivitiesModel ActivitiesModelFromJson(String str) => ActivitiesModel.fromJson(json.decode(str));

// String ActivitiesModelToJson(ActivitiesModel data) => json.encode(data.toJson());

// class ActivitiesModel {
//     ActivitiesModel({
//         this.id,
//         this.category,
//         this.data,
//         this.createdAt,
//     });

//     int id;
//     String category;
//     Data data;
//     DateTime createdAt;

//     factory ActivitiesModel.fromJson(Map<String, dynamic> json) => ActivitiesModel(
      
//         id: json["id"],
//         category: json["category"]??'',
//         data: Data.fromJson(json["data"]),
//         createdAt: DateTime.parse(json["creatd_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "category": category,
//         "data": data.toJson(),
//         "created_at": createdAt.toIso8601String(),
//     };
// }

// class Data {
//     Data({
//         this.company,
//         this.activity,
//         this.visitorType,
//         this.onceValidFor,
//         this.vehicleNumber,
//         this.onceStartTime,
//         this.validFromDate,
//         this.visitingHelpCategory,
//     });

//     String company;
//     String activity;
//     int visitorType;
//     int onceValidFor;
//     String vehicleNumber;
//     String onceStartTime;
//     DateTime validFromDate;
//     String visitingHelpCategory;


//     factory Data.fromJson(Map<String, dynamic> json) => Data(
      
//         company:  json["company"],
//         activity: json["activity"],
//         visitorType:json["visitor_type"] ?? 0,
//         onceValidFor: json["once_valid_for"],
//         vehicleNumber: json["vehicle_number"]??'',
//         onceStartTime: json["once_start_time"],
//         validFromDate: json["valid_from_date"],
//         visitingHelpCategory: json["visiting_help_category"],
//     );

//     Map<String, dynamic> toJson() => {
//         "company": company,
//         "activity": activity,
//         "visitor_type": visitorType,
//         "once_valid_for": onceValidFor,
//         "vehicle_number": vehicleNumber,
//         "once_start_time": onceStartTime,
//         "valid_from_date": "${validFromDate.year.toString().padLeft(4, '0')}-${validFromDate.month.toString().padLeft(2, '0')}-${validFromDate.day.toString().padLeft(2, '0')}",
//         "visiting_help_category": visitingHelpCategory,
//     };
// }
