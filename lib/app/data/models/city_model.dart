class City {
  String? id;
  String? name;

  City({
    this.id,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) =>
      City(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
