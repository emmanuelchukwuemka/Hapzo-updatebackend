import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'A verification link has been sent to your email, click the link to verify!',
              ),
              const SizedBox(height: 35.0),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Get.to(() => SignIn());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: const StadiumBorder(),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Back to Login',),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
