import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherProfile extends StatefulWidget {
  String uId;
  OtherProfile({required this.uId, super.key});

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No data available');
          } else {
            final data = snapshot.data!.data() as Map<String, dynamic>;

            return Scaffold(
                key: _scaffoldKey,
                endDrawer: NavDrawer(imageUrl: data['imageUrl']),
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
                                      width: 80 * w,
                                    ),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 36 * w,
                                          fontFamily: "google_sans_display"),
                                    ),
                                    SizedBox(
                                      width: 80 * w,
                                    ),
                                    IconButton(
                                        onPressed: _openDrawer,
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
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 29 * h,
                                        ),
                                        // Display the fetched data here
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          child: Image.network(
                                            data['imageUrl'],
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
        });
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

class NavDrawer extends StatelessWidget {
  String imageUrl;

  NavDrawer({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return Drawer(
        width: 271 * w,
        child:
            ListView(padding: EdgeInsets.only(top: 97 * h), children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 68 * w,
              ),
              Container(
                height: 161 * w,
                width: 161 * w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2 * w,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60 * h,
          ),
          Row(
            children: [
              SizedBox(
                width: 50 * w,
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Complain",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24 * w,
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      minimumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      maximumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2 * w),
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 21 * w)),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/privacy');
                    },
                    child: Text(
                      "Block",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24 * w,
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      minimumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      maximumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2 * w),
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 21 * w)),
                    ),
                  ),
                  SizedBox(
                    height: 28 * h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/security');
                    },
                    child: Text(
                      "Spam",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24 * w,
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      minimumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      maximumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2 * w),
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 21 * w)),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Share this account",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20 * w,
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      minimumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      maximumSize:
                          MaterialStateProperty.all(Size(208 * w, 46 * h)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2 * w),
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 21 * w)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 13 * w,
              ),
            ],
          ),
        ]));
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
