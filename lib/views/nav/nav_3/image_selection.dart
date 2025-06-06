import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


Future selectPhoto() async {
  try {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.first;
      final compressedImage = await compressImage(pickedFile as File);

      // Validate image dimensions/format
      // if (await validateImageDimensions(compressedImage)) {
      //   // Navigator.push(
      //   //   context,
      //   //   MaterialPageRoute(builder: (_) => ConfirmImageUpload(
      //   //     imageFile: compressedImage,
      //   //     imagePath: compressedImage.path,
      //   //     pickedFile: compressedImage,
      //   //   )),
      //   // );
      // } else {
      //   debugPrint('Invalid image dimensions');
      // }
    } else {
      debugPrint('Image selecting cancelled');
    }
  } catch (e) {
    debugPrint('Image selecting failed: $e');
  }
}

// IMAGE COMPRESSION
Future<XFile?> compressImage(File image) async {
  final compressedImage = await FlutterImageCompress.compressAndGetFile(
    image.path,
    '${DateTime.now().millisecondsSinceEpoch}.jpg', // output path
    quality: 80, // 0-100
    minHeight: 600,
    minWidth: 600,
    rotate: 0,
  );
  return compressedImage;
}

// CAMERA INTEGRATION
Future<XFile?> captureImage() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.camera);
  return image;
}

// MULTIPLE IMAGE SELECTION
Future<List<File>?> selectMultipleImages() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: true,
  );
  return result?.files.map((file) => File(file.path!)).toList();
}

// DIMENSION/FORMAT VALIDATION
Future<bool> validateImageDimensions(File image) async {
  // final img.Image? decodedImage = img.decodeImage(await image.readAsBytes());
  // if (decodedImage != null) {
  //   final width = decodedImage.width;
  //   final height = decodedImage.height;
  //   // Validate dimensions (e.g., 600x600)
  //   if (width >= 600 && height >= 600) {
  //     return true;
  //   }
  // }
  return false;
}
