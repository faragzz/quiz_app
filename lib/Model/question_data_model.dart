class QuestionDataModel {
  final int id;
  final String word;
  final String pos;

  QuestionDataModel({required this.id, required this.word, required this.pos});

  factory QuestionDataModel.fromJson(Map<String, dynamic> json) {
    return QuestionDataModel(
        id: json['id'], word: json['word'], pos: json['pos']);
  }
}
