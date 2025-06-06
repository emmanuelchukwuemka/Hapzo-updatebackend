import 'package:flutter/material.dart';

import 'list_tile_widget.dart';

class CameraButtonWidget extends StatelessWidget {
  const CameraButtonWidget({super.key});

  @override
  Widget build(BuildContext context) => ListTileWidget(
      text: 'From Camera',
      icon: Icons.camera_alt,
      onClicked: () => pickCameraMedia(context));

  Future pickCameraMedia(BuildContext context) async {}
}
