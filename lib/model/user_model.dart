// To parse this JSON data, do
//
//     final userRecord = userRecordFromJson(jsonString);

import 'dart:convert';

UserRecord userRecordFromJson(String str) =>
    UserRecord.fromJson(json.decode(str));

String userRecordToJson(UserRecord data) => json.encode(data.toJson());

class UserRecord {
  UserRecord({
    this.id,
    this.officerId,
    this.username,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
  });

  String? id;
  String? officerId;
  String? username;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;

  factory UserRecord.fromJson(Map<String, dynamic> json) => UserRecord(
        id: json["_id"],
        officerId: json["officerID"],
        username: json["username"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "officerID": officerId,
        "username": username,
        "password": password,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "token": token,
      };
}
