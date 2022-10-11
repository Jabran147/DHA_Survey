import 'dart:convert';

LoginResponse loginResponseJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  LoginResponse({
    required this.id,
    required this.officerID,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.token,
  });
  late final String id;
  late final String officerID;
  late final String username;
  late final String password;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final String token;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    officerID = json['officerID'];
    username = json['username'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['officerID'] = officerID;
    _data['username'] = username;
    _data['password'] = password;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['token'] = token;
    return _data;
  }
}
