// To parse this JSON data, do
//
//     final confirmedComplaintModal = confirmedComplaintModalFromJson(jsonString);

import 'dart:convert';

ConfirmedComplaintModal confirmedComplaintModalFromJson(String str) =>
    ConfirmedComplaintModal.fromJson(json.decode(str));

String confirmedComplaintModalToJson(ConfirmedComplaintModal data) =>
    json.encode(data.toJson());

class ConfirmedComplaintModal {
  ConfirmedComplaintModal({
    this.ticketNumber,
    this.description,
    this.photos,
    this.comments,
    this.rating,
    this.id,
    this.category,
    this.subCategory,
    this.complainType,
    this.status,
    this.assignee,
    this.resolvedBy,
    this.createdAt,
    this.modifiedAt,
  });

  int? ticketNumber;
  String? description;
  List<Photo>? photos;
  List<Comment>? comments;
  Rating? rating;
  int? id;
  String? category;
  String? subCategory;
  String? complainType;
  String? status;
  String? assignee;
  String? resolvedBy;
  DateTime? createdAt;
  DateTime? modifiedAt;

  factory ConfirmedComplaintModal.fromJson(Map<String, dynamic> json) =>
      ConfirmedComplaintModal(
        ticketNumber: json["ticket_number"],
        description: json["description"],
        photos: json["photos"] != null
            ? List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x)))
            : [],
        comments: json["comments"] != null
            ? List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x)))
            : [],
        rating: json["rating"] != null ? Rating.fromJson(json["rating"]) : null,
        id: json["id"],
        category: json["category"],
        subCategory: json["sub_category"],
        complainType: json["complain_type"],
        status: json["status"],
        assignee: json["assignee"],
        resolvedBy: json["resolved_by"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
      );

  Map<String, dynamic> toJson() => {
        "ticket_number": ticketNumber,
        "description": description,
        "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "rating": rating!.toJson(),
        "id": id,
        "category": category,
        "sub_category": subCategory,
        "complain_type": complainType,
        "status": status,
        "assignee": assignee,
        "resolved_by": resolvedBy,
        "created_at": createdAt!.toIso8601String(),
        "modified_at": modifiedAt!.toIso8601String(),
      };
}

class Comment {
  Comment({
    this.comment,
    this.photos,
    this.id,
    this.commentedBy,
    this.commentedAt,
  });

  String? comment;
  List<Photo>? photos;
  int? id;
  String? commentedBy;
  DateTime? commentedAt;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        comment: json["comment"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        id: json["id"],
        commentedBy: json["commented_by"],
        commentedAt: DateTime.parse(json["commented_at"]),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
        "id": id,
        "commented_by": commentedBy,
        "commented_at": commentedAt!.toIso8601String(),
      };
}

class Photo {
  Photo({
    this.image,
  });

  String? image;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class Rating {
  Rating({
    this.rating,
    this.feedback,
    this.ratedBy,
    this.ratedAt,
  });

  int? rating;
  String? feedback;
  String? ratedBy;
  DateTime? ratedAt;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rating: json["rating"],
        feedback: json["feedback"],
        ratedBy: json["rated_by"],
        ratedAt: DateTime.parse(json["rated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "feedback": feedback,
        "rated_by": ratedBy,
        "rated_at": ratedAt,
      };
}
