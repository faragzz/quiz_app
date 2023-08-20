import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project/Model/player.dart';
import 'package:project/Model/question_data_model.dart';

class QuestionService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<QuestionDataModel>> fetchData() async {
    // Read the JSON file
    String jsonString =
        await rootBundle.loadString('assets/questions/questions.json');

    // Parse the JSON data
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> wordList = jsonData['wordList'];
    List<QuestionDataModel> words = wordList
        .map((jsonObject) => QuestionDataModel.fromJson(jsonObject))
        .toList();

    return words;
  }

  Future<void> addUserData(int score) async {
    String? email = _firebaseAuth.currentUser?.email;
    await FirebaseFirestore.instance.collection('players').add({
      'name': email,
      'score': score,
    });
  }

  Future<List<Player>> getAllPlayers() async {
    List<Player> playerList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('players').get();

    querySnapshot.docs.forEach((doc) {
      Player player = Player(
        email: doc['name'] as String,
        score: doc['score'] as int,
      );
      playerList.add(player);
    });
    return playerList;
  }
}
