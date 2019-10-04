import 'package:uuid/uuid.dart';

var uuid = new Uuid();

class Choice {
  String id;
  String category;
  String answer;
  double percentage;

  Choice({this.category, this.answer, this.percentage}) {
    this.id = uuid.v4();
  }
}
