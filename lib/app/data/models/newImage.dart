class NewImage {
  NewImage({this.id, this.localurl});

  int? id;
  String? localurl;

  Map<String, dynamic> toJson() => {"id": id};
}
