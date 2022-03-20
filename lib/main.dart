import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/screens/create_profile.dart';
import 'package:lighthouse/screens/sign_in.dart';
import 'package:lighthouse/screens/sign_up.dart';
import 'package:lighthouse/screens/sign_up_success.dart';
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
        return MaterialPageRoute(builder: (context) => page, settings: settings);
      },
      home: StreamBuilder<User?>(
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CreateProfile();
          }
          return CreateProfile();
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
