import 'package:choice_maker/ListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sprung/sprung.dart';

import 'stores/choices.dart';

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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Choices choices = Provider.of<Choices>(context);

    _gotoListScreen(BuildContext context) async {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListScreen()));
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
            : Center(
                child: GestureDetector(
                  onTap: () {},
                  child: GrowTransition(
                    child: Center(
                      child: Text('Decide!',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600)),
                    ),
                    animation: animation,
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _gotoListScreen(context),
          tooltip: 'Add a choice',
          child: Icon(Icons.list),
        ),
      ),
    );
  }
}
