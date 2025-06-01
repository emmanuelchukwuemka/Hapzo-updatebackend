import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class ConfirmImageUpload extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  final PlatformFile pickedFile;

  const ConfirmImageUpload(
      {Key? key, required this.videoFile, required this.videoPath, required this.pickedFile})
      : super(key: key);

  @override
  State<ConfirmImageUpload> createState() => _ConfirmImageUploadState();
}

class _ConfirmImageUploadState extends State<ConfirmImageUpload> {
  // UploadTask? uploadTask;

  Future uploadFile() async {
    // final path = 'files/${widget.pickedFile.name}';
    // final file = File(widget.pickedFile.path!);
    //
    // final ref = FirebaseStorage.instance.ref().child(path);
    // setState(() {
    //   uploadTask = ref.putFile(file);
    // });
    //
    // final snapshot = await uploadTask!.whenComplete(() {});
    //
    // final urlDownload = await snapshot.ref.getDownloadURL();
    // print('Download Link: $urlDownload');
    //
    // setState(() {
    //   uploadTask = null;
    // });
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  // UploadVideoController uploadVideoController = Get.put(UploadVideoController());

  // @override
  // void initState() {
  //   super.initState();
  //   controller = VideoPlayerController.file(widget.videoFile);
  //   controller.initialize().then((value) {
  //     setState(() {});
  //     controller.play();
  //     controller.setVolume(1);
  //     controller.setLooping(false);
  //   });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    //   stream: uploadTask?.snapshotEvents,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       final data = snapshot.data!;
    //       double progress = data.bytesTransferred / data.totalBytes;
    //       return SizedBox(
    //         height: 50,
    //         child: Stack(
    //           fit: StackFit.expand,
    //           children: [
    //             LinearProgressIndicator(
    //               value: progress,
    //               backgroundColor: Colors.grey,
    //               color: Colors.orange,
    //             ),
    //             Center(
    //                 child: Text(
    //                   '${(100 * progress).roundToDouble()}%',
    //                   style: TextStyle(color: Colors.white),
    //
    //                 )
    //             )
    //           ],
    //         ),
    //       );
    //     } else {
    //       return const SizedBox(height: 50);
    //     }
    //   },
    // );

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Image.file(
                  File(widget.pickedFile.path!),
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.contain,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.text_fields_sharp, color: Colors.white, size: 22),
                      SizedBox(height: 10),
                      Text(
                        'Text',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 20),
                      Icon(Icons.emoji_emotions_outlined, color: Colors.white, size: 22),
                      SizedBox(height: 10),
                      Text(
                        'Emoji',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 20),
                      Icon(Icons.access_alarms_rounded, color: Colors.white, size: 22),
                      SizedBox(height: 10),
                      Text(
                        'Schedule\nTime',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 20),
                      Icon(Icons.person_add, color: Colors.white, size: 22),
                      SizedBox(height: 10),
                      Text(
                        'Tag\npeople',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      // Icon(Icons.add_business_rounded, color: Colors.white),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.symmetric(horizontal: 15),
              //         width: MediaQuery.of(context).size.width - 30,
              //         child: TextInputField(
              //           controller: _titleController,
              //           labelText: 'Title',
              //           icon: Icons.mode_edit_outline_sharp,
              //         ),
              //       ),
              //       const SizedBox(height: 7.0),
              //       Container(
              //         margin: const EdgeInsets.symmetric(horizontal: 15),
              //         width: MediaQuery.of(context).size.width - 20,
              //         child: TextInputField(
              //           controller: _captionController,
              //           labelText: 'Caption',
              //           icon: Icons.closed_caption,
              //         ),
              //       ),
              //       const SizedBox(height: 7.0),
              //       ElevatedButton(
              //         // onPressed: uploadFile,
              //         onPressed: uploadFile,
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Color(0xFFFD8502),
              //           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
              //         ),
              //         child: const Text(
              //           'Upload',
              //           style: TextStyle(fontSize: 20, color: Colors.white,),
              //         ),
              //       ),
              //       const SizedBox(height: 7.0),
              //       buildProgress(),
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
