// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'package:main_hapztext/controllers/exports.dart';

// class SourcePage extends StatefulWidget {
//   const SourcePage({Key? key}) : super(key: key);
//
//   @override
//   State<SourcePage> createState() => _SourcePageState();
// }
//
// class _SourcePageState extends State<SourcePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.5,
//           width: MediaQuery.of(context).size.width * 0.5,
//           decoration: BoxDecoration(
//             color: Colors.black45
//           ),
//           child: Column(
//             children: [
//               CameraButtonWidget(),
//               GalleryButtonWidget(),
//               Row(
//                 children: [
//                   IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
//                   SizedBox(width: 10),
//                   Text('From Camera')
//                 ],
//               ),
//               SizedBox(height: 15.0),
//               Row(
//                 children: [
//                   IconButton(onPressed: () {}, icon: Icon(Icons.image_rounded)),
//                   SizedBox(width: 10),
//                   Text('From Gallery')
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:io';
// // import 'package:get/get.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// // import 'package:file_picker/file_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:main_hapztext/controllers/exports.dart';
//
// class ConfirmVideoUpload extends StatefulWidget {
//   final File? videoFile;
//   // final String videoPath;
//   // final PlatformFile pickedFile;
//   final String url;
//   final DataSourceType dataSourceType;
//
//   const ConfirmVideoUpload(
//     {Key? key,
//       required this.videoFile,
//       // required this.videoPath,
//       // required this.pickedFile,
//       required this.url,
//       required this.dataSourceType
//     })
//     : super(key: key);
//
//   @override
//   State<ConfirmVideoUpload> createState() => _ConfirmVideoUploadState();
// }
//
// class _ConfirmVideoUploadState extends State<ConfirmVideoUpload> {
//   // late VideoPlayerController controller;
//   late ChewieController _chewieController;
//   late VideoPlayerController _videoPlayerController;
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _captionController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     switch (widget.dataSourceType) {
//       case DataSourceType.asset:
//         _videoPlayerController = VideoPlayerController.asset(widget.url);
//         break;
//       case DataSourceType.network:
//         _videoPlayerController = VideoPlayerController.network(widget.url);
//         break;
//       case DataSourceType.file:
//         _videoPlayerController = VideoPlayerController.file(File(widget.url));
//         break;
//       case DataSourceType.contentUri:
//         _videoPlayerController = VideoPlayerController.contentUri(Uri.parse(widget.url));
//         break;
//     }
//
//     _videoPlayerController.initialize().then(
//       (_) => setState(
//         () => _chewieController = ChewieController(
//           videoPlayerController: _videoPlayerController,
//           aspectRatio: _videoPlayerController.value.aspectRatio,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
//
//   UploadTask? uploadTask;
//
//   Future uploadFile() async {
//     final path = 'files/${widget.videoFile}';
//     final file = File(widget.url);
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
//   @override
//   Widget build(BuildContext context) {
//     Widget buildProgress() => StreamBuilder<TaskSnapshot>(
//       stream: uploadTask?.snapshotEvents,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final data = snapshot.data!;
//           double progress = data.bytesTransferred / data.totalBytes;
//
//           return SizedBox(
//             height: 50,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 LinearProgressIndicator(
//                   value: progress,
//                   backgroundColor: Colors.grey,
//                   color: Colors.orange,
//                 ),
//                 Center(
//                   child: Text(
//                     '${(100 * progress).roundToDouble()}%',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 )
//               ],
//             ),
//           );
//         } else {
//           return const SizedBox(height: 50);
//         }
//       },
//     );
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Container(
//               //   height: 30,
//               //   width: double.infinity,
//               //   margin: const EdgeInsets.symmetric(horizontal: 15),
//               //   color: Colors.orange,
//               //   child: Text(widget.pickedFile.name),
//               // ),
//               const SizedBox(height: 20),
//               _videoPlayerController.value.isInitialized
//                 ? AspectRatio(
//                   aspectRatio: _videoPlayerController.value.aspectRatio,
//                   child: Chewie(controller: _chewieController,),
//                 ) : const SizedBox.shrink(),
//               // VideoPlayerWidget(videoPath: widget.videoPath),
//               const SizedBox(height: 30),
//               SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 15),
//                       width: MediaQuery.of(context).size.width - 30,
//                       child: TextInputField(
//                         controller: _titleController,
//                         labelText: 'Title',
//                         icon: Icons.mode_edit_outline_sharp),
//                     ),
//                     const SizedBox(height: 7.0),
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 15),
//                       width: MediaQuery.of(context).size.width - 20,
//                       child: TextInputField(
//                           controller: _captionController,
//                           labelText: 'Caption',
//                           icon: Icons.closed_caption),
//                     ),
//                     const SizedBox(height: 7.0),
//                     ElevatedButton(
//                       onPressed: uploadFile,
//                       // onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFFFD8502),
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
//                       ),
//                       child: const Text(
//                         'Upload',
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 7.0),
//                     buildProgress(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }
