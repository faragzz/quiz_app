import 'package:flutter/material.dart';
import 'package:project/Model/question_data_model.dart';
import 'package:project/providor/quiz_providor.dart';
import 'package:project/screens/result_page.dart';
import 'package:project/services/auth/auth.dart';
import 'package:project/services/question_service.dart/question_service.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int curlevel = 0;
  String word = "Hello";
  final QuestionService questionService = QuestionService();
  late List<QuestionDataModel> wordList;

  @override
  void initState() {
    super.initState();
    _setThings();
  }

  Future<void> _setThings() async {
    wordList = await questionService.fetchData();
    setState(() {
      word = wordList[0].word;
    });
  }

  void btnPressed(String txt, QuizProvidor quizProvidor) async {
    int index = quizProvidor.getLevel();
    if (wordList[index].pos.toLowerCase() == txt.toLowerCase()) {
      setState(() {
        quizProvidor.addToScore();
        score = quizProvidor.getScore();
      });
    }
    setState(() {
      quizProvidor.addNextLevel();
      curlevel = quizProvidor.getLevel();
      if (curlevel > 5) {
        // String email = quizProvidor.getPlayerEmail();
        //add score in player object
        sendDataToFirebase(score);
        // quizProvidor.resetLevel();
        // quizProvidor.resetScore();
      }
      word = wordList[curlevel].word;
    });
  }

  void sendDataToFirebase(int score) {
    questionService.addUserData(score);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultPage(),
        ));
  }

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      authService.signout();
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
    final quizProvidor = Provider.of<QuizProvidor>(context);
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: signOut,
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Quiz Game',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
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
                    'Score: $score',
                    style: const TextStyle(
                      fontSize: 30,
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
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Question: $curlevel',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/quiz_logo.png',
                          width: 100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Word: $word',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            // decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'choose whether it is a  \n(verb, adverb, adjective, noun).',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChooseBtn(quizProvidor, 'Noun'),
                      ChooseBtn(quizProvidor, 'Verb'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChooseBtn(quizProvidor, 'Adjective'),
                      ChooseBtn(quizProvidor, 'Adverb'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ChooseBtn(QuizProvidor quizProvidor, String txt) {
    return Container(
      width: 150,
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[600],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => btnPressed(txt, quizProvidor),
          child: Text(
            txt,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
