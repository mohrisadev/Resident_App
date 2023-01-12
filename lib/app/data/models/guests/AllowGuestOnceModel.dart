class AllowGuestOnceModel {
  String? phone;
  String? name;
  int? frequencyType;
  String? validFromDate;
  String? onceStartTime;
  int? onceValidFor;

  AllowGuestOnceModel({
    this.phone,
    this.name,
    this.frequencyType,
    this.validFromDate,
    this.onceStartTime,
    this.onceValidFor,
  });

  factory AllowGuestOnceModel.fromJson(Map<String, dynamic> json) =>
      AllowGuestOnceModel(
          phone: json["phone"],
          name: json["name"],
          frequencyType: json["frequency_type"],
          validFromDate: json["valid_from_date"],
          onceStartTime: json["once_start_time"],
          onceValidFor: json["once_valid_for"]);

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "frequency_type": frequencyType,
        "valid_from_date": validFromDate,
        "once_start_time": onceStartTime,
        "once_valid_for": onceValidFor
      };
}
