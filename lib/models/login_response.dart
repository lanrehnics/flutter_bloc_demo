class LoginResponse {
//  LoginData data;
  String message;
  bool success;

  LoginResponse({this.message, this.success});

  LoginResponse.fromJson(Map<String, dynamic> json) {
//    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}
