import 'dart:convert';

ActiveFlatModel activeFlatModelFromJson(String str) =>
  ActiveFlatModel.fromJson(json.decode(str));

String activeFlatModelToJson(ActiveFlatModel data) =>
    json.encode(data.toJson());

class ActiveFlatModel {
  ActiveFlatModel({
    this.token,
    this.newUser,
    this.communityId,
    this.communityName,    
    this.cityId,
    this.cityName,
    this.flatId,
    this.flatNumber,
    this.blockId,
    this.blockName,
  });

  String? token;
  bool? newUser;
  int? communityId;
  String? communityName;
  int? cityId;
  String? block;
  String? cityName;
  int? flatId;
  String? flatNumber;
  int? blockId;
  String? blockName;

  factory ActiveFlatModel.fromJson(Map<String, dynamic> json) =>
      ActiveFlatModel(
        token: json["token"],
        newUser: json["new_user"],
        communityId: json["community_id"],
        communityName: json["community_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        flatId: json["flat_id"],
        flatNumber: json["flat_number"],
        blockId: json["block_id"],
        blockName: json["block_name"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "new_user": newUser,
        "community_id": communityId,
        "community_name": communityName,
        "city_id": cityId,
        "city_name": cityName,
        "flat_id": flatId,
        "flat_number": flatNumber,
        "block_id": blockId,
        "block_name": blockName
      };
}
