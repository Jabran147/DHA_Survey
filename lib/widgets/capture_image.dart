// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CaptureImage extends StatefulWidget {
//   const CaptureImage({super.key});

//   @override
//   State<CaptureImage> createState() => _CaptureImageState();
// }

// class _CaptureImageState extends State<CaptureImage> {
//   File? imageFile;
//   final picker = ImagePicker();

//   Future<void> captureImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() => imageFile = File(pickedFile.path));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () async => captureImage(),
//               child: const Text('Take Picture'),
//             ),
//             if (this.imageFile == null)
//               const Placeholder()
//             else
//               Image.file(this.imageFile!),
//           ],
//         ),
//       ),
//     );
//   }
// }
