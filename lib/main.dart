import 'package:flutter/material.dart';
import 'Authentication/login.dart';
import 'Authentication/sign_up.dart';
import 'Firebase/firebase_helper.dart';

Future<void> main() async {
  await FirebaseHelper.firebaseConnection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Authentication App",
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void goingToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        }
      ),
    );
  }
  void goingToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const SignUpPage();
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: gradientToMainPage(context),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(38.0),
                child: ElevatedButton(
                  onPressed: () {
                    goingToLogin(context);
                  },
                  child: const Text("Login"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(38.0),
                child: ElevatedButton(
                  onPressed: () {
                    goingToSignUp(context);
                  },
                  child: const Text("SignUp"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

LinearGradient gradientToMainPage(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).colorScheme.primaryContainer,
      Theme.of(context).colorScheme.secondaryContainer,
      Theme.of(context).colorScheme.tertiaryContainer,
    ],
    end: Alignment.topCenter,
    begin: Alignment.bottomCenter,
  );
}
