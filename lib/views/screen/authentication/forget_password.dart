import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/exports.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchAuth = context.watch<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordOtpState) {
          context.go(RouteName.resetPasswordOtpPage.path);
        }
      },
      child: AbsorbPointer(
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
                        text: "Forget Password?",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white)
                  ]),
                  30.verticalSpace,
                  const AppText(
                      text:
                          "Enter your registered email , and we'll send you a OTP to reset your password",
                      color: Colors.white,
                      maxLines: 3),
                  Expanded(
                      child: ListView(
                    children: [
                      20.verticalSpace,
                      InputField(
                          prefix: Icon(Icons.email_outlined, size: 20.sp),
                          hintText: "Email Address",
                          controller: watchAuth.emailController),
                      100.verticalSpace,
                      Appbutton(
                        isLoading: watchAuth.state is AuthLoadingState,
                        label: "Continue",
                        onTap: () {
                          context.read<AuthCubit>().requestPasswordReset();
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

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Icon(Icons.arrow_back, size: 20.sp));
  }
}
