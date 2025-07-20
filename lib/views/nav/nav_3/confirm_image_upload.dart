import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class ConfirmImageUpload extends StatelessWidget {
  // final File videoFile;
  // final String videoPath;
  final PlatformFile pickedFile;

  const ConfirmImageUpload(
      {Key? key,
      // required this.videoFile,
      // required this.videoPath,
      required this.pickedFile})
      : super(key: key);

  // UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
    final watchHome=context.watch<HomeCubit>();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.file(
                  File(pickedFile.path!),
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.contain,
                ),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Container(
              //     margin: const EdgeInsets.only(right: 10),
              //     child: const Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Icon(Icons.text_fields_sharp,
              //             color: Colors.white, size: 22),
              //         SizedBox(height: 10),
              //         Text(
              //           'Text',
              //           style: TextStyle(color: Colors.white, fontSize: 12),
              //         ),
              //         SizedBox(height: 20),
              //         Icon(Icons.emoji_emotions_outlined,
              //             color: Colors.white, size: 22),
              //         SizedBox(height: 10),
              //         Text(
              //           'Emoji',
              //           style: TextStyle(color: Colors.white, fontSize: 12),
              //         ),
              //         SizedBox(height: 20),
              //         Icon(Icons.access_alarms_rounded,
              //             color: Colors.white, size: 22),
              //         SizedBox(height: 10),
              //         Text(
              //           'Schedule\nTime',
              //           textAlign: TextAlign.right,
              //           style: TextStyle(color: Colors.white, fontSize: 12),
              //         ),
              //         SizedBox(height: 20),
              //         Icon(Icons.person_add, color: Colors.white, size: 22),
              //         SizedBox(height: 10),
              //         Text(
              //           'Tag\npeople',
              //           textAlign: TextAlign.right,
              //           style: TextStyle(color: Colors.white, fontSize: 12),
              //         ),
              // Icon(Icons.add_business_rounded, color: Colors.white),
              //         const SizedBox(height: 20),
              //       ],
              //     ),
              //   ),
              // ),
              30.verticalSpace,
              Appbutton(isLoading: watchHome.state is HomeLoading,
                label: "Confirm",
                onTap: () {
                  context
                      .read<HomeCubit>()
                      .createImagePost(image: File(pickedFile.path!));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
