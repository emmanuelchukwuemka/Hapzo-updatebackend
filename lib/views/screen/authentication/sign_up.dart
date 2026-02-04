import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/extensions.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  bool hidePassword1 = true;
  bool hidePassword2 = true;

  @override
  Widget build(BuildContext context) {
    final watchAuth = context.watch<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterState) {
          context.go(RouteName.otpScreen.path);
        }
      },
      child: AbsorbPointer(
        absorbing: watchAuth.state is AuthLoadingState,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                const Image(
                  image: AssetImage("assets/images/hapz_logo.png"),
                  width: 125,
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    // color: context.theme.titleTextColor,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        InputField(
                          controller: watchAuth.usernameController,
                          keyboardType: TextInputType.text,
                          hintText: 'Username',
                          prefix:
                              const Icon(Icons.person, color: Colors.orange),
                        ),
                        const SizedBox(height: 20),
                        InputField(
                            controller: watchAuth.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (input) => input?.validateEmail(),
                            hintText: 'Email Address',
                            prefix:
                                const Icon(Icons.email, color: Colors.orange)),
                        const SizedBox(height: 20),
                        InputField(
                          controller: watchAuth.passwordController,
                          keyboardType: TextInputType.text,
                          validator: (input) => input?.validatePassword(),
                          isPassword: hidePassword1,
                          hintText: 'Password',
                          prefix: const Icon(
                            Icons.lock,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          controller: watchAuth.passwordConfirmController,
                          keyboardType: TextInputType.text,
                          // onSaved: ,

                          validator: (input) =>
                              input! != watchAuth.passwordController.text
                                  ? "Password Mismatch"
                                  : null,
                          isPassword: hidePassword2,

                          prefix: const Icon(Icons.lock, color: Colors.orange),
                        ),
                        const SizedBox(height: 30.0),
                        Appbutton(
                          label: "Sign up",
                          // isLoading: watchAuth.state is AuthLoadingState,
                          onTap: () {
                            // if (_formKey.currentState?.validate() ?? false) {
                            //   watchAuth.registerUser();
                            // }
                            context.go(RouteName.bottomNav.path);
                          },
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppText(
                                text: 'Already have an Account? ',
                                color: Colors.white),
                            GestureDetector(
                                onTap: () => context.push(RouteName.login.path),
                                child: const AppText(
                                    text: 'Sign In', color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
