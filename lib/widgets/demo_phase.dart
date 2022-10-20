/****************/
//For testing prupose only
/***************/

// import 'dart:developer';
// import 'package:dha_cleaning_app/utils/api_constants.dart';
// import 'package:flutter/material.dart';
// import '../model/sector_model.dart';
// import '../model/phase_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:dha_cleaning_app/utils/shared_service.dart';

// class PhaseDemo extends StatefulWidget {
//   const PhaseDemo({super.key});

//   @override
//   State<PhaseDemo> createState() => _PhaseDemoState();
// }

// class _PhaseDemoState extends State<PhaseDemo> {
//   bool isSectorSelected = false;
//   late List<PhaseRecord>? phaseModel = [];
//   late List<SectorRecord>? sectorModel = [];
//   List? allSectors;
//   List? allPhases;
//   List? filterdSectors = [];
//   String? phase;
//   String? sector;
//   @override
//   void initState() {
//     super.initState();
//     getPhases();
//     // _getData();
//     // _getPhase();
//     // _getSector();
//     // getUniqueValue();
//   }

//   // void _getPhase() async {
//   //   phaseModel = (await ApiService().getPhases());
//   //   allPhases = phaseModel![0].docs;
//   //   print(allPhases!.length);
//   //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
//   // }

//   // void _getSector() async {
//   //   sectorModel = (await ApiService().getSectors());
//   //   allSectors = sectorModel![0].docs;
//   //   print(allSectors!.length);
//   //   // for (var i = 0; i < allSectors!.length; i++) {
//   //   //   print(allSectors![i].sectorName);
//   //   // }
//   //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
//   // }

//   // void filterData(value) {
//   //   filterdSectors = allSectors!
//   //       .where(
//   //           (element) => allPhases!.any((field) => field.id == element.phaseid))
//   //       .toList();
//   //   // sectorModel!
//   //   //     .where((element1) => phaseModel!.any((element2) => element2.docs!.any(
//   //   //         (element3) =>
//   //   //             element3.id ==
//   //   //             element1.docs!.any((element4) => element4.phaseId))))
//   //   //     .toList();
//   //   print("This is the filtered Sector $filterdSectors");
//   // }

//   // Future<String?> getPhaseList() async {
//   //   var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.phaseEndpoint);
//   //   var loginDetails = await SharedService.loginDetails();
//   //   Map<String, String> requestHeaders = {
//   //     'Content-Type': 'application/json',
//   //     'x-access-token': loginDetails!.token
//   //   };
//   //   await http
//   //       .post(
//   //     url,
//   //     headers: requestHeaders,
//   //   )
//   //       .then((response) {
//   //     Map<String, dynamic> data = json.decode(response.body);
//   //     print(data);
//   //     // setState(() {
//   //     //   allPhases = data;
//   //     // });
//   //   });
//   // }

//   // Future<String?> getSectorList() async {
//   //   var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectorEndpoint);
//   //   var loginDetails = await SharedService.loginDetails();
//   //   Map<String, String> requestHeaders = {
//   //     'Content-Type': 'application/json',
//   //     'x-access-token': loginDetails!.token
//   //   };
//   //   await http.post(url, headers: requestHeaders, body: {
//   //     'phaseID': phase,
//   //   }).then((response) {
//   //     var data = json.decode(response.body);
//   //     // setState(() {
//   //     //   allSectors = data;
//   //     // });
//   //   });
//   // }
//   static var client = http.Client();
//   Future<List<PhaseRecord>?> getPhases() async {
//     var loginDetails = await SharedService.loginDetails();

