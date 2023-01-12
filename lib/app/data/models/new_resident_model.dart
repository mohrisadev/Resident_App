import 'package:mykommunity/app/data/models/new_user.dart';

class NewResidentmodel {
  int? flat;
  String? role;
  String? occupancy_status;
  bool? connect_opt_in;
  NewUser? user;

  NewResidentmodel(
      {this.flat,
      this.role,
      this.occupancy_status,
      this.connect_opt_in,
      this.user});

  factory NewResidentmodel.fromJson(Map<String, dynamic> json) =>
      NewResidentmodel(
          flat: json["flat"],
          role: json["role"],
          occupancy_status: json["occupancy_status"],
          connect_opt_in: json["connect_opt_in"],
          user: NewUser.fromJson(json["user"]));

  Map<String, dynamic> toJson() => {
        "flat": flat,
        "role": role,
        "occupancy_status": occupancy_status,
        "connect_opt_in": connect_opt_in,
        "user": user
      };
}
