
class NewUser {
  bool? success;
  Data? data;
   String? firstName;
    String? lastName;
     String? email;
     String? mobileNumber;
    String? middleName;
  NewUser({this.success, this.data,this.email,this.firstName,this.middleName,
    this.mobileNumber,this.lastName});

  NewUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  Null? mobileNumber;
  bool? disabled;
  Null? firstName;
  Null? lastName;
  Null? middleName;

  Data(
      {this.id,
        this.email,
        this.mobileNumber,
        this.disabled,
        this.firstName,
        this.lastName,
        this.middleName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    disabled = json['disabled'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['disabled'] = this.disabled;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    return data;
  }
}



// class NewUser {
//   String? first_name;
//   String? last_name;
//   String? email;
//   String? phone;
//
//   NewUser({this.first_name, this.last_name, this.email, this.phone});
//
//   factory NewUser.fromJson(Map<String, dynamic> json) => NewUser(
//       first_name: json["first_name"],
//       last_name: json["last_name"],
//       email: json["email"],
//       phone: json["phone"]);
//
//   Map<String, dynamic> toJson() => {
//         "first_name": first_name,
//         "last_name": last_name,
//         "email": email,
//         "phone": phone
//       };
// }
