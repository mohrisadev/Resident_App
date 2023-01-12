import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));
String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.id,
    this.community,
    this.flat,
    this.message,
    this.date,
    this.name,
    this.photo,
    this.file,
  });

  int? id;
  int? community;
  String? flat;
  String? message;
  DateTime? date;
  String? name;
  String? photo;
  String? file;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        community: json["community"],
        flat: json["flat"],
        message: json["message"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        photo: json["photo"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "community": community,
        "flat": flat,
        "message": message,
        "date": date,
        "name": name,
        "photo": photo,
        "file": file,
      };

      
}
