class Flat {
  int? id;
  String? name;

  Flat({
    this.id,
    this.name,
  });

  factory Flat.fromJson(Map<String, dynamic> json) =>
      Flat(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
