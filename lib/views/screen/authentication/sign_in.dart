import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/config/page_route/route_name.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/extensions.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/login-screen';

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    final watchAuth = context.watch<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginState) {
          context.go(RouteName.bottomNav.path);
        }
      },
      child: AbsorbPointer(
        absorbing: watchAuth.state is AuthLoadingState,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const Image(
                  image: AssetImage("assets/images/hapz_logo.png"),
                  width: 125,
                ),
                const SizedBox(height: 30.0),
                const AppText(
                    text: 'Welcome Back!',
                    // color: context.theme.titleTextColor,
                    fontSize: 26.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // USERNAME OR EMAIL TEXT INPUT
                        InputField(
                            controller: watchAuth.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (input) => input?.validateEmail(),
                            hintText: 'Email Address',
                            prefix:
                                const Icon(Icons.email, color: Colors.orange)),
                        const SizedBox(height: 20),
                        //PASSWORD TEXT INPUT
                        InputField(
                          controller: watchAuth.passwordController,
                          keyboardType: TextInputType.text,

                          validator: (input) =>
                              input!.isEmpty ? "Invalid password" : null,
                          isPassword: hidePassword,
                          hintText: 'Password',
                          prefix: const Icon(Icons.lock, color: Colors.orange),
                          //  Icon(
                          //     hidePassword
                          //         ? Icons.visibility_off
                          //         : Icons.visibility,
                          //   ),
                        ),
                        const SizedBox(height: 20.0),
                        GestureDetector(
                            onTap: () {},
                            child: const Align(
                                alignment: Alignment.bottomRight,
                                child: AppText(
                                    text: 'Forgot Password?',
                                    fontSize: 12,
                                    color: Colors.white))),
                        const SizedBox(height: 60.0),
                        Appbutton(
                            isLoading: watchAuth.state is AuthLoadingState,
                            label: "Login",
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().loginUser();
                              }
                            })
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText(
                        text: 'Don\'t have an Account?  ',
                        color: Colors.white,
                        fontSize: 12),
                    GestureDetector(
                      onTap: () => context.push(RouteName.signUp.path),
                      child: const AppText(
                          text: 'Join Now', color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
