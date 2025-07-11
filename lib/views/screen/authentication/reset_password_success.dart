import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center, children: [
              AppshadowContainer(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  radius: 200.r,
                  color: Colors.greenAccent.withAlpha(50)),
              AppshadowContainer(
                  width: size.width * 0.25,
                  height: size.width * 0.25,
                  radius: 200.r,
                  color: Colors.greenAccent.withAlpha(150)),
              AppshadowContainer(
                  width: size.width * 0.2,
                  height: size.width * 0.2,
                  radius: 200.r,
                  color: Colors.greenAccent,
                  child: Icon(Icons.done, size: 40.sp, color: Colors.white))
            ]),
            40.verticalSpace,
            const AppText(
                text:
                    "Your password has been updated successfully. Login to continue.",
                maxLines: 3,
                color: Colors.white),
            30.verticalSpace,
            Appbutton(
              onTap: () => context.go(RouteName.login.path),
              label: "Login"
            )
          ],
        ),
      )),
    );
  }
}
