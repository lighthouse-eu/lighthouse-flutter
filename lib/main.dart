import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/screens/new_post.dart';
import 'package:lighthouse/screens/sign_in.dart';
import 'package:lighthouse/screens/sign_up.dart';
import 'package:lighthouse/screens/sign_up_success.dart';
import 'package:lighthouse/screens/tabs/profile.dart';
import 'package:lighthouse/screens/tabs/reported.dart';
import 'package:lighthouse/screens/tabs/spotted.dart';
import 'package:lighthouse/screens/tabs/tips.dart';
import 'package:lighthouse/services/navigation.dart';
import 'package:lighthouse/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lighthouse',
      theme: lightTheme,
      navigatorKey: Navigation.key,
      onGenerateRoute: (settings) {
        var page;
        print('onGenerateRoute with: ${settings.name}');
        switch (settings.name) {
          case '/home':
            page = const HomeScreen();
            break;
          case '/signin':
            page = SignInScreen();
            break;
          case '/signup':
            page = SignUpScreen();
            break;
          case '/signupSuccess':
            page = const SignupSuccess();
            break;
          default:
            break;
        }
        return MaterialPageRoute(
            builder: (context) => page, settings: settings);
      },
      home: StreamBuilder<User?>(
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen();
          }
          return const HomeScreen();
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          const ReportedTab(),
          const SpottedTab(),
          NewPost(),
          const TipsTab(),
          const ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (newIndex) => setState(() {
          _tabController.index = newIndex;
          _tabController.animateTo(newIndex);
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.visibility_outlined), label: 'Spotted'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Missing'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.help_center_outlined), label: 'Help'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        selectedItemColor: const Color(0xFFF8A435),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
