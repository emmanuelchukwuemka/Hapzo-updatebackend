import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/config/page_route/route_name.dart';
import 'package:haptext_api/exports.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final watchAuth = context.watch<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthEmailVerifiedState) {
          context.go(RouteName.bottomNav.path);
        }
      },
      child: AbsorbPointer(
        absorbing: watchAuth.state is AuthLoadingState,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35.0),
                  const Icon(Icons.close, size: 25),
                  const SizedBox(height: 20.0),
                  const AppText(
                      text: "Email Verify",
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  const SizedBox(height: 35.0),
                  AppText(
                      text:
                          "We've sent a verification code to your email\n${watchAuth.emailController.text}",
                      color: Colors.white),
                  const SizedBox(height: 30.0),
                  const AppText(
                      text: "Please enter otp to continue",
                      fontSize: 12,
                      color: Colors.white),
                  const SizedBox(height: 35.0),
                  Expanded(
                      child: ListView(
                    children: [
                      Center(
                        child: PinCodeTextField(
                          autofocus: true,
                          controller: watchAuth.otpController,
                          keyboardType: TextInputType.number,
                          hideCharacter: false,
                          highlight: true,
                          highlightColor: Colors.orange,
                          pinBoxRadius: 1,
                          pinBoxWidth: 40,
                          pinBoxHeight: 50,
                          pinBoxColor: Colors.transparent,
                          defaultBorderColor: Colors.black,
                          hasTextBorderColor: Colors.orange,
                          maxLength: 6,
                          hasError: false,
                          pinTextStyle:
                              GoogleFonts.itim(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 35.0),
                      Appbutton(
                        isLoading: watchAuth.state is AuthLoadingState,
                        label: "Confirm",
                        onTap: () {
                          context.read<AuthCubit>().verifyEmail();
                        },
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
