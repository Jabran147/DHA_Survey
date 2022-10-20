import 'package:dha_cleaning_app/model/sector_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'phase_record.g.dart';

@HiveType(typeId: 2)
class PhasesRecords extends HiveObject {
  @HiveField(0)
  String? id;
  String? phaseName;
  String? createdAt;
  PhasesRecords({this.id, this.phaseName, this.createdAt});
}
