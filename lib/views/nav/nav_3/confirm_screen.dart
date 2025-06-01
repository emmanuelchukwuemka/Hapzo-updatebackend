// import 'package:flutter/material.dart';
// import 'package:main_hapztext/test2.dart';
// import 'package:main_hapztext/exploreTab1.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   late List<Reference> references;
//
//   @override
//   void initState() {
//     super.initState();
//     _onUploadComplete();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Audio Upload'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               flex: 4,
//               child: references == null
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 40),
//                         child: LinearProgressIndicator(),
//                       ),
//                       Text('Fetching records from Firebase'),
//                     ],
//                   )
//                 : references.isEmpty
//                   ? Center(
//                       child: Text('No File uploaded yet'),
//                     )
//                   : CloudRecordListView(
//                       references: references
//                     ),
//             ),
//             Expanded(
//               flex: 2,
//               child: FeatureButtonsView(
//                 onUploadComplete: _onUploadComplete,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _onUploadComplete() async {
//     FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//     ListResult listResult = await firebaseStorage.ref().child('upload-voice-firebase').list();
//     setState(() {
//       references = listResult.items;
//     });
//   }
// }

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:main_hapztext/controllers/exports.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen({Key? key, required this.videoFile, required this.videoPath}) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _captionController = TextEditingController();
  // UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  
  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(false);
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: size.width,
                height: size.height * .6,
                child: VideoPlayer(controller),
              ),
              // VideoPlayerWidget(videoPath: widget.videoPath),
              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: size.width - 30,
                      // child: TextInputField(
                      //     controller: _titleController,
                      //     labelText: 'Title',
                      //     icon: Icons.mode_edit_outline_sharp),
                    ),
                    const SizedBox(height: 7.0),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: size.width - 20,
                      // child: TextInputField(
                      //     controller: _captionController,
                      //     labelText: 'Caption',
                      //     icon: Icons.closed_caption
                      //   ),
                    ),
                    const SizedBox(height: 7.0),
                    SizedBox(
                      width: size.width * 0.75,
                      // child: CustomButton(
                      //   onPressed: () {
                      //     print('Video Uploaded');
                      //     uploadVideoController.uploadVideo(_titleController.text, _captionController.text, widget.videoPath);
                      //   },
                      //   // onPressed: uploadFile;
                      //   text: 'Upload',
                      // ),
                    ),
                    const SizedBox(height: 7.0),
                    // buildProgress(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// E/ClearFileSource( 7325): Failed to open file 'widget.videoPath'. (No such file or directory)
// I/System.out( 7325): [okhttp]:check permission begin!
// I/System.out( 7325): [okhttp]:not MMS!
// I/System.out( 7325): [okhttp]:not Email!