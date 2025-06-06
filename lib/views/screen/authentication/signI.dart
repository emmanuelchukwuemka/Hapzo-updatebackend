import 'package:haptext_api/exports.dart';

class SignI extends StatefulWidget {
  const SignI({super.key});

  @override
  State<SignI> createState() => _SignIState();
}

class _SignIState extends State<SignI> {
  bool hidePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose;
    _passwordController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: context.theme.bgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(children: [
                    InputField(
                      // labelText: 'Email',
                      // icon: const Icon(Icons.mail),
                      controller: _emailController,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      // onSaved: ,
                      validator: (input) => input!.length < 6
                          ? "Password should be more than 6 characters"
                          : null,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey[750],
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          color: Colors.grey.withValues(alpha: 0.65),
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    // InputField(
                    //   labelText: 'Password',
                    //   icon: Icon(Icons.lock),
                    //   controller: _passwordController,
                    //   isObscure: true,
                    // ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      width: size.width * 0.75,
                      child: Appbutton(
                        onTap: () async {},
                        label: 'Log in',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const SignI()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 12,
                          // color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: size.width * 0.75,
                      child: Appbutton(
                        onTap: () async {},
                        label: 'Test api',
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an Account?',
                      style: TextStyle(
                        fontSize: 12,
                        // color: context.theme.buttonColor,
                      ),
                    ),
                    const SizedBox(width: 55.0),
                    GestureDetector(
                      // onTap: () => Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => const SignUp())),
                      // navigateToSignUpScreen(context),
                      child: const Text(
                        'Join Now',
                        style: TextStyle(
                          fontSize: 12,
                          // color: context.theme.primaryColor,
                        ),
                      ),
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
