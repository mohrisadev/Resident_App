class VisitingHelpCategoriesmodel {
  int? id;
  String? name;

  VisitingHelpCategoriesmodel({
    this.id,
    this.name,
  });

  factory VisitingHelpCategoriesmodel.fromJson(Map<dynamic, dynamic> json) =>
      VisitingHelpCategoriesmodel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
