class AllowCabOnce {
  String? validFromdate;
  String? onceStarttime;
  int? onceValidfor;
  String? vehicleNumber;
  String? company;

  AllowCabOnce(
      {this.validFromdate,
      this.onceStarttime,
      this.onceValidfor,
      this.vehicleNumber,
      this.company});

  factory AllowCabOnce.fromJson(Map<String, dynamic> json) => AllowCabOnce(
        validFromdate: json["valid_from_date"],
        onceStarttime: json["once_start_time"],
        onceValidfor: json["once_valid_for"],
        vehicleNumber: json["vehicle_number"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "valid_from_date": validFromdate,
        "once_start_time": onceStarttime,
        "once_valid_for": onceValidfor,
        "vehicle_number": vehicleNumber,
        "company": company
      };
}
