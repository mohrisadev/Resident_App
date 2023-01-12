class AllowDeliveryOncemodel {
  String? validFromdate;
  String? onceStarttime;
  int? onceValidfor;
  String? company;
  

  AllowDeliveryOncemodel(
      {this.validFromdate,
      this.onceStarttime,
      this.onceValidfor,
      this.company});

  factory AllowDeliveryOncemodel.fromJson(Map<String, dynamic> json) =>
      AllowDeliveryOncemodel(
        validFromdate: json["valid_from_date"],
        onceStarttime: json["once_start_time"],
        onceValidfor: json["once_valid_for"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "valid_from_date": validFromdate,
        "once_start_time": onceStarttime,
        "once_valid_for": onceValidfor,
        "company": company
      };
}