//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//       'x-access-token': loginDetails!.token
//     };
//     try {
//       var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.phaseEndpoint);
//       var response = await client.post(url, headers: requestHeaders);
//       if (response.statusCode == 200) {
//         List<PhaseRecord> model = phaseRecordFromJson(response.body.toString());
//         print('This is the $model');
//         return model;
//       }
//       // var respone = await http.get(url);
//       // if (response.statusCode == 200) {
//       //   List<PhaseRecord> model = phaseRecordFromJson(response.body.toString());
//       //   return model;
//       // }
//     } catch (e) {
//       log(e.toString());
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Rest Api'),
//           centerTitle: true,
//         ),
//         body: phaseModel!.isEmpty
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             // : Container(
//             //     padding: EdgeInsets.only(left: 15, right: 15, top: 5),
//             //     color: Colors.white,
//             //     child: Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //       children: <Widget>[
//             //         Expanded(
//             //           child: DropdownButtonHideUnderline(
//             //             child: ButtonTheme(
//             //               alignedDropdown: true,
//             //               child: DropdownButtonFormField(
//             //                 decoration: const InputDecoration(
//             //                   enabledBorder: InputBorder.none,
//             //                   errorBorder: InputBorder.none,
//             //                   focusedBorder: InputBorder.none,
//             //                   focusedErrorBorder: InputBorder.none,
//             //                 ),
//             //                 isExpanded: true,
//             //                 validator: (value) {
//             //                   if (value == null) {
//             //                     return 'Choose the option from dropdown';
//             //                   } else {
//             //                     return null;
//             //                   }
//             //                 },
//             //                 // underline: Container(),
//             //                 hint: const Text(
//             //                   'Choose option',
//             //                   style: TextStyle(color: Color(0xFFC1C1C1)),
//             //                 ),
//             //                 value: phase,
//             //                 // items: phases.map((String value) {
//             //                 //   return DropdownMenuItem(
//             //                 //     value: value,
//             //                 //     child: Text(value),
//             //                 //   );
//             //                 // }).toList(),
//             //                 items: allPhases?.map((e) {
//             //                       return DropdownMenuItem(
//             //                         value: e.id.toString(),
//             //                         child: Text(e.phaseName),
//             //                       );
//             //                     }).toList() ??
//             //                     [],
//             //                 onChanged: (value) {
//             //                   phase = value as String;
//             //                   getSectorList();
//             //                   print(phase);
//             //                 },
//             //                 // (value) {
//             //                 // setState(() {
//             //                 // allSectors = [];
//             //                 // phase = value! as String;
//             //                 // allSectors!.firstWhere((element) => false)
//             //                 // allSectors!.where((element) {
//             //                 //   for (var i = 0; i < allPhases!.length; i++) {
//             //                 //     if (element.phaseID == allPhases![i]._id) {
//             //                 //       filterdSectors = element.sectorName;
//             //                 //     }
//             //                 //   }
//             //                 //   return true;
//             //                 // }).toList();

//             //                 // for (var i = 0; i < allPhases!.length; i++) {
//             //                 //   if (allPhases![i].phaseName == value) {
//             //                 //     allSectors = allPhases![i]["phase"];
//             //                 //   }
//             //                 // }
//             //                 // isSectorSelected = true;
//             //                 // });
//             //                 // },
//             //                 icon:
//             //                     const Icon(Icons.arrow_drop_down_circle_outlined),
//             //                 iconEnabledColor: const Color(0xFF0F0A38),
//             //               ),
//             //             ),
//             //           ),
//             //         ),
//             //         Expanded(
//             //           child: DropdownButtonHideUnderline(
//             //             child: ButtonTheme(
//             //               alignedDropdown: true,
//             //               child: DropdownButtonFormField(
//             //                 decoration: const InputDecoration(
//             //                   enabledBorder: InputBorder.none,
//             //                   errorBorder: InputBorder.none,
//             //                   focusedBorder: InputBorder.none,
//             //                   focusedErrorBorder: InputBorder.none,
//             //                 ),
//             //                 isExpanded: true,
//             //                 validator: (value) {
//             //                   if (value == null) {
//             //                     return 'Choose the option from dropdown';
//             //                   } else {
//             //                     return null;
//             //                   }
//             //                 },
//             //                 // underline: Container(),
//             //                 hint: const Text(
//             //                   'Choose option',
//             //                   style: TextStyle(color: Color(0xFFC1C1C1)),
//             //                 ),
//             //                 value: sector,
//             //                 // items: phases.map((String value) {
//             //                 //   return DropdownMenuItem(
//             //                 //     value: value,
//             //                 //     child: Text(value),
//             //                 //   );
//             //                 // }).toList(),
//             //                 items: allSectors?.map((e) {
//             //                   return DropdownMenuItem(
//             //                     value: e.id.toString(),
//             //                     child: Text(e.sectorName),
//             //                   );
//             //                 }).toList(),
//             //                 // items: allSectors.where((element) {
//             //                 //   return DropdownMenuItem(child: )
//             //                 // }).toList();
//             //                 onChanged: (value) {
//             //                   setState(() {
//             //                     sector = value;
//             //                   });
//             //                 },
//             //                 icon:
//             //                     const Icon(Icons.arrow_drop_down_circle_outlined),
//             //                 iconEnabledColor: const Color(0xFF0F0A38),
//             //               ),
//             //             ),
//             //           ),
//             //         )
//             //       ],
//             //     ),
//             //   ),
//             : Text("Data Loaded"));
//   }
// }
