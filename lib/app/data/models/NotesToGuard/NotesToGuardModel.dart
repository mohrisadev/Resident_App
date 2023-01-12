// To parse this JSON data, do
//
//     final noteToGuardModel = noteToGuardModelFromJson(jsonString);

import 'dart:convert';

NoteToGuardModel noteToGuardModelFromJson(String str) =>
    NoteToGuardModel.fromJson(json.decode(str));

String noteToGuardModelToJson(NoteToGuardModel data) =>
    json.encode(data.toJson());

class NoteToGuardModel {
  NoteToGuardModel({
    this.id,
    this.date,
    this.flatNumber,
    this.userName,
    this.text,
    this.photo,
  });

  int? id;
  String? date;
  String? flatNumber;
  String? userName;
  String? text;
  String? photo;

  factory NoteToGuardModel.fromJson(Map<String, dynamic> json) =>
      NoteToGuardModel(
        id: json["id"],
        date: json["date"],
        flatNumber: json["flat_number"],
        userName: json["user_name"],
        text: json["text"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "flat_number": flatNumber,
        "user_name": userName,
        "text": text,
        "photo": photo,
      };
}
