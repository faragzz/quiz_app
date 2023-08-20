import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/Model/question_data_model.dart';

class QuizProvidor extends ChangeNotifier {
  int _score = 0;
  int _curLevel = 0;
  String _playerName = "";
  String _playerEmail = "";
  late Future<List<QuestionDataModel>> worldList;

  void addList(Future<List<QuestionDataModel>> list) {}

  void addToScore() {
    _score = _score + 10;
  }

  void addNextLevel() {
    _curLevel++;
  }

  void resetLevel() {
    _curLevel = 0;
  }

  void resetScore() {
    _score = 0;
  }

  void setPlayerName(String name) {
    _playerName = name;
  }

  void setPlayerEmail(String email) {
    _playerEmail = email;
  }

  int getLevel() {
    return _curLevel;
  }

  int getScore() {
    return _score;
  }

  String getPlayerName() {
    return _playerName;
  }

  String getPlayerEmail() {
    return _playerEmail;
  }
}
