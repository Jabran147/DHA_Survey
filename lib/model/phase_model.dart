// To parse this JSON data, do
//
//     final phaseRecord = phaseRecordFromJson(jsonString);

import 'dart:convert';

List<PhaseRecord> phaseRecordFromJson(String str) => List<PhaseRecord>.from(json.decode(str).map((x) => PhaseRecord.fromJson(x)));

String phaseRecordToJson(List<PhaseRecord> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhaseRecord {
    PhaseRecord({
        this.metadata,
        this.docs,
    });

    List<Metadatum>? metadata;
    List<Doc>? docs;

    factory PhaseRecord.fromJson(Map<String, dynamic> json) => PhaseRecord(
        metadata: List<Metadatum>.from(json["metadata"].map((x) => Metadatum.fromJson(x))),
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
        this.phaseName,
        this.createdAt,
    });

    String? id;
    String? phaseName;
    String? createdAt;

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        phaseName: json["phaseName"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phaseName": phaseName,
        "createdAt": createdAt,
    };
}

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
