// import 'package:uuid/uuid.dart';

// var uuid = Uuid();

class Choice {
  String id;
  String category;
  String answer;
  int likelihood;

  Choice({this.id, this.category, this.answer, this.likelihood}) {
    // this.id = uuid.v4();
  }
}
