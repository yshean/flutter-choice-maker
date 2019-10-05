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
  ObservableList<Choice> choices = ObservableList<Choice>();

  @observable
  ObservableMap<String, ObservableList<Choice>> choicesMap =
      ObservableMap<String, ObservableList<Choice>>();

  // @computed
  // compute the map of {id: choice}

  void _processResult() {
    print("Run _processResult()");
    // Create a set of (unique) categories
    Set categories = Set.from(choices.map((v) => v.category));

    // Sort entries according to likelihood
    choices.sort((Choice a, Choice b) => b.likelihood.compareTo(a.likelihood));

    for (var cat in categories) {
      // var normalList =
      //     List<Choice>.from(choices.where((entry) => (entry.category == cat)));
      // var newObList = ObservableList<Choice>();
      // newObList.addAll(normalList);
      // choicesMap[cat] = newObList;

      choicesMap[cat] = ObservableList<Choice>.of(
          choices.where((entry) => (entry.category == cat)));
    }
  }

  // @computed
  // Map<String, List<Choice>> get allChoices {
  //   print("Run get allChoices");
  //   return choicesMap;
  // }

  // @computed
  // List<Choice> get allChoicesList {
  //   print("Run get allChoicesList");
  //   return choices;
  // }

  // Use of @action annotation marks the increment() method as an action
  @action
  void addChoice(Choice choice) {
    choices.add(choice);
    _processResult();
  }

  @action
  void editChoice(Choice choice) {
    // TODO: use map instead
    print("Editing " + choice.id);
    final editIndex = choices.indexWhere((ch) => ch.id == choice.id);
    choices[editIndex] = choice;
    _processResult();
  }

  @action
  void deleteChoice(String id) {
    print("Deleting " + id);
    choices.removeWhere((item) => item.id == id);
    print("[Store] Choices Length: " + choices.length.toString());
    _processResult();
  }
}
