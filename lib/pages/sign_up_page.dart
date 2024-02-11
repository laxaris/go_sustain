import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneController = TextEditingController();
    final dobController = TextEditingController();
    var selectedGender = 'None';
    void updateGender(String gender) {
      selectedGender = gender;
    }

    Future<void> signUp(BuildContext context, String gender) async {
      try {
        // Create user with email and password
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final firestore = FirebaseFirestore.instance;
        CollectionReference ref = firestore.collection('users');
        final data = <String, String>{
          'email': emailController.text,
          'phone': phoneController.text,
          'dob': dobController.text,
          'gender': gender,
        };
        print(userCredential.user!.uid);
        try {
          await ref
              .doc(userCredential.user!.uid)
              .set(data, SetOptions(merge: true))
              .then((value) => print(
                  "User data added to Firestore")); // Add user data to Firestore
        } catch (e) {
          print("Error adding user data to Firestore: $e");
        }

        // Show success message or navigate to another page
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign Up Successful')));
      } on FirebaseAuthException catch (e) {
        // Handle errors (e.g., email already in use)
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      } on Exception catch (e) {
        // Handle other exceptions
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context)
          .primaryColor, // Set your background color in main.dart
      body: Padding(
        padding: EdgeInsets.only(
            left: 24.0 * w, right: 24.0 * w, top: 40.0 * h, bottom: 24.0 * h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Sign Up',
                    style: Theme.of(context).primaryTextTheme.displayLarge),
                SizedBox(height: 20 * h),
                Image.asset(
                  'lib/images/image_2-removebg-preview.png',
                  height: 235 * h,
                  width: 319 * w,
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
                SizedBox(height: 20 * h),

                // Email Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25 * w),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Phone Number',
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
                    controller: dobController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Date of Birth',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15 * h),
                Text(
                  "Gender",
                  style:
                      Theme.of(context).primaryTextTheme.displayLarge!.copyWith(
                            fontSize: 24 * w,
                          ),
                ),
                SizedBox(height: 15 * h),
                GenderSelectionWidget(
                    onGenderChanged: updateGender, w: w, h: h),
                SizedBox(height: 20 * h),
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
                  onPressed: () => signUp(context, selectedGender),
                  child: Text('Sign Up',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32 * w)),
                ),

                // Sign Up and Forgot Password links
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderSelectionWidget extends StatefulWidget {
  final double w;
  final double h;
  final Function(String) onGenderChanged;

  const GenderSelectionWidget({
    Key? key,
    required this.w,
    required this.h,
    required this.onGenderChanged,
  }) : super(key: key);

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  // Initial value is 'None'
  var selectedGender = 'None';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _genderButton('Male', widget.w, widget.h),
        SizedBox(width: 20 * widget.w),
        _genderButton('Female', widget.w, widget.h),
        SizedBox(width: 20 * widget.w),
        _genderButton('Other', widget.w, widget.h),
      ],
    );
  }

  Widget _genderButton(String gender, double w, double h) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor:
            selectedGender == gender ? Colors.white : Colors.greenAccent,
        padding: EdgeInsets.zero,
        backgroundColor: selectedGender == gender
            ? const Color.fromARGB(255, 6, 157, 29)
            : Colors.white,
        minimumSize: Size(98 * w, 43 * h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedGender = gender;
          widget.onGenderChanged(selectedGender);
        });
        // Implement your logic here
      },
      child: Text(gender,
          style: TextStyle(
              color: selectedGender == gender
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontSize: 24 * w)),
    );
  }
}
