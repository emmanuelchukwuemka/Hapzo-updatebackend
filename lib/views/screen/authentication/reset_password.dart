import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/extensions.dart';
import 'package:haptext_api/views/screen/authentication/forget_password.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchAuth = context.watch<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordSucess) {
          context.go(RouteName.resetPaswordSuccess.path);
        }
      },
      child: AbsorbPointer(
        absorbing: watchAuth.state is AuthLoadingState,
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: [
                    20.verticalSpace,
                    Row(children: [
                      const AppBackButton(),
                      10.horizontalSpace,
                      const AppText(
                          text: "Set New Password",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white)
                    ]),
                    30.verticalSpace,
                    const AppText(
                        text:
                            "Create a new password. Make sure it's strong and unique to keep your account secure.",
                        color: Colors.white,
                        maxLines: 3),
                    Expanded(
                        child: ListView(
                      children: [
                        30.verticalSpace,
                        InputField(
                            prefix: Icon(Icons.lock_outline, size: 20.sp),
                            hintText: "New Passswors",
                            validator: (p0) => p0?.validatePassword(),
                            controller: watchAuth.passwordController),
                        20.verticalSpace,
                        InputField(
                            prefix: Icon(Icons.lock_outline, size: 20.sp),
                            hintText: "Confirm Password",
                            validator: (p0) => (watchAuth.confirmPasword.text ==
                                    watchAuth.passwordController.text)
                                ? null
                                : "Password Mismatch",
                            controller: watchAuth.confirmPasword),
                        100.verticalSpace,
                        Appbutton(
                          isLoading: watchAuth.state is AuthLoadingState,
                          label: "Continue",
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().resetPassword();
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
        ),
      ),
    );
  }
}
