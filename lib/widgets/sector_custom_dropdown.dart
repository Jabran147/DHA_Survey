// import 'package:flutter/material.dart';
// import './phase_custom_dropdown.dart';

// class SectorDropDown extends StatefulWidget {
//   const SectorDropDown({super.key});

//   @override
//   State<SectorDropDown> createState() => _SectorDropDownState();
// }

// class _SectorDropDownState extends State<SectorDropDown> {
//   // String? chosenValue2;
//   // bool disabledDropDown = true;
//   // List<DropdownMenuItem<String>> menuItem = [];
//   // void changeValue(value) {
//   //   setState(() {
//   //     chosenValue2 = value;
//   //   });
//   // }
// // 
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
//           disabledHint: const Text(
//             'Select the Phase no. first',
//             style: TextStyle(color: Color(0xFFC1C1C1)),
//           ),
//           value: chosenValue2,
//           items: menuItem,
//           onChanged: disabledDropDown ? null : (value) => changeValue(value),
//           icon: const Icon(Icons.arrow_drop_down_circle_outlined),
//           iconEnabledColor: const Color(0xFF0F0A38),
//         ),
//       ),
//     );
//   }
// }
