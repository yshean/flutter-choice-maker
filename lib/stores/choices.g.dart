// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choices.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Choices on _Choices, Store {
  Computed<dynamic> _$categoryListComputed;

  @override
  dynamic get categoryList =>
      (_$categoryListComputed ??= Computed<dynamic>(() => super.categoryList))
          .value;
  Computed<dynamic> _$cumulativeProbComputed;

  @override
  dynamic get cumulativeProb => (_$cumulativeProbComputed ??=
          Computed<dynamic>(() => super.cumulativeProb))
      .value;

  final _$choicesAtom = Atom(name: '_Choices.choices');

  @override
  ObservableList<Choice> get choices {
    _$choicesAtom.context.enforceReadPolicy(_$choicesAtom);
    _$choicesAtom.reportObserved();
    return super.choices;
  }

  @override
  set choices(ObservableList<Choice> value) {
    _$choicesAtom.context.conditionallyRunInAction(() {
      super.choices = value;
      _$choicesAtom.reportChanged();
    }, _$choicesAtom, name: '${_$choicesAtom.name}_set');
  }

  final _$choicesMapAtom = Atom(name: '_Choices.choicesMap');

  @override
  ObservableMap<String, ObservableList<Choice>> get choicesMap {
    _$choicesMapAtom.context.enforceReadPolicy(_$choicesMapAtom);
    _$choicesMapAtom.reportObserved();
    return super.choicesMap;
  }

  @override
  set choicesMap(ObservableMap<String, ObservableList<Choice>> value) {
    _$choicesMapAtom.context.conditionallyRunInAction(() {
      super.choicesMap = value;
      _$choicesMapAtom.reportChanged();
    }, _$choicesMapAtom, name: '${_$choicesMapAtom.name}_set');
  }

  final _$_ChoicesActionController = ActionController(name: '_Choices');

  @override
  void addChoice(Choice choice) {
    final _$actionInfo = _$_ChoicesActionController.startAction();
    try {
      return super.addChoice(choice);
    } finally {
      _$_ChoicesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editChoice(Choice choice) {
    final _$actionInfo = _$_ChoicesActionController.startAction();
    try {
      return super.editChoice(choice);
    } finally {
      _$_ChoicesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteChoice(String id) {
    final _$actionInfo = _$_ChoicesActionController.startAction();
    try {
      return super.deleteChoice(id);
    } finally {
      _$_ChoicesActionController.endAction(_$actionInfo);
    }
  }
}
