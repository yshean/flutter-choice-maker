import 'package:choice_maker/ListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'stores/choices.dart';
import 'models/Choice.dart';

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => ClipOval(
                  child: Container(
                    height: animation.value,
                    width: animation.value,
                    color: Colors.yellow,
                    child: child,
                  ),
                ),
            child: child),
      );
}

class DecideScreen extends StatefulWidget {
  const DecideScreen({Key key}) : super(key: key);

  @override
  _DecideScreenState createState() => _DecideScreenState();
}

class _DecideScreenState extends State<DecideScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  String _selectedQuestion;
  var received;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 120, end: 160).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
    // setState(() {
    //   _selectedQuestion = _getDropdownMenuItems().first.value;
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<DropdownMenuItem> _getDropdownMenuItems() {
    final Choices choices = Provider.of<Choices>(context);
    final categories = choices.choicesMap.keys;
    List<DropdownMenuItem> result = List<DropdownMenuItem>.from(categories
        .map((String cat) => DropdownMenuItem(value: cat, child: Text(cat)))
        .toList());

    return result;
  }

  randomChoice(choicesMap, cumulativeProb, String category) {
    final random = Random();
    final currCatItems = choicesMap[category];
    double cumulativeProb = 0;
    double p = random.nextDouble();

    // for totally randomized
    // return currCatItems[_random.nextInt(currCatItems.length)];

    // for likelihood
    for (Choice _choice in currCatItems) {
      cumulativeProb += _choice.likelihood / cumulativeProb;

      if (p <= cumulativeProb) {
        return _choice;
      }
    }
  }

  void _showDialog() {
    final Choices choices = Provider.of<Choices>(context);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("You should go for..."),
            content: Text(randomChoice(choices.choicesMap,
                    choices.cumulativeProb, _selectedQuestion)
                .answer),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Choices choices = Provider.of<Choices>(context);

    _gotoListScreen(BuildContext ctx) async {
      await Navigator.push(ctx, MaterialPageRoute(builder: (_) => ListScreen()))
          .then((_) => {this.setState(() {})});
    }

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Make a Choice"),
        ),
        body: choices.choices.length == 0
            ? Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/no_entries.png'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Add at least a choice to the list to begin.',
                          style: Theme.of(context).textTheme.title,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Container(height: 32.0),
                    Row(
                      children: <Widget>[
                        Container(width: 32.0),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: _selectedQuestion,
                            items: List<DropdownMenuItem>.from(choices
                                .categoryList
                                .map((String cat) => DropdownMenuItem(
                                    value: cat, child: Text(cat)))
                                .toList()),
                            onChanged: (value) {
                              setState(() {
                                _selectedQuestion = value;
                              });
                            },
                          ),
                        ),
                        Container(width: 32.0),
                      ],
                    ),
                    Container(height: MediaQuery.of(context).size.height / 4),
                    choices.choicesMap[_selectedQuestion] == null
                        ? Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/images/no_entries.png'),
                                  Text(
                                    'Select a question or add at least a choice to the question to begin.',
                                    style: Theme.of(context).textTheme.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showDialog();
                                    },
                                    child: GrowTransition(
                                      child: Center(
                                        child: Text('Decide!',
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      animation: animation,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _gotoListScreen(context),
          tooltip: 'Add a choice',
          child: Icon(Icons.list),
        ),
      ),
    );
  }
}
