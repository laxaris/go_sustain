import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();
  final TextEditingController _projectGoalController = TextEditingController();
  String? _selectedCategory; // Initially no category is selected
  int _selectedDegree = 0; // Initially no degree is selected
  XFile? _image; // Variable to hold the selected image
  @override
  void initState() {
    super.initState();
  }

  void _selectDegree(int degree) {
    setState(() {
      _selectedDegree = degree;
    });
  }

  Future<void> _publishProject() async {
    print("Publishing project");
    try {
      final storageRef = FirebaseStorage.instance.ref();
      print("Publishing project");
// Create a reference to "mountains.jpg"
      final projectImages = storageRef.child('projectImages');
      print("Publishing project");

// While the file names are the same, the references point to different files
      final file = File(_image!.path);
      print(_image!.path);
      print("Publishing project");
      final imageUrl = await projectImages
          .child(_projectNameController.text)
          .putFile(file)
          .then((snapshot) => snapshot.ref.getDownloadURL());
      print("Publishing project");

      // Save project details to Firestore
      CollectionReference projects =
          FirebaseFirestore.instance.collection('projects');
      await projects.add({
        'owner': FirebaseAuth.instance.currentUser!.uid,
        'projectName': _projectNameController.text,
        'explanation': _explanationController.text,
        'projectGoal': _projectGoalController.text,
        'projectCategory': _selectedCategory,
        'degreeOfSustainability': _selectedDegree,
        'imageUrl': imageUrl, // URL of the uploaded image
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project published successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = image;
          print(_image!.path);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
            padding: EdgeInsets.only(top: 40.0 * h, bottom: 24.0 * h),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 24.0 * w),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 40 * w,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Create a Project',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36 * w,
                                  fontFamily: "google_sans_display"),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                  size: 50 * w,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25 * h,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                              color: Colors.white,
                              height: 688 * h,
                              width: 430 * w,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 21.0 * w),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 31 * h,
                                    ),
                                    GestureDetector(
                                      onTap: _pickImage,
                                      child: Container(
                                          height: 185 * w,
                                          width: 185 * w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 3.0 * w,
                                            ),
                                          ),
                                          child: _image == null
                                              ? Image.asset(
                                                  'lib/images/plusInCircle.png',
                                                  height: 53 * w,
                                                  width: 53 * w,
                                                )
                                              : ClipOval(
                                                  child: Image.file(
                                                    File(_image!.path),
                                                    height: 52 * w,
                                                    width: 52 * w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                    ),
                                    SizedBox(
                                      height: 30 * h,
                                    ),
                                    CustomTextField(
                                        hintText: "Project Name",
                                        controller: _projectNameController),
                                    SizedBox(
                                      height: 23 * h,
                                    ),
                                    CustomTextField(
                                        hintText: "Explanation",
                                        controller: _explanationController),
                                    SizedBox(height: 23 * h),
                                    CustomTextField(
                                        hintText: "Project Goal",
                                        controller: _projectGoalController),
                                    SizedBox(height: 23 * h),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 9 * h,
                                            horizontal: 32 *
                                                w), // Adjust vertical padding to control height
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Project Category',
                                        hintStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                              0,
                                              0,
                                              0,
                                              0.50,
                                            ),
                                            fontSize: 24 * w,
                                            fontFamily: "google_sans_display"),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                              width: 3.0 *
                                                  w, // Ensure 'w' scales the border width as intended
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                              width: 4.0 *
                                                  w, // Ensure 'w' scales the border width as intended
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      value: _selectedCategory,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedCategory = value;
                                        });
                                      },
                                      items: const [
                                        DropdownMenuItem(
                                          value: "Social",
                                          child: Text("Social",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        DropdownMenuItem(
                                          value: "Environmental",
                                          child: Text("Environmental",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        DropdownMenuItem(
                                          value: "Economic",
                                          child: Text("Economic",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 19 * h),
                                    DegreeOfSustainability(
                                      selectDegree: _selectDegree,
                                      selectedDegree: _selectedDegree,
                                    ),
                                    SizedBox(height: 19 * h),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            minimumSize: MaterialStateProperty.all(
                                                Size(158 * w, 40 * h)),
                                            maximumSize:
                                                MaterialStateProperty.all(Size(
                                                    158 * w,
                                                    40 * h)), // Text color
                                            backgroundColor: MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColor), // Background color
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0))), // Button shape
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(horizontal: 25 * w))), // Button padding

                                        onPressed: _publishProject,
                                        child: Text('Publish', style: TextStyle(color: Colors.white, fontSize: 22 * w, fontWeight: FontWeight.w400, fontFamily: "google_sans_display"))),
                                  ],
                                ),
                              ))),
                      SizedBox(
                        height: 10 * h,
                      ),
                      Center(
                        child: Image.asset(
                          'lib/images/image_2-removebg-preview.png',
                          height: 65 * h,
                          width: 65 * w,
                        ),
                      ),
                    ]),
              ),
            )));
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomTextField(
      {required this.hintText, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return SizedBox(
      height: 48 * h,
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 9 * h,
                horizontal:
                    32 * w), // Adjust vertical padding to control height
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: TextStyle(
                color: const Color.fromRGBO(
                  0,
                  0,
                  0,
                  0.50,
                ),
                fontSize: 24 * w,
                fontFamily: "google_sans_display"),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  width:
                      3.0 * w, // Ensure 'w' scales the border width as intended
                  color: Theme.of(context).primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  width:
                      4.0 * w, // Ensure 'w' scales the border width as intended
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}

class DegreeOfSustainability extends StatefulWidget {
  int selectedDegree; // Initially no degree is selected
  Function(int degree) selectDegree;
  DegreeOfSustainability(
      {required this.selectDegree, required this.selectedDegree, super.key});
  @override
  _DegreeOfSustainabilityState createState() => _DegreeOfSustainabilityState();
}

class _DegreeOfSustainabilityState extends State<DegreeOfSustainability> {
// Initially no degree is selected

  Widget _buildDegree(int degree) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    bool isSelected = widget.selectedDegree == degree;

    return Row(
      children: [
        GestureDetector(
          onTap: () => widget.selectDegree(degree),
          child: Container(
            width: 31 * w, // Adjust the size as needed
            height: 31 * w, // Adjust the size as needed
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).primaryColor, // Selected text color
              // Selected color
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green),
            ),
            child: Center(
              child: Text(
                degree.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.white, // Selected text color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        'Degree of sustainability',
        style: TextStyle(
            color: const Color.fromRGBO(0, 0, 0, 0.50),
            fontWeight: FontWeight.w400,
            fontSize: 24 * w,
            fontFamily: "google_sans_display"),
      ),
      SizedBox(height: 20 * h), // Space between the text and the degrees
      Row(mainAxisSize: MainAxisSize.min, children: [
        _buildDegree(1),
        SizedBox(width: 43 * w), // Space between the degrees
        _buildDegree(2),
        SizedBox(width: 43 * w), // Space between the degrees
        _buildDegree(3),
        SizedBox(width: 43 * w), // Space between the degrees
        _buildDegree(4),
        SizedBox(width: 43 * w), // Space between the degrees
        _buildDegree(5),
      ]),
    ]);
  }
}
