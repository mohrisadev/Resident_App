// To parse this JSON data, do
//
//     final advertisementModel = advertisementModelFromJson(jsonString);

import 'dart:convert';

AdvertisementModel advertisementModelFromJson(String str) =>
    AdvertisementModel.fromJson(json.decode(str));

String advertisementModelToJson(AdvertisementModel data) =>
    json.encode(data.toJson());

class AdvertisementModel {
  AdvertisementModel({
    this.id,
    this.photo,
    this.weblink,
    this.community,
  });

  int? id;
  String? photo;
  String? weblink;
  int? community;

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        id: json["id"],
        photo: json["photo"],
        weblink: json["weblink"],
        community: json["community"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "weblink": weblink,
        "community": community,
      };
}
