// To parse this JSON data, do
//final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());


//
// class UserProfileModel {
//   int? id;
//   String? firstName;
//   String? lastName;
//   String? phone;
//   String? email;
//   int? users;
//   String? photos;
//
//   UserProfileModel(
//       {this.id,
//         this.firstName,
//         this.lastName,
//         this.phone,
//         this.email,
//         this.users,
//         this.photos});
//
//   UserProfileModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     phone = json['phone'];
//     email = json['email'];
//     users = json['users'];
//     photos = json['photos'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['users'] = this.users;
//     data['photos'] = this.photos;
//     return data;
//   }
// }


class UserProfileModel {
  UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.users,
    this.photos,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? users;
  String? photos;
  String? phone;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
          id: json["id"],
          firstName: json["first_name"],
          lastName: json["last_name"],
          email: json["email"],
          users: json["users"],
          photos: json["photos"],
          phone: json["phone"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "users": users,
        "photos": photos,
        "phone": phone
      };
}
