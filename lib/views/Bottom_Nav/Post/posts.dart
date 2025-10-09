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
              buildPostsContainer(() {
                context.push(RouteName.createPhotoPost.path);
              }, choice[2].col, choice[2].desc, choice[2].icon),
              buildPostsContainer(
                  //selectVideo,
                  () {
                context.push(RouteName.confirmVideoUpload.path);
              }, choice[3].col, choice[3].desc, choice[3].icon),
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
