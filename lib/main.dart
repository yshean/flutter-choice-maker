import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'stores/choices.dart'; // import the Counter
import 'ListScreen.dart';

final store = Choices(); // instantiate the store

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Choices>.value(
      value: store,
      child: MaterialApp(
        title: 'Decision Maker',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.yellow,
        ),
        home: MyHomePage(title: 'Choices List'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Choices choices = Provider.of<Choices>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ListScreen(
      // entries: [
      //   Choice(answer: "111", likelihood: 3, category: "What for lunch?"),
      //   Choice(
      //       answer: "Big Big Wantan",
      //       likelihood: 4,
      //       category: "What for lunch?"),
      //   Choice(
      //       answer: "Korean BBQ", likelihood: 5, category: "What for dinner?"),
      // ],
      entries: choices.choices,
    );
  }
}
