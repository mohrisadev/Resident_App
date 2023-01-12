
import 'dart:convert';

AmenityClubModel amenityModelFromJson(String str) => AmenityClubModel.fromJson(json.decode(str));
String amenityModelToJson(AmenityClubModel data) => json.encode(data.toJson());

class AmenityClubModel {
  int? id;
  int? amenityName;
  String? date;
  String? time;
  bool? booked;
  String? price;
  int? bookedBy;
  int? flat;
  AmenityClubModel(
      {this.id,
        this.amenityName,
        this.date,
        this.time,
        this.booked,
        this.price,
        this.bookedBy,
        this.flat});
  AmenityClubModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amenityName = json['amenity_name'];
    date = json['date'];
    time = json['time'];
    booked = json['booked'];
    price = json['price'];
    bookedBy = json['booked_by'];
    flat = json['flat'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amenity_name'] = this.amenityName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['booked'] = this.booked;
    data['price'] = this.price;
    data['booked_by'] = this.bookedBy;
    data['flat'] = this.flat;
    return data;
  }
}