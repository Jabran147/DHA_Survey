// import 'package:flutter/material.dart';

// class PhaseDropDown extends StatefulWidget {
//   const PhaseDropDown({super.key});

//   @override
//   State<PhaseDropDown> createState() => _PhaseDropDownState();
// }

// class _PhaseDropDownState extends State<PhaseDropDown> {
//   String? chosenValue1;
//   bool disabledDropDown = true;
//   List<DropdownMenuItem<String>> menuItem = [];
//   List<String> phases = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     '9',
//   ];
//   final phase1 = {
//     '1': 'A',
//     '2': 'B',
//     '3': 'C',
//     '4': 'D',
//     '5': 'E',
//     '6': 'F',
//     '7': 'G',
//     '8': 'H',
//     '9': 'J',
//     '10': 'K',
//     '11': 'L',
//     '12': 'M',
//     '13': 'N',
//     '14': 'P',
//   };
//   final phase2 = {
//     '1': 'Sector Q',
//     '2': 'Sector R',
//     '3': 'Sector S',
//     '4': 'Sector T',
//     '5': 'Sector U',
//     '6': 'Sector V',
//   };
//   final phase3 = {
//     '1': 'Sector W',
//     '2': 'Sector X',
//     '3': 'Sector Y',
//     '4': 'Sector Z',
//     '5': 'Sector XX',
//   };
//   final phase4 = {
//     '1': 'Sector AA',
//     '2': 'Sector BB',
//     '3': 'Sector CC',
//     '4': 'Sector DD',
//     '5': 'Sector EE',
//     '6': 'Sector FF',
//     '7': 'Sector GG',
//     '8': 'Sector HH',
//     '9': 'Sector JJ',
//     '10': 'Sector KK',
//   };
//   final phase5 = {
//     '1': 'Sector A',
//     '2': 'Sector B',
//     '3': 'Sector C',
//     '4': 'Sector D',
//     '5': 'Sector E',
//     '6': 'Sector F',
//     '7': 'Sector G',
//     '8': 'Sector H',
//     '9': 'Sector J',
//     '10': 'Sector K',
//     '11': 'Sector L',
//     '12': 'Sector M',
//   };

//   void populatePhase1() {
//     for (String key in phase1.keys) {
//       menuItem.add(
//         DropdownMenuItem(
//           value: phase1[key],
//           child: Text(phase1[key] as String),
//         ),
//       );
//     }
//   }

//   void populatePhase2() {
//     for (String key in phase2.keys) {
//       menuItem.add(
//         DropdownMenuItem(
//           value: phase2[key],
//           child: Text(phase2[key] as String),
//         ),
//       );
//     }
//   }

//   void populatePhase3() {
//     for (String key in phase3.keys) {
//       menuItem.add(
//         DropdownMenuItem(
//           value: phase3[key],
//           child: Text(phase3[key] as String),
//         ),
//       );
//     }
//   }

//   void populatePhase4() {
//     for (String key in phase4.keys) {
//       menuItem.add(
//         DropdownMenuItem(
//           value: phase4[key],
//           child: Text(phase4[key] as String),
//         ),
//       );
//     }
//   }

//   void populatePhase5() {
//     for (String key in phase5.keys) {
//       menuItem.add(
//         DropdownMenuItem(
//           value: phase5[key],
//           child: Text(phase5[key] as String),
//         ),
//       );
//     }
//   }

//   void valueChanged(value) {
//     if (value == '1') {
//       menuItem = [];
//       populatePhase1();
//     } else if (value == '2') {
//       menuItem = [];
//       populatePhase2();
//     } else if (value == '3') {
//       menuItem = [];
//       populatePhase3();
//     } else if (value == '4') {
//       menuItem = [];
//       populatePhase4();
//     } else if (value == '5') {
//       menuItem = [];
//       populatePhase5();
//     }
//     setState(() {
//       chosenValue1 = value;
//       disabledDropDown = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: const Color(0xFFC1C1C1),
//         ),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//         child: DropdownButton(
//           isExpanded: true,
//           underline: Container(),
//           hint: const Text(
//             'Choose option',
//             style: TextStyle(color: Color(0xFFC1C1C1)),
//           ),
//           value: chosenValue1,
//           items: phases.map((String value) {
//             return DropdownMenuItem(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (String? value) => valueChanged(value!),
//           icon: const Icon(Icons.arrow_drop_down_circle_outlined),
//           iconEnabledColor: const Color(0xFF0F0A38),
//         ),
//       ),
//     );
//   }
// }
