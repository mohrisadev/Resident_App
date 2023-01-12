import 'dart:convert';

List<Residentsmodel> residencesmodelFromJson(String str) =>
    List<Residentsmodel>.from(
        json.decode(str).map((x) => Residentsmodel.fromJson(x)));

String ResidentsmodelToJson(List<Residentsmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Residentsmodel {
  Residentsmodel(
      {this.blockName,
      this.flatNumber,
      this.flatId,
      this.communityID,
      this.role,
      this.occupancyStatus,
      this.isApproved,
      this.connectOptIn,
      this.first_name,
      this.last_name});

  String? blockName;
  String? flatNumber;
  int? flatId;
  int? communityID;
  String? role;
  String? occupancyStatus;
  bool? isApproved;
  bool? connectOptIn;
  String? first_name;
  String? last_name;

  factory Residentsmodel.fromJson(Map<String, dynamic> json) => Residentsmodel(
        blockName: json["block_name"],
        flatNumber: json["flat_number"],
        flatId: json["flat_id"],
        communityID: json["community_id"],
        role: json["role"],
        occupancyStatus: json["occupancy_status"],
        isApproved: json["is_approved"],
        connectOptIn: json["connect_opt_in"],
        first_name: json["first_name"],
        last_name: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "block_name": blockName,
        "flat_number": flatNumber,
        "flat_id": flatId,
        "community_id": communityID,
        "role": role,
        "occupancy_status": occupancyStatus,
        "is_approved": isApproved,
        "connect_opt_in": connectOptIn,
        "first_name": first_name,
        "last_name": last_name,
      };
}
