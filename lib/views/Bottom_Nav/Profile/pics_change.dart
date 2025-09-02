// ignore_for_file: void_checks
import 'dart:io';

import 'package:haptext_api/exports.dart';
import 'package:image_picker/image_picker.dart';

class PicsChange extends StatefulWidget {
  const PicsChange(
      {super.key,
      required this.onchangeProfile,
      required this.onchangeCoverPhoto});
  final Function(File profile) onchangeProfile, onchangeCoverPhoto;
  @override
  State<PicsChange> createState() => _PicsChangeState();
}

class _PicsChangeState extends State<PicsChange> {
  showOptionsDialog(BuildContext context, bool profile) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              final ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                if (profile) {
                  widget.onchangeProfile(File(image.path));
                } else {
                  widget.onchangeCoverPhoto(File(image.path));
                }
              }
            },
            child: const Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 10.0),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppText(
                      text: 'Change', color: Colors.white, fontSize: 15.0),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 10.0),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AppText(
                        text: 'Cancel', color: Colors.white, fontSize: 15.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                return showOptionsDialog(context, true);
              },
              child: const Stack(children: [
                AppNetwokImage(
                    height: 80,
                    width: 80,
                    radius: 200,
                    imageUrl:
                        "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?semt=ais_hybrid&w=740&q=80",
                    fit: BoxFit.cover),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(Icons.camera_alt_outlined,
                        color: Colors.deepOrange))
              ])),
          const SizedBox(width: 70),
          InkWell(
              onTap: () {
                showOptionsDialog(context, true);
              },
              child: const Stack(children: [
                AppshadowContainer(
                    height: 80,
                    width: 80,
                    radius: 50,
                    image: DecorationImage(
                        image: AssetImage('assets/images/landscape3.jpg'),
                        fit: BoxFit.cover)),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(Icons.camera_alt_outlined,
                        color: Colors.deepOrange))
              ]))
        ],
      ),
    );
  }
}
