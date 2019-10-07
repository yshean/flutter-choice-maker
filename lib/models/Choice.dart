// import 'package:uuid/uuid.dart';

// var uuid = Uuid();

class Choice {
  String id;
  String category;
  String answer;
  int likelihood;

  Choice({this.id, this.category, this.answer, this.likelihood});

  toJson() {
    return {
      'id': id,
      'category': category,
      'answer': answer,
      'likelihood': likelihood
    };
  }

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
        id: json['id'],
        category: json['category'],
        answer: json['answer'],
        likelihood: json['likelihood']);
  }
}
