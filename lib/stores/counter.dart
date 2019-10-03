import "package:mobx/mobx.dart";

// Include generated file from the build_runner
part "counter.g.dart";

// This is the class used by the rest of your codebase
// We create a Counter class to blend in the code from the build_runner.
// The generated file contains the _$Counter mixin.
class Counter = _Counter with _$Counter;

// The store-class
// A store in MobX is a way of collecting the related observable state
// under one class.
// The store allows us to use annotations and keeps the code simple.
// The abstract class _Counter that includes the Store mixin.
// All of your store-related code should be placed inside this abstract class.
abstract class _Counter with Store {
  // The @observable annotation marks the value as observable
  @observable
  int value = 0;

  // Use of @action annotation marks the increment() method as an action
  @action
  void increment() {
    value++;
  }
}
