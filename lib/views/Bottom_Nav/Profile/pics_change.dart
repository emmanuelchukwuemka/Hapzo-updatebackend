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
  String? selectedBgImage;
  String? selectedProfileImage;
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
                  setState(() {
                    selectedProfileImage = image.path;
                  });
                } else {
                  widget.onchangeCoverPhoto(File(image.path));
                  setState(() {
                    selectedBgImage = image.path;
                  });
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
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppshadowContainer(
              onTap: () {
                showOptionsDialog(context, false);
              },
              height: size.height * 0.15,
              width: size.width,
              child: selectedBgImage != null
                  ? Image.file(File(selectedBgImage!),
                      width: size.width, fit: BoxFit.cover)
                  : Image.asset("assets/images/landscape3.jpg",
                      fit: BoxFit.cover, width: size.width)),
          Positioned(
            bottom: -20,
            child: GestureDetector(
                onTap: () {
                  return showOptionsDialog(context, true);
                },
                child: Stack(children: [
                  selectedProfileImage != null
                      ? AppshadowContainer(
                          radius: size.width * 0.1,
                          color: Colors.transparent,
                          border: true,
                          borderWidth: 3,
                          borderColor: Theme.of(context).primaryColor,
                          child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(
                                  size.width * 0.1),
                              child: Image.file(File(selectedProfileImage!),
                                  height: 80, width: 80, fit: BoxFit.cover)))
                      : const AppNetwokImage(
                          height: 80,
                          width: 80,
                          radius: 200,
                          imageUrl:
                              "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?semt=ais_hybrid&w=740&q=80",
                          fit: BoxFit.cover),
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(Icons.camera_alt_outlined,
                          color: Colors.deepOrange))
                ])),
          ),
        ],
      ),
    );
  }
}
