import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/components/my_button.dart';
import 'package:project/components/my_text_filed.dart';
import 'package:project/providor/quiz_providor.dart';
import 'package:project/services/auth/auth.dart';
import 'package:provider/provider.dart';

class RegistedPage extends StatefulWidget {
  final void Function()? onTap;
  const RegistedPage({super.key, required this.onTap});

  @override
  State<RegistedPage> createState() => _RegistedPageState();
}

class _RegistedPageState extends State<RegistedPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void signUp() {
    final quizProvidor = Provider.of<QuizProvidor>(context, listen: false);
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'passwords aren\'t equal',
          ),
        ),
      );
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      authService.signUpWithEmailAndPassword(
          emailController.text, passwordController.text);
      quizProvidor.setPlayerEmail(emailController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/signupAnimation.json', width: 250),
                  const SizedBox(height: 30),
                  //create account text
                  const Text(
                    "let's us create an account for you!",
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
                  const SizedBox(height: 10),
                  //password textfield
                  MyTextFiled(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obsecureText: true),
                  const SizedBox(height: 25),
                  //sign in btn
                  MyButton(text: 'Sign up', onTap: signUp),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
