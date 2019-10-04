import 'package:flutter/material.dart';

import 'models/Choice.dart';

class AddNewDialog extends StatelessWidget {
  const AddNewDialog({Key key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Choice"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(
                  context,
                  Choice(
                      answer: "Bintang",
                      percentage: 50,
                      category: "What for lunch?"));
            },
            child: Text("Save"),
          ),
        ],
      ),
      body: Text("Form here"),
    );
  }
}
