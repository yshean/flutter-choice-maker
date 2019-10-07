import 'package:choice_maker/ListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sprung/sprung.dart';

import 'stores/choices.dart';

class DecideScreen extends StatefulWidget {
  const DecideScreen({Key key}) : super(key: key);

  @override
  _DecideScreenState createState() => _DecideScreenState();
}

class _DecideScreenState extends State<DecideScreen> {
  bool _isOffset = false;

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
                  onTap: () {
                    setState(() {
                      _isOffset = !_isOffset;
                    });
                  },
                  child: ClipOval(
                    child: AnimatedContainer(
                      color: Colors.yellow,
                      height: _isOffset ? 60 : 120,
                      width: _isOffset ? 60 : 120,
                      child: Center(
                        child: Text('Decide!'),
                      ),
                      duration: Duration(milliseconds: 300),
                      curve: Sprung(),
                    ),
                  ),
                ),
              ),
        floatingActionButton: choices.choices.length == 0
            ? FloatingActionButton(
                onPressed: () => _gotoListScreen(context),
                tooltip: 'Add a choice',
                child: Icon(Icons.list),
              )
            : null,
      ),
    );
  }
}
