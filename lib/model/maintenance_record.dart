import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'maintenance_record.g.dart';

@HiveType(typeId: 0)
class MaintenanceRecord extends HiveObject {
  @HiveField(0)
  String? phase;
  @HiveField(1)
  String? sector;
  @HiveField(2)
  String? category;
  @HiveField(3)
  String? complainType;
  @HiveField(4)
  String status;
  @HiveField(5)
  String? remarks;
  @HiveField(6)
  String? createdAt;
  @HiveField(7)
  String? imageBefore1;
  @HiveField(8)
  String? imageBefore2;
  @HiveField(9)
  String? imageAfter1;
  @HiveField(10)
  String? imageAfter2;
  @HiveField(11)
  String? lat;
  @HiveField(12)
  String? long;

  MaintenanceRecord(
      {this.phase,
      this.sector,
      this.category,
      this.complainType,
      this.status = '0',
      this.remarks,
      this.createdAt,
      this.imageBefore1,
      this.imageBefore2,
      this.imageAfter1,
      this.imageAfter2,
      this.lat,
      this.long});
}
