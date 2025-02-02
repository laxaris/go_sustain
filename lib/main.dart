import 'package:flutter/material.dart';
import 'package:go_sustain/pages/login_page.dart';
import 'package:go_sustain/pages/others_profile_page.dart';
import 'package:go_sustain/pages/payment_page.dart';
import 'package:go_sustain/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/create_project.dart';
import 'pages/home_page.dart';
import 'pages/leadership.dart';
import 'pages/privacy_page.dart';
import 'pages/profile_page.dart';
import 'pages/project_page.dart';
import 'pages/projects_page.dart';
import 'pages/security_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure flutter bindings are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 36 * h,
              package: "google_sans_display"),
        ),
        primaryColor: const Color.fromRGBO(30, 124, 64, 1),
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        'onUnknownRoute': (context) => LoginPage(),
        '/myprofile': (context) => const ProfilePage(),
        '/createProject': (context) => const CreateProject(),
        '/projects': (context) => const ProjectsPage(),
        '/security': (context) => const SecurityPage(),
        '/privacy': (context) => const PrivacyPage(),
        '/leadership': (context) => const LeadershipPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/projectPage') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) {
              return ProjectPage(projectID: args["projectID"]!);
            },
          );
        }
        if (settings.name == '/payment') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return PaymentPage(
                projectID: args["projectID"]!,
                donationAmount: args["donationAmount"]!,
              );
            },
          );
        }
        if (settings.name == "/othersProfile") {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) {
              return OtherProfile(
                uId: args["uId"]!,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
