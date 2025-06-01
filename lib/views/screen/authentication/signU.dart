import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';

class Register extends StatefulWidget {
  static const routeName = '/register-screen';
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool hidePassword1 = true;
  bool hidePassword2 = true;

  RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controller.usernameController,
                      keyboardType: TextInputType.text,
                      // onSaved: ,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange.withOpacity(0.4))),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      // onSaved: ,
                      validator: (input) =>
                      input!.contains("@") ? null : "Email should be valid",
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange.withOpacity(0.4))),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.password1Controller,
                      keyboardType: TextInputType.text,
                      // onSaved: ,
                      // validator: (input) => input!.length < 6
                      //     ? "Password should be more than 6 characters"
                      //     : null,
                      obscureText: hidePassword1,
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
                                hidePassword1 = !hidePassword1;
                              });
                            },
                            color: Colors.orange.withOpacity(0.5),
                            icon: Icon(
                              hidePassword1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.password2Controller,
                      keyboardType: TextInputType.text,
                      // onSaved: ,
                      // validator: (input) => input!.length < 6
                      //     ? "Password should be more than 6 characters"
                      //     : null,
                      obscureText: hidePassword2,
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
                                hidePassword2 = !hidePassword2;
                              });
                            },
                            color: Colors.orange.withOpacity(0.5),
                            icon: Icon(
                              hidePassword2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an Account?',
                          style: TextStyle(
                            fontSize: 12,
                            // color: context.theme.buttonColor,
                          ),
                        ),
                        const SizedBox(width: 60.0),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context, MaterialPageRoute(builder: (_) => SignIn())),
                          // navigateToSignUpScreen(context),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 12,
                              // color: context.theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller;
                        if(_formKey.currentState!.validate()) {
                          // submitData;
                          print('Registration button clicked');
                          controller.registerWithEmail();
                        } else {
                          return;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: const StadiumBorder(),
                      ),
                      child: Obx(
                            () => controller.isLoading ? const Center(child: CircularProgressIndicator(),)
                            : const Text(
                          'Register',
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
          ],
        ),
      ),
    );
  }
}
