import 'dart:convert';

class Noticesmodel {
  Noticesmodel({
    this.id,
    this.subject,
    this.message,
    this.publishedAt,
    this.media,
  });

  int? id;
  String? subject;
  String? message;
  DateTime? publishedAt;
  List<dynamic>? media;

  factory Noticesmodel.fromJson(Map<String, dynamic> json) => Noticesmodel(
        id: json["id"],
        subject: json["subject"],
        message: json["message"],
        publishedAt: DateTime.parse(json["published_at"]),
        media: List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "message": message,
        "published_at": publishedAt?.toIso8601String(),
        "media": List<dynamic>.from(media!.map((x) => x)),
      };
}
