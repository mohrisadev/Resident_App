// To parse this JSON data, do
//
//     final localServiceDetailedModal = localServiceDetailedModalFromJson(jsonString);

import 'dart:convert';

LocalServiceDetailedModal localServiceDetailedModalFromJson(String str) =>
    LocalServiceDetailedModal.fromJson(json.decode(str));

String localServiceDetailedModalToJson(LocalServiceDetailedModal data) =>
    json.encode(data.toJson());

class LocalServiceDetailedModal {
  LocalServiceDetailedModal({
    this.id,
    this.category,
    this.name,
    this.photo,
    this.contactNumber,
    this.households,
    this.ratings,
  });

  int? id;
  String? category;
  String? name;
  String? photo;
  String? contactNumber;
  List<dynamic>? households;
  Ratings? ratings;

  factory LocalServiceDetailedModal.fromJson(Map<String, dynamic> json) =>
      LocalServiceDetailedModal(
        id: json["id"],
        category: json["category"],
        name: json["name"],
        photo: json["photo"],
        contactNumber: json["contact_number"],
        households: List<dynamic>.from(json["households"].map((x) => x)),
        ratings: Ratings.fromJson(json["ratings"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "name": name,
        "photo": photo,
        "contact_number": contactNumber,
        "households": List<dynamic>.from(households!.map((x) => x)),
        "ratings": ratings!.toJson(),
      };
}

class Ratings {
  Ratings({
    this.ratingCount,
    this.rating,
    this.punctualCount,
    this.regularCount,
    this.exceptionalCount,
    this.attitudeCount,
  });

  int? ratingCount;
  dynamic? rating;
  int? punctualCount;
  int? regularCount;
  int? exceptionalCount;
  int? attitudeCount;

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        ratingCount: json["rating_count"],
        rating: json["rating"],
        punctualCount: json["punctual_count"],
        regularCount: json["regular_count"],
        exceptionalCount: json["exceptional_count"],
        attitudeCount: json["attitude_count"],
      );

  Map<String, dynamic> toJson() => {
        "rating_count": ratingCount,
        "rating": rating,
        "punctual_count": punctualCount,
        "regular_count": regularCount,
        "exceptional_count": exceptionalCount,
        "attitude_count": attitudeCount,
      };
}
