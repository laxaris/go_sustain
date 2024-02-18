import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LeadershipPage extends StatefulWidget {
  const LeadershipPage({super.key});

  @override
  State<LeadershipPage> createState() => _LeadershipPageState();
}

Future<List<QuerySnapshot>> fetchData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return await Future.wait([
    firestore.collection('users').orderBy('project_contribution').get(),
    firestore.collection('projects').orderBy('currentMoney').get()
  ]);
}

class _LeadershipPageState extends State<LeadershipPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 430;
    double h = MediaQuery.of(context).size.height / 932;
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                                    width: 45 * w,
                                  ),
                                  Text(
                                    'Leadership',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36 * w,
                                        fontFamily: "google_sans_display"),
                                  ),
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
                                        height: 42 * h,
                                      ),
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
                  )),
            );
          }
          final data = snapshot.data as List;

          final users =
              (data[0] as QuerySnapshot).docs as List<DocumentSnapshot>;
          final projects =
              (data[1] as QuerySnapshot).docs as List<DocumentSnapshot>;
          List<Map<String, dynamic>> userList =
              users.map((user) => user.data() as Map<String, dynamic>).toList();
          List<Map<String, dynamic>> projectList = projects.map((project) {
            return project.data() as Map<String, dynamic>;
          }).toList();

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
                                    width: 45 * w,
                                  ),
                                  Text(
                                    'Leadership',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36 * w,
                                        fontFamily: "google_sans_display"),
                                  ),
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
                                        height: 42 * h,
                                      ),
                                      Text(
                                        "Top Donors",
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontSize: 24 * w,
                                            fontFamily: "google_sans_display"),
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      UserBox(
                                        imageUrl: userList[0]['imageUrl'],
                                        name: userList[0]['name'],
                                        uid: userList[0]['uId'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      UserBox(
                                        imageUrl: userList[1]['imageUrl'],
                                        name: userList[1]['name'],
                                        uid: userList[1]['uId'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      UserBox(
                                        imageUrl: userList[2]['imageUrl'],
                                        name: userList[2]['name'],
                                        uid: userList[2]['uId'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      UserBox(
                                        imageUrl: userList[2]['imageUrl'],
                                        name: userList[2]['name'],
                                        uid: userList[2]['uId'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      UserBox(
                                        imageUrl: userList[2]['imageUrl'],
                                        name: userList[2]['name'],
                                        uid: userList[2]['uId'],
                                      ),
                                      SizedBox(
                                        height: 30 * h,
                                      ),
                                      Text(
                                        "The highest funded projects",
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontSize: 24 * w,
                                            fontFamily: "google_sans_display"),
                                      ),
                                      SizedBox(
                                        height: 20 * h,
                                      ),
                                      ProjectBox(
                                        imageUrl: projectList[0]['imageUrl'],
                                        name: projectList[0]['projectName'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      ProjectBox(
                                        imageUrl: projectList[1]['imageUrl'],
                                        name: projectList[1]['projectName'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      ProjectBox(
                                        imageUrl: projectList[2]['imageUrl'],
                                        name: projectList[2]['projectName'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      ProjectBox(
                                        imageUrl: projectList[3]['imageUrl'],
                                        name: projectList[3]['projectName'],
                                      ),
                                      SizedBox(
                                        height: 13 * h,
                                      ),
                                      ProjectBox(
                                        imageUrl: projectList[4]['imageUrl'],
                                        name: projectList[4]['projectName'],
                                      ),
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
        });
  }
}

class UserBox extends StatelessWidget {
  String imageUrl;
  String name;
  String uid;
  UserBox(
      {required this.imageUrl,
      required this.name,
      required this.uid,
      super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 430;
    double h = MediaQuery.of(context).size.height / 932;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/othersProfile', arguments: {"uId": uid});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 4 * w,
          ),
        ),
        height: 36 * h,
        width: 388 * w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 27 * w,
            ),
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2 * w,
                  ),
                ),
                child: CircleAvatar(
                    radius: 28 * w, backgroundImage: NetworkImage(imageUrl))),
            Spacer(),
            Text(
              name,
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontSize: 20 * w,
                  fontFamily: "google_sans_display"),
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30 * w,
            ),
            SizedBox(
              width: 27 * w,
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectBox extends StatelessWidget {
  String imageUrl;
  String name;
  ProjectBox({required this.imageUrl, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 430;
    double h = MediaQuery.of(context).size.height / 932;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 4 * w,
        ),
      ),
      height: 36 * h,
      width: 388 * w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 27 * w,
          ),
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2 * w,
                ),
              ),
              child: CircleAvatar(
                  radius: 28 * w, backgroundImage: NetworkImage(imageUrl))),
          Container(
            width: 280 * w,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                name,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 20 * w,
                    fontFamily: "google_sans_display"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
