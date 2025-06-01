import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/nav/exports.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/register-screen';

  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: context.theme.bgColor,
      body: Container(
        height: size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/hapz_logo.png"),
                  width: 125,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    // color: context.theme.titleTextColor,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      InputField(
                        labelText: 'Username',
                        icon: Icon(Icons.person),
                        controller: _usernameController,
                      ),
                      InputField(
                        labelText: 'First Name',
                        icon: Icon(Icons.switch_account),
                        controller: _firstNameController,
                      ),
                      InputField(
                        labelText: 'Last Name',
                        icon: const Icon(Icons.switch_account),
                        controller: _lastNameController,
                      ),
                      // InputField(
                      //   labelText: 'Email address',
                      //   icon: Icon(Icons.mail),
                      //   controller: _emailController,
                      // ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        // onSaved: ,
                        validator: (input) =>
                        input!.contains("@") ? "Email should be valid" : null,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey[750],
                          ),
                        ),
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
                              color: Colors.grey.withOpacity(0.5),
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            )),
                      ),
                      // InputField(
                      //   labelText: 'Password',
                      //   icon: Icon(Icons.lock),
                      //   controller: _passwordController,
                      //   isObscure: true,
                      // ),
                      const SizedBox(height: 35.0),
                      SizedBox(
                        width: size.width * 0.75,
                        child: CustomButton(
                          onPressed: () {
                            print('Create account button clicked');
                            submitData();
                          },
                          text: 'Create Account',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an Account?',
                      style: TextStyle(
                        fontSize: 12,
                        // color: context.theme.primaryColor,
                      ),
                    ),
                    SizedBox(width: 60.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn()));
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 12,
                          // color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitData() async {
    try {
      const apiUrl = 'https://test-backend-1ok0.onrender.com/social_backend/user/register';
      // const apiUrl = 'https://test-backend-0dhd.onrender.com/social_backend/user/register';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userName': _usernameController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        print('Registration successful');
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
      } else {
        print('Registration failed');
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
          ),
        );
      }
    } catch (error) {
      print('Error during registration: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred during registration. Please try again later.'),
        ),
      );
    }
  }
}

// https://restapi.adequateshop.com/api   https://fiverr-shahadapp.000webhostapp.com/api/register