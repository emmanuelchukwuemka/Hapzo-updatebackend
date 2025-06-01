import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/services/auth_service.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/login-screen';

  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isLoggingIn = false;

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: isLoggingIn
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          // USERNAME OR EMAIL TEXT INPUT
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            // onSaved: ,
                            validator: (input) =>
                            input!.contains("@") ? null : "Email should be valid",
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange.withOpacity(0.4)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)
                              ),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          //PASSWORD TEXT INPUT
                          TextFormField(
                            controller: controller.passwordController,
                            keyboardType: TextInputType.text,
                            // onSaved: ,
                            validator: (input) => input!.length < 6
                                ? "Invalid password"
                                : null,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange.withOpacity(0.4))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.orange,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Colors.orange.withOpacity(0.5),
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          ElevatedButton(
                            onPressed: () {
                              controller;
                              if(_formKey.currentState!.validate()) {
                                // submitData;
                                print('Login button clicked');
                                setState(() {
                                  isLoggingIn = true;
                                  controller.loginWithEmail();
                                  isLoggingIn = false;
                                });
                              } else {
                                return;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: const StadiumBorder(),
                            ),
                            child: Obx(
                              () => controller.isLoading
                                  ? const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    ),
                                  )
                              : const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Forgot password button clicked');
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignUp())
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 12,
                        // color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
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
                        onTap: () => Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Register())),
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
    );
  }
}
