import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../screens/input_screen.dart';
import '../model/maintenance_record.dart';

class RecordTiles extends StatefulWidget {
  MaintenanceRecord mtRecord;
  int index;

  RecordTiles(this.mtRecord, this.index, {super.key});

  @override
  State<RecordTiles> createState() => _RecordTilesState();
}

class _RecordTilesState extends State<RecordTiles> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: const Color(0xFF0F0A38),
      child: ListTile(
        leading: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              File(widget.mtRecord.imageBefore1.toString()),
              fit: BoxFit.cover,
              width: 40,
            ),
          ),
        ),
        title: Text(
          '${widget.mtRecord.remarks} ${widget.mtRecord.lat} ${widget.mtRecord.long}',
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.mtRecord.createdAt.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => InputScreen(
                          appRecord: widget.mtRecord,
                        ))));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003367),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // child: const Text('Inprocess'),
          child: const Text('View Complaint'),
        ),
      ),
    );
  }
}
