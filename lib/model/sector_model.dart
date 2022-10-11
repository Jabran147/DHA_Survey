// To parse this JSON data, do
//
//     final sectorRecord = sectorRecordFromJson(jsonString);

import 'dart:convert';

List<SectorRecord> sectorRecordFromJson(String str) => List<SectorRecord>.from(
    json.decode(str).map((x) => SectorRecord.fromJson(x)));

String sectorRecordToJson(List<SectorRecord> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectorRecord {
  SectorRecord({
    this.metadata,
    this.docs,
  });

  List<Metadatum>? metadata;
  List<Doc>? docs;

  factory SectorRecord.fromJson(Map<String, dynamic> json) => SectorRecord(
        metadata: List<Metadatum>.from(
            json["metadata"].map((x) => Metadatum.fromJson(x))),
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "metadata": List<dynamic>.from(metadata!.map((x) => x.toJson())),
        "docs": List<dynamic>.from(docs!.map((x) => x.toJson())),
      };
}

class Doc {
  Doc({
    this.id,
    this.sectorName,
    this.phaseId,
    this.createdAt,
  });

  String? id;
  String? sectorName;
  PhaseId? phaseId;
  String? createdAt;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        sectorName: json["sectorName"],
        phaseId: phaseIdValues.map[json["phaseID"]],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sectorName": sectorName,
        "phaseID": phaseIdValues.reverse[phaseId],
        "createdAt": createdAt,
      };
}

enum PhaseId {
  THE_63400892168_E30_DF6_EC1_DE64,
  THE_63400875168_E30_DF6_EC1_DE60,
  THE_63400870168_E30_DF6_EC1_DE5_C,
  THE_6340086_B168_E30_DF6_EC1_DE58,
  THE_63400845168_E30_DF6_EC1_DE53,
  THE_63400838168_E30_DF6_EC1_DE4_E,
  THE_6340082_A168_E30_DF6_EC1_DE49,
  THE_634007_D8168_E30_DF6_EC1_DE44,
  THE_634007_A8168_E30_DF6_EC1_DE3_F
}

final phaseIdValues = EnumValues({
  "634007a8168e30df6ec1de3f": PhaseId.THE_634007_A8168_E30_DF6_EC1_DE3_F,
  "634007d8168e30df6ec1de44": PhaseId.THE_634007_D8168_E30_DF6_EC1_DE44,
  "6340082a168e30df6ec1de49": PhaseId.THE_6340082_A168_E30_DF6_EC1_DE49,
  "63400838168e30df6ec1de4e": PhaseId.THE_63400838168_E30_DF6_EC1_DE4_E,
  "63400845168e30df6ec1de53": PhaseId.THE_63400845168_E30_DF6_EC1_DE53,
  "6340086b168e30df6ec1de58": PhaseId.THE_6340086_B168_E30_DF6_EC1_DE58,
  "63400870168e30df6ec1de5c": PhaseId.THE_63400870168_E30_DF6_EC1_DE5_C,
  "63400875168e30df6ec1de60": PhaseId.THE_63400875168_E30_DF6_EC1_DE60,
  "63400892168e30df6ec1de64": PhaseId.THE_63400892168_E30_DF6_EC1_DE64
});

class Metadatum {
  Metadatum({
    this.total,
    this.page,
  });

  int? total;
  dynamic page;

  factory Metadatum.fromJson(Map<String, dynamic> json) => Metadatum(
        total: json["total"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
