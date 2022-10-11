import 'package:flutter/material.dart';
import '../model/sector_model.dart';
import '../utils/api_service.dart';
import '../model/phase_model.dart';

class PhaseDemo extends StatefulWidget {
  const PhaseDemo({super.key});

  @override
  State<PhaseDemo> createState() => _PhaseDemoState();
}

class _PhaseDemoState extends State<PhaseDemo> {
  late List<PhaseRecord>? phaseModel = [];
  late List<SectorRecord>? sectorModel = [];
  Map map1 = {};
  @override
  void initState() {
    super.initState();
    _getData();
    // _getSector();
    // getUniqueValue();
  }

  // void _getData() async {
  //   phaseModel = (await ApiService().getPhases());
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }

  void _getData() async {
    phaseModel = (await ApiService().getPhases());
    for (var i = 0; i < phaseModel!.length; i++) {
      map1 = phaseModel![i].docs!.asMap();
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    // print(netData());
  }

  // void _getSector() async {
  //   sectorModel = (await ApiService().getSectors());
  //   // for (var i = 0; i < phaseModel!.length; i++) {
  //   //   map1 = phaseModel![i].docs!.asMap();
  //   // }
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }

  // netData() {
  //   return map1.entries.map((e) {
  //     return e.value.phaseName;
  //   }).toList();
  // }

  // void getUniqueValue() {
  //   for (var i = 0; i < map1.keys.length; i++) {
  //     // print('Phase Value: ${phaseModel![0].docs![i].phaseName}');
  //     print('Phase Value: ${phaseModel!.length}');
  //     print("12.31213");
  //   }
  //   print("xxxxxxxx12.31213");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api'),
        centerTitle: true,
      ),
      body: phaseModel == null || phaseModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: phaseModel!.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: Column(
                    children: [
                      Text(
                        'Total Phase records found: ${phaseModel.runtimeType}',
                      ),
                      Text(
                        'Total Sector records found: ${sectorModel![index].docs!.length}',
                      ),
                      Text(
                        'Phases:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      // Text('${phaseModel![index].docs.runtimeType}'),
                      // Text('${phaseModel![index].docs!.asMap()}'),
                      for (int i = 0; i < phaseModel![index].docs!.length; i++)
                        Text('${map1[i].phaseName}'),
                      Text(
                        'Sectors:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // for (int j = 0; j < sectorModel![0].docs!.length; j++)
                      //   if (phaseModel![index].docs![0].id ==
                      //       sectorModel![index].docs![j].phaseId)
                      //     Text('${sectorModel![index].docs!.length}'),
                      // Text(phaseModel![index].docs![i].phaseName as String),
                    ],
                  ),
                );
              }),
    );
  }
}
