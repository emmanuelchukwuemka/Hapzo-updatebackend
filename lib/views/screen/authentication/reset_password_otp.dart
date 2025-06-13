import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/screen/authentication/forget_password.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ResetPasswordOtpPage extends StatelessWidget {
  const ResetPasswordOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchAuth = context.watch<AuthCubit>();
    return AbsorbPointer(
      absorbing: watchAuth.state is AuthLoadingState,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              children: [
                20.verticalSpace,
                Row(children: [
                  const AppBackButton(),
                  10.horizontalSpace,
                  const AppText(
                      text: "Verification",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white)
                ]),
                30.verticalSpace,
                AppText(
                    text:
                        "Enter the 6-digit OTP sent to ${watchAuth.emailController.text} to reset your password",
                    color: Colors.white,
                    maxLines: 3),
                Expanded(
                    child: ListView(
                  children: [
                    40.verticalSpace,
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
                    30.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        context.read<AuthCubit>().requestPasswordReset();
                      },
                      child: const AppText(
                          text: "Resend Otp",
                          fontWeight: FontWeight.w600,
                          color: Colors.amber),
                    ),
                    100.verticalSpace,
                    Appbutton(
                      isLoading: watchAuth.state is AuthLoadingState,
                      label: "Confirm",
                      onTap: () {
                        if (context
                                .read<AuthCubit>()
                                .otpController
                                .text
                                .length ==
                            6) {
                          context.push(RouteName.resetPasswordPage.path);
                        }
                      },
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
