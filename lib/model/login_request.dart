import 'dart:convert';

LoginRequest loginRequest(String str) =>
    LoginRequest.fromJson(json.decode(str));

class LoginRequest {
  LoginRequest({
    required this.username,
    required this.password,
    required this.isMobile,
  });
  late final String username;
  late final String password;
  late final int isMobile;

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    isMobile = json['isMobile'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    _data['isMobile'] = isMobile;
    return _data;
  }
}
