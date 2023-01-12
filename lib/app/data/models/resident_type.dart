class ResidentType {
  int? id;
  String? resident_type;

  ResidentType({this.id, this.resident_type});

  factory ResidentType.fromJson(Map<String, dynamic> json) => ResidentType(
        id: json["id"],
        resident_type: json["resident_type"],
      );

  Map<String, dynamic> toJson() => {"id": id, "resident_type": resident_type};
}
