class FBUidToken {
  String? firebaseToken;
  String? mobileNumber;

  FBUidToken({this.firebaseToken, this.mobileNumber});
  FBUidToken.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    firebaseToken = json['firebaseToken'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}
// class FBUidToken {
//   String? fb_uid;
//   String? fb_token;
//   String? fb_phone;
//
//   FBUidToken({this.fb_uid, this.fb_token, this.fb_phone});
//   FBUidToken.fromJson(Map<String, dynamic> json) {
//     fb_uid = json['fb_uid'];
//     fb_token = json['fb_token'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['fb_uid'] = this.fb_uid;
//     data['fb_token'] = this.fb_token;
//     return data;
//   }
// }
