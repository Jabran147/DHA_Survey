import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'user_record.g.dart';

@HiveType(typeId: 1)
class UserRecord extends HiveObject {
  @HiveField(0)
  String? dha_number;
  @HiveField(1)
  String? password;

  UserRecord({this.dha_number = "1234", this.password = "admin"});
}
