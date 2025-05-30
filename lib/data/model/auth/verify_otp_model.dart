class VerifyOTPModel {
  int? id;
  String? phoneNumber;
  String? countryCode;
  String? fcmToken;
  bool? isVerified;
  String? status;
  String? role;
  String? accessToken;
  String? refreshToken;

  VerifyOTPModel(
      {this.id,
        this.phoneNumber,
        this.countryCode,
        this.fcmToken,
        this.isVerified,
        this.status,
        this.role,
        this.accessToken,
        this.refreshToken});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    fcmToken = json['fcmToken'];
    isVerified = json['isVerified'];
    status = json['status'];
    role = json['role'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['countryCode'] = this.countryCode;
    data['fcmToken'] = this.fcmToken;
    data['isVerified'] = this.isVerified;
    data['status'] = this.status;
    data['role'] = this.role;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
