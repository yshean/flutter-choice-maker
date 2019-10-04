import 'package:flutter/material.dart';

import 'models/Choice.dart';

class AddNewDialog extends StatefulWidget {
  const AddNewDialog({Key key});

  @override
  _AddNewDialogState createState() => _AddNewDialogState();
}

class _AddNewDialogState extends State<AddNewDialog> {
  double _sliderValue = 5.0;

  static List<DropdownMenuItem> _dropdownMenuItems = [
    DropdownMenuItem(value: "What for lunch?", child: Text("What for lunch?")),
    DropdownMenuItem(
        value: "What for dinner?", child: Text("What for dinner?")),
  ];
  String _selectedCategory = _dropdownMenuItems[0].value;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.description), labelText: "Answer"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your answer";
                }
                return null;
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Icon(Icons.favorite),
                  ),
                  Text("0"),
                  Expanded(
                    child: Slider(
                      label: "Likelihood",
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      onChanged: (value) {
                        setState(() => _sliderValue = value);
                      },
                      value: _sliderValue,
                    ),
                  ),
                  Text("10"),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                value: _selectedCategory,
                items: _dropdownMenuItems,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
