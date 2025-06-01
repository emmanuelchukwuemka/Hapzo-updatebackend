import 'package:flutter/material.dart';
import 'package:haptext_api/services/auth_service.dart';
import 'package:haptext_api/views/screen/home/home.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:haptext_api/views/screen/authentication/sign_in.dart';

import 'common/theme/dark_theme.dart';
import 'common/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hapztext',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: AuthServiceController().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return const Home();
          } else {
            return SignIn();
          }
        },
      )
      // SignIn(),
    );
  }
}
