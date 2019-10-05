import "package:mobx/mobx.dart";

import '../models/Choice.dart';

// Run this command to generate:
// flutter packages pub run build_runner watch --delete-conflicting-outputs

// Include generated file from the build_runner
part "choices.g.dart";

// This is the class used by the rest of your codebase
// We create a Counter class to blend in the code from the build_runner.
// The generated file contains the _$Counter mixin.
class Choices = _Choices with _$Choices;

// The store-class
// A store in MobX is a way of collecting the related observable state
// under one class.
// The store allows us to use annotations and keeps the code simple.
// The abstract class _Counter that includes the Store mixin.
// All of your store-related code should be placed inside this abstract class.
abstract class _Choices with Store {
  // The @observable annotation marks the value as observable
  @observable
  List<Choice> choices = [];
  Map<String, Choice> choicesMap = {};

  // @computed
  // compute the map of {id: choice}

  // Use of @action annotation marks the increment() method as an action
  @action
  void addChoice(Choice choice) {
    choices.add(choice);
  }

  @action
  void editChoice(Choice choice) {
    // TODO: use map instead
    final editIndex = choices.indexWhere((ch) => ch.id == choice.id);
    choices[editIndex] = choice;
  }
}
