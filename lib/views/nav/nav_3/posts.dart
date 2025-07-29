// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/exports.dart';
import 'package:image_picker/image_picker.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';
import '../../../models/new/posts_data.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  late PlatformFile pickedFile;
  String? thumbnailUrl;
  File? videoFile;

  // showOptionsDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => SimpleDialog(
  //             children: [
  //               SimpleDialogOption(
  //                 onPressed: () => pickVideo(ImageSource.camera, context),
  //                 child: const Row(
  //                   children: [
  //                     Icon(Icons.camera_alt),
  //                     Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Text(
  //                         'Camera',
  //                         style: TextStyle(
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SimpleDialogOption(
  //                 onPressed: () => pickVideo(ImageSource.gallery, context),
  //                 child: const Row(
  //                   children: [
  //                     Icon(Icons.image),
  //                     Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Text(
  //                         'Gallery',
  //                         style: TextStyle(
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SimpleDialogOption(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 child: const Row(
  //                   children: [
  //                     Icon(Icons.cancel),
  //                     Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Text(
  //                         'Cancel',
  //                         style: TextStyle(
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ));
  // }

  Future _selectVideoFile() async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    context.push(RouteName.confirmVideoUpload.path, extra: File(file!.path));
  }

  Future _selectPhoto() async {
    debugPrint('Clicked Photo');
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      debugPrint('Image Selected');
      setState(() {
        pickedFile = result.files.first;
      });
      context.push(RouteName.confirmImageUpload.path,
          extra: result.files.first);

      // LOAD RESULT AND FILE DETAILS
      // pickedFile = result.files.first;
      debugPrint('Name: ${pickedFile.name}');
      debugPrint('Bytes: ${pickedFile.bytes}');
      debugPrint('Size: ${pickedFile.size}');
      debugPrint('Extension: ${pickedFile.extension}');
      debugPrint('Path: ${pickedFile.path}');
    } else {
      debugPrint('Image selecting failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: context.theme.primaryColor,
        ),
        backgroundColor: context.theme.appBarColor,
        title: AppText(
            text: 'Create Post',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: context.theme.titleTextColor),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildPostsContainer(() {
                context.push(RouteName.createTextPostPage.path);
              }, choice[0].col, choice[0].desc, choice[0].icon),
              buildPostsContainer(() {
                context.push(RouteName.audioUploadPage.path);
              }, choice[1].col, choice[1].desc, choice[1].icon),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildPostsContainer(
                  //selectPhoto,
                  _selectPhoto,
                  choice[2].col,
                  choice[2].desc,
                  choice[2].icon),
              buildPostsContainer(
                  //selectVideo,
                  _selectVideoFile,
                  choice[3].col,
                  choice[3].desc,
                  choice[3].icon),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPostsContainer(
      Function() click, List<Color> color, String desc, IconData icon) {
    return InkWell(
      onTap: click,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.475,
        height: MediaQuery.of(context).size.height * 0.370,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: color,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Icon(icon, color: Colors.black),
              ),
              const SizedBox(height: 10),
              AppText(text: desc, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
