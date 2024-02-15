import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                            SizedBox(
                              width: 53 * w,
                            ),
                            Text(
                              'My Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36 * w,
                                  fontFamily: "google_sans_display"),
                            ),
                            SizedBox(
                              width: 53 * w,
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
                            child: FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData) {
                                  return const Text('No data available');
                                } else {
                                  final data = snapshot.data!.data()
                                      as Map<String, dynamic>;
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 29 * h,
                                      ),
                                      // Display the fetched data here
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: Image.network(
                                          data['image'],
                                          height: 161 * h,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 * h,
                                      ),
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                            fontSize: 24 * w,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "google_sans_display",
                                            color: const Color.fromRGBO(
                                              0,
                                              0,
                                              0,
                                              0.50,
                                            )),
                                      ),

                                      SizedBox(
                                        height: 30 * h,
                                      ),
                                      BubbleText(
                                        title: "Short Biography",
                                        data: data['short_biography'],
                                      ),
                                      SizedBox(
                                        height: 10 * h,
                                      ),
                                      BubbleText(
                                        title: "Education",
                                        data: data['education'],
                                      ),
                                      SizedBox(
                                        height: 10 * h,
                                      ),
                                      BubbleText(
                                        title: "Goals and Vision",
                                        data: data['goals_vision'],
                                      ),
                                      SizedBox(
                                        height: 10 * h,
                                      ),
                                      BubbleText(
                                        title: "Project Contributions",
                                        data: data['project_contribution'],
                                      ),
                                      SizedBox(
                                        height: 33 * h,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ImageButton(
                                                link: data['instagram'],
                                                imagePath:
                                                    'lib/images/instagram.png'),
                                            SizedBox(
                                              width: 75 * w,
                                            ),
                                            ImageButton(
                                                link: data['linkedin'],
                                                imagePath:
                                                    'lib/images/linkedin.png'),
                                            SizedBox(
                                              width: 75 * w,
                                            ),
                                            ImageButton(
                                                link: data['behance'],
                                                imagePath:
                                                    'lib/images/behance.png'),
                                          ])
                                    ],
                                  );
                                }
                              },
                            ),
                          )),
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

class BubbleText extends StatelessWidget {
  final String title;
  final String data;
  const BubbleText({required this.title, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;

    return Container(
        width: 388 * w,
        height: 67 * h,
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2 * w),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
            child: Container(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10 * w),
                child: SizedBox(
                  height: 43 * h,
                  child: SingleChildScrollView(child: Text(data)),
                ),
              )
            ],
          ),
        )));
  }
}

class ImageButton extends StatelessWidget {
  final String link;
  final String imagePath;
  const ImageButton({required this.link, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(link));
      },
      child: Image.asset(
        imagePath,
        height: 46 * h,
        width: 46 * w,
      ),
    );
  }
}
