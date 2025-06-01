// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// // import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   PlatformFile? pickedFile;
//   UploadTask? uploadTask;
//   String? thumbnailUrl;
//
//   Future uploadFile() async {
//     final path = 'files/${pickedFile!.name}';
//     final file = File(pickedFile!.path!);
//
//     final ref = FirebaseStorage.instance.ref().child(path);
//     setState(() {
//       uploadTask = ref.putFile(file);
//     });
//
//     final snapshot = await uploadTask!.whenComplete(() {});
//
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     print('Download Link: $urlDownload');
//
//     setState(() {
//       uploadTask = null;
//     });
//   }
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result == null) return;
//
//     setState(() {
//       pickedFile = result.files.first;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PROFILE'),
//       ),
//       body: Center(
//         child: Container(
//           child: Column(
//             children: [
//               Image.file(
//                 File(pickedFile!.path!),
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               Text(pickedFile!.name),
//               // InkWell(
//               //   onTap: () {},
//               //   child: Container(
//               //     width: MediaQuery.of(context).size.width * 0.475,
//               //     height: MediaQuery.of(context).size.height * 0.370,
//               //     decoration: BoxDecoration(
//               //         gradient: LinearGradient(
//               //             colors: color,
//               //             begin: Alignment.topLeft,
//               //             end: Alignment.bottomRight
//               //         ),
//               //         borderRadius: BorderRadius.circular(12)
//               //     ),
//               //     child: Center(
//               //         child: Column(
//               //           mainAxisAlignment: MainAxisAlignment.center,
//               //           children: [
//               //             Container(
//               //               height: 60,
//               //               width: 60,
//               //               decoration: BoxDecoration(
//               //                   color: Colors.white,
//               //                   borderRadius: BorderRadius.circular(30)
//               //               ),
//               //               child: Icon(
//               //                 icon,
//               //                 color: Colors.black,
//               //               ),
//               //             ),
//               //             SizedBox(height: 10),
//               //             Text(
//               //               desc,
//               //               style: const TextStyle(
//               //                   color: Colors.white
//               //               ),
//               //             )
//               //           ],
//               //         )
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
