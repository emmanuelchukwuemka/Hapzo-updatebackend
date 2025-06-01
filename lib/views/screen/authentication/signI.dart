import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/services/base_client.dart';

class SignI extends StatefulWidget {
  const SignI({super.key});

  @override
  State<SignI> createState() => _SignIState();
}

class _SignIState extends State<SignI> {
  bool hidePassword = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
      body: Container(
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
                      labelText: 'Email',
                      icon: Icon(Icons.mail),
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
                          color: Colors.grey.withOpacity(0.65),
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
                      child: CustomButton(
                        onPressed: () async {
                          // authController.loginUser(_emailController.text, _passwordController.text,);
                          print('Log in button pressed');
                          try {
                            const apiUrl = 'https://test-backend-1ok0.onrender.com/social_backend/user/login';
                            // const apiUrl = 'https://test-backend-0dhd.onrender.com/social_backend/user/login';
                            var response2 = await http.post(
                              Uri.parse(apiUrl),
                              body: {
                                'email': _emailController.text,
                                'password': _passwordController.text,
                              },
                            );

                            if (response2.statusCode == 200) {
                              debugPrint('Login successful');
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
                            } else {
                              // Login failed
                              print('Login failed');
                              print(response2.body);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login failed. Please try again.')),
                              );
                            }
                          } catch (error) {
                            print('Error during login: $error');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('An error occurred during login. Please try again later.')),
                            );
                          }
                        },
                        text: 'Log in',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        print('Forgot password button clicked');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignI())
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
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: size.width * 0.75,
                      child: CustomButton(
                        onPressed: () async {
                          print("Test api button clicked");
                          var response2 = await BaseClient().get('https://jsonplaceholder.typicode.com/posts').catchError((err) {});

                          if (response2.statusCode == null) {
                            debugPrint('Null data');
                          }
                          debugPrint('Successful');

                          var posts = postsFromJson(response2);
                          debugPrint('Posts count: ${posts.length}');
                          // debugPrint('Posts count: ' + posts.length.toString());
                        },
                        text: 'Test api',
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
                    SizedBox(width: 55.0),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignUp())),
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
