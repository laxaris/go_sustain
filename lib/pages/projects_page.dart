import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final List<Project> _projects = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMoreProjects = true;
  bool _isLoading = false;
  final int _projectsPerPage = 5;
  List<String> categories = ['Economic', 'Environmental', 'Social'];
  @override
  void initState() {
    super.initState();
    _loadMoreProjects();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*Future<void> _specifyCurrentMoneyGoalMoney() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference projects = firestore.collection('projects');
    QuerySnapshot querySnapshot = await projects.get();
    List<String> projectIds = [];
    querySnapshot.docs.forEach((doc) {
      projectIds.add(doc.id);
    });

    for (String projectId in projectIds) {
      String currentMoney = Random().nextInt(2000).toString();
      String goalMoney = (Random().nextInt(500) + 2000).toString();
      print('Updating project $projectId');
      DocumentReference projectRef = projects.doc(projectId);
      projectRef.update({'currentMoney': currentMoney, 'goalMoney': goalMoney});
    }
  }
*/
  Future<void> _loadMoreProjects() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('projects')
        .orderBy('projectName');

    // Only add this condition if _lastDocument is not null
    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot snapshot = await query.limit(_projectsPerPage).get();

    if (snapshot.docs.length < _projectsPerPage) {
      _hasMoreProjects = false;
    }

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    }

    var projects = await Future.wait(
        snapshot.docs.map((doc) => Project.fromDocument(doc)));

    setState(() {
      _projects.addAll(projects);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return DefaultTabController(
      length: categories.length,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!_isLoading &&
                _hasMoreProjects &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              _loadMoreProjects();
            }
            return false;
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60, left: 24.0 * w),
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
                      width: 70 * w,
                    ),
                    Text(
                      'Projects',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36 * w,
                          fontFamily: "google_sans_display"),
                    ),
                  ],
                ),
              ),
              TabBar(
                indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.only(top: 50 * h),
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 7 * h, color: Colors.white)),
                indicatorPadding: EdgeInsets.only(bottom: 10 * h),
                indicatorColor: Colors.white,
                unselectedLabelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14 * w,
                  fontFamily: "google_sans_display",
                  fontWeight: FontWeight.bold,
                ),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14 * w,
                    fontFamily: "google_sans_display",
                    fontWeight: FontWeight.bold),
                tabs: categories
                    .map((category) => Tab(
                          text: category,
                        ))
                    .toList(),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                height: 665 * h,
                width: 430 * w,
                child: TabBarView(
                  children: categories.map((String category) {
                    List<Project> filteredProjects = _projects
                        .where((project) => project.category == category)
                        .toList();
                    return ListView.builder(
                      padding: EdgeInsets.only(top: 55 * h),
                      itemCount: _hasMoreProjects
                          ? filteredProjects.length + 1
                          : filteredProjects.length,
                      itemBuilder: (context, index) {
                        if (index == filteredProjects.length) {
                          // Bottom loader indicator
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        Project project = filteredProjects[index];

                        return Column(
                          children: [
                            ProjectCard(
                              ownerGender: (project.ownerGender == "Female"),
                              projectID: project.ID,
                              projectName: project.name,
                              imageUrl: project.imageUrl,
                              explanation: project.description,
                              currentMoney: int.parse(project.currentMoney),
                              goalMoney: int.parse(project.goalMoney),
                            ),
                            SizedBox(
                              height: 25 * h,
                            )
                            // Build your project list tile here
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyBar extends StatefulWidget {
  int currentMoney;
  int goalMoney;
  MoneyBar({required this.currentMoney, required this.goalMoney, super.key});

  @override
  State<MoneyBar> createState() => _MoneyBarState();
}

class _MoneyBarState extends State<MoneyBar> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 10 * h,
          width: 244 * w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: (widget.currentMoney / widget.goalMoney) * 224 * w,
            ),
            Container(
              height: 28 * w,
              width: 28 * w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1)),
              child: Image.asset(
                'lib/images/dollar_sign.png',
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  String projectID;
  String imageUrl;
  String projectName;
  String explanation;
  int currentMoney;
  int goalMoney;
  bool ownerGender;
  ProjectCard(
      {required this.ownerGender,
      required this.projectID,
      required this.currentMoney,
      required this.goalMoney,
      required this.projectName,
      required this.imageUrl,
      required this.explanation,
      super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/projectPage',
            arguments: {"projectID": projectID});
      },
      child: Container(
        decoration: BoxDecoration(
          color: ownerGender ? Colors.purple : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.only(
            top: 10 * h, bottom: 11 * h, left: 24 * w, right: 12 * w),
        height: 152 * h,
        width: 430 * w,
        child: Row(children: [
          CircleAvatar(
            radius: 60 * h, // Adjust the radius as needed
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(width: 17 * w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 257 * w,
                height: 26 * h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(projectName,
                      softWrap: true,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          color: Colors.white,
                          fontSize: 20 * w,
                          fontFamily: "google_sans_display")),
                ),
              ),
              SizedBox(height: 6 * h),
              SizedBox(
                width: 257 * w,
                height: 50,
                child: SingleChildScrollView(
                  clipBehavior: Clip.hardEdge,
                  child: Text(explanation,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14 * w,
                          fontFamily: "google_sans_display")),
                ),
              ),
              MoneyBar(currentMoney: currentMoney, goalMoney: goalMoney),
              SizedBox(
                width: 244 * w,
                child: Row(
                  children: [
                    Text(
                      '\$ $currentMoney',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15 * w,
                          fontFamily: "google_sans_display"),
                    ),
                    const Spacer(),
                    Text(
                      ' \$ $goalMoney',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15 * w,
                          fontFamily: "google_sans_display"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class Project {
  final String ownerGender;
  final String ID;
  final String name;
  final String description;
  final String imageUrl;
  final String currentMoney;
  final String goalMoney;
  final String category;

  Project({
    required this.ownerGender,
    required this.ID,
    required this.category,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.currentMoney,
    required this.goalMoney,
  });

  static Future<Project> fromDocument(DocumentSnapshot doc) async {
    Map data = doc.data() as Map;
    String ownerGender = '';

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference userData =
        firestore.collection('users').doc(data['owner']);

    DocumentSnapshot value = await userData.get();
    ownerGender = (value.data() as Map<String, dynamic>)['gender'];

    return Project(
        ownerGender: ownerGender,
        ID: doc.id,
        name: data['projectName'],
        description: data['explanation'],
        imageUrl: data['imageUrl'],
        currentMoney: data['currentMoney'],
        goalMoney: data['goalMoney'],
        category: data['projectCategory']);
  }
}
