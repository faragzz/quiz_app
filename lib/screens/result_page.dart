import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Model/player.dart';
import 'package:project/components/list_view_tile.dart';
import 'package:project/providor/quiz_providor.dart';
import 'package:project/screens/quiz_page.dart';
import 'package:project/services/question_service.dart/question_service.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String playerName = 'Ahmed Khaled Farag';
  List<Player> list = [];
  int index = 0;
  final QuestionService questionService = QuestionService();

  @override
  void initState() {
    super.initState();
    setInit();
  }

  Future<void> setInit() async {
    list = await questionService.getAllPlayers();
    setState(() {
      index = list.length;
    });
  }

  // '$playerName $score'
  @override
  Widget build(BuildContext context) {
    final quizProvidor = Provider.of<QuizProvidor>(context);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizPage(),
                    ),
                  );
                },
              ),
            ),
            const Text(
              'Quiz Game',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.person_2_rounded,
                    size: 50,
                  ),
                ),
                Text(
                  '${_firebaseAuth.currentUser?.email}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        'You scored: ${quizProvidor.getScore()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/quiz_logo.png',
                        width: 100,
                      ),
                      const SizedBox(height: 10),
                      (quizProvidor.getScore() == 50)
                          ? const Text(
                              'Great Job keep up the good work',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : const Text(
                              'Nice Try keep on Grindeing',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TileListView(list[index].email, list[index].score),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
