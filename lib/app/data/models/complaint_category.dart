class ComplaintCategory {
  int? id;
  String? name;

  ComplaintCategory({
    this.id,
    this.name,
  });

  setId(int? _id) {
    id = _id;
  }

  setName(String? _name) {
    name = _name;
  }

  factory ComplaintCategory.fromJson(Map<String, dynamic> json) =>
      ComplaintCategory(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
