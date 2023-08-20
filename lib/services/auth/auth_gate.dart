import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/quiz_page.dart';
import 'package:project/services/auth/login_or_Regist.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user logged in
        if (snapshot.hasData) {
          return const QuizPage();
        }
        //user Not logged in
        else {
          return const LoginOrRegist();
        }
      },
    );
  }
}
