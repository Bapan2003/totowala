class SendOTPModel {
  int? id;
  String? phoneNumber;
  String? countryCode;
  int? otp;
  String? status;
  String? expiry;
  int? userId;
  String? createdAt;
  String? updatedAt;

  SendOTPModel(
      {this.id,
        this.phoneNumber,
        this.countryCode,
        this.otp,
        this.status,
        this.expiry,
        this.userId,
        this.createdAt,
        this.updatedAt});

  SendOTPModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    otp = json['otp'];
    status = json['status'];
    expiry = json['expiry'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['countryCode'] = this.countryCode;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['expiry'] = this.expiry;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
