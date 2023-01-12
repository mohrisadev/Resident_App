import 'dart:convert';

ButtonsModel buttonsModelFromJson(String str) => ButtonsModel.fromJson(json.decode(str));
String buttonsModelToJson(ButtonsModel data) => json.encode(data.toJson());

class ButtonsModel {
  ButtonsModel({
    this.id,
    this.label,
    this.icon,
    this.actionType,
    this.actionUrl,
  });

  int? id;
  String? label;
  String? icon;
  String? actionType;
  String? actionUrl;

  factory ButtonsModel.fromJson(Map<String, dynamic> json) => ButtonsModel(
        id: json["id"],
        label: json["label"],
        icon: json["icon"],
        actionType: json["ACTIONTYPE"],
        actionUrl: json["actionUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "icon": icon,
        "actionType": actionType,
        "actionUrl": actionUrl,
      };
}
