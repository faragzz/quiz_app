import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/components/my_button.dart';
import 'package:project/components/my_text_filed.dart';
import 'package:project/services/auth/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void signIn() {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            //logo
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loginLottie.json', width: 250),
                  const SizedBox(height: 15),
                  //welcome text
                  const Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyTextFiled(
                      controller: emailController,
                      hintText: 'Email',
                      obsecureText: false),
                  const SizedBox(height: 10),
                  //password textfield
                  MyTextFiled(
                      controller: passwordController,
                      hintText: 'Password',
                      obsecureText: true),
                  const SizedBox(height: 25),
                  //sign in btn
                  MyButton(text: 'Sign in', onTap: signIn),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //signin button
            //not a member? register
          ),
        ),
      ),
    );
  }
}
