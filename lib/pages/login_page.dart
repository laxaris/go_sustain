import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginPage({super.key});

  void _login(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Login successful, navigate to home page
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      // Handle login error
      print('Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context)
          .primaryColor, // Set your background color in main.dart
      body: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, right: 24.0, top: 60.0, bottom: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Login',
                    style: Theme.of(context).primaryTextTheme.displayLarge),
                SizedBox(height: 20 * h),
                GestureDetector(
                  onTap: () {
                    _login(context, "basrihasan6435@gmail.com", "123456");
                  },
                  child: Image.asset(
                    'lib/images/image_2-removebg-preview.png',
                    height: 330 * h,
                    width: 447 * w,
                  ),
                ),
                SizedBox(height: 20 * h),

                // Email Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25 * w),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20 * h),

                // Password Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25 * w),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30 * h),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.white,
                    minimumSize: Size(207 * w, 66 * h), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to home screen

                    _login(
                        context, emailController.text, passwordController.text);
                  },
                  child: Text('Login',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32 * w)),
                ),

                SizedBox(height: 20 * h),

                // Sign Up and Forgot Password links
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: RichText(
                      text: TextSpan(
                          style:
                              TextStyle(color: Colors.white, fontSize: 20 * w),
                          children: const <TextSpan>[
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    )),
                TextButton(
                  onPressed: () {
                    // Navigate to forgot password screen
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 20 * w),
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
