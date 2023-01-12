class AllowVisitHelpOncemodel {
  int? visitingHelpCategoryId;
  String? validFromdate;
  String? onceStarttime;
  int? onceValidfor;
  String? company;

  AllowVisitHelpOncemodel(
      {this.visitingHelpCategoryId,
      this.validFromdate,
      this.onceStarttime,
      this.onceValidfor,
      this.company});

  factory AllowVisitHelpOncemodel.fromJson(Map<String, dynamic> json) =>
      AllowVisitHelpOncemodel(
        visitingHelpCategoryId: json["visiting_help_category"],
        validFromdate: json["valid_from_date"],
        onceStarttime: json["once_start_time"],
        onceValidfor: json["once_valid_for"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "visiting_help_category": visitingHelpCategoryId,
        "valid_from_date": validFromdate,
        "once_start_time": onceStarttime,
        "once_valid_for": onceValidfor,
        "company": company
      };
}
