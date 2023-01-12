import 'dart:convert';

AmenityModel amenityModelFromJson(String str) => AmenityModel.fromJson(json.decode(str));
String amenityModelToJson(AmenityModel data) => json.encode(data.toJson());

// class AmenityModel {
//   int? count;
//   Null? next;
//   Null? previous;
//   List<Results>? results;
//
//   AmenityModel({this.count, this.next, this.previous, this.results});
//
//   AmenityModel.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     next = json['next'];
//     previous = json['previous'];
//     if (json['results'] != null) {
//       results = <Results>[];
//       json['results'].forEach((v) {
//         results!.add(new Results.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['next'] = this.next;
//     data['previous'] = this.previous;
//     if (this.results != null) {
//       data['results'] = this.results!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class AmenityModel {
  int? id;
  String? amenityName;
  int? community;
  String? bookingStartTime;
  String? bookingEndTime;
  String? price;
  bool? status;
  String? maxDays;
  String? maxCapacity;
  String? advanceBookingLimit;
  String? bookingType;

  AmenityModel(
      {this.id,
        this.amenityName,
        this.community,
        this.bookingStartTime,
        this.bookingEndTime,
        this.price,
        this.status,
        this.maxDays,
        this.maxCapacity,
        this.advanceBookingLimit,
        this.bookingType});

  AmenityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amenityName = json['amenity_name'];
    community = json['community'];
    bookingStartTime = json['booking_start_time'];
    bookingEndTime = json['booking_end_time'];
    price = json['price'];
    status = json['status'];
    maxDays = json['max_days'];
    maxCapacity = json['max_capacity'];
    advanceBookingLimit = json['advance_booking_limit'];
    bookingType = json['booking_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amenity_name'] = this.amenityName;
    data['community'] = this.community;
    data['booking_start_time'] = this.bookingStartTime;
    data['booking_end_time'] = this.bookingEndTime;
    data['price'] = this.price;
    data['status'] = this.status;
    data['max_days'] = this.maxDays;
    data['max_capacity'] = this.maxCapacity;
    data['advance_booking_limit'] = this.advanceBookingLimit;
    data['booking_type'] = this.bookingType;
    return data;
  }
}
