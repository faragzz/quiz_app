import 'package:flutter/material.dart';
import 'package:project/screens/login_page.dart';
import 'package:project/screens/register_page.dart';

class LoginOrRegist extends StatefulWidget {
  const LoginOrRegist({super.key});

  @override
  State<LoginOrRegist> createState() => _LoginOrRegistState();
}

class _LoginOrRegistState extends State<LoginOrRegist> {
  bool goToLogin = true;

  void toggleBetweenPages() {
    setState(() {
      goToLogin = !goToLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (goToLogin) {
      return LoginPage(onTap: toggleBetweenPages);
    }
    return RegistedPage(onTap: toggleBetweenPages);
  }
}
