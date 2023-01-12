//
// class CityImageModel {
//   bool? success;
//   List<Data>? data;
//
//   CityImageModel({this.success, this.data});
//
//   CityImageModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? city;
//   String? state;
//   String? stateId;
//   bool? disabled;
//
//   Data({this.id, this.city, this.state, this.stateId, this.disabled});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     city = json['city'];
//     state = json['state'];
//     stateId = json['stateId'];
//     disabled = json['disabled'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['stateId'] = this.stateId;
//     data['disabled'] = this.disabled;
//     return data;
//   }
// }


import 'dart:convert';

CityImageModel cityImageModelFromJson(String str) =>
    CityImageModel.fromJson(json.decode(str));

String cityImageModelToJson(CityImageModel data) => json.encode(data.toJson());

class CityImageModel {
  CityImageModel({
    this.id,
    this.name,
    this.image,
  });

  int? id;
  String? name;
  String? image;

  factory CityImageModel.fromJson(Map<String, dynamic> json) => CityImageModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
