import 'dart:convert';

List<NoteToGuardModel> noteToGuardModelFromJson(String str) =>
    List<NoteToGuardModel>.from(
        json.decode(str).map((x) => NoteToGuardModel.fromJson(x)));

String noteToGuardModelToJson(List<NoteToGuardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteToGuardModel {
  NoteToGuardModel({
    this.id,
    this.flatNumber,
    this.userName,
    this.text,
    this.photo,
    this.date,
  });

  int? id;
  String? flatNumber;
  String? userName;
  String? text;
  String? photo;
  DateTime? date;

  factory NoteToGuardModel.fromJson(Map<String, dynamic> json) =>
      NoteToGuardModel(
        id: json["id"],
        flatNumber: json["flat_number"],
        userName: json["user_name"],
        text: json["text"],
        photo: json["photo"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flat_number": flatNumber,
        "user_name": userName,
        "text": text,
        "photo": photo,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
