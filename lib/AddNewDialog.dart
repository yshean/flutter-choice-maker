import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models/Choice.dart';

var uuid = Uuid();

class AddNewDialog extends StatefulWidget {
  // final String id = uuid.v4();
  final String id;

  const AddNewDialog({Key key, this.id});

  @override
  _AddNewDialogState createState() => _AddNewDialogState();
}

class _AddNewDialogState extends State<AddNewDialog> {
  double _sliderValue = 3.0;
  String _answer;

  static List<DropdownMenuItem> _dropdownMenuItems = [
    DropdownMenuItem(value: "What for lunch?", child: Text("What for lunch?")),
    DropdownMenuItem(
        value: "What for dinner?", child: Text("What for dinner?")),
  ];
  String _selectedQuestion = _dropdownMenuItems[0].value;

  // if widget.id == null, then it's adding new entry
  // else, it's editing existing entry

  @override
  Widget build(BuildContext context) {
    if (widget.id == null) {
      print("Add new");
    } else {
      print("Edit existing");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("New Choice"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(
                  context,
                  Choice(
                    answer: _answer,
                    likelihood: _sliderValue.toInt(),
                    category: _selectedQuestion,
                    id: widget.id == null ? uuid.v4() : widget.id,
                  ));
            },
            child: Text("Save"),
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Text(
                  "Question: ",
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(width: 16.0),
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    value: _selectedQuestion,
                    items: _dropdownMenuItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedQuestion = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(height: 32.0),
            Text(
              "What is your answer?",
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
            Container(height: 14.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _answer = value;
                });
              },
              autofocus: true,
              decoration: InputDecoration(
                  // border: InputBorder.none,
                  hintText: 'Your Answer...',
                  hintStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 21.0,
                  )),
            ),
            Container(height: 42.0),
            Text(
              "How likely this answer will be selected?",
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
            Container(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Very Unlikely"),
                Expanded(
                  child: Slider(
                    min: 1.0,
                    max: 5.0,
                    divisions: 4,
                    onChanged: (value) {
                      setState(() => _sliderValue = value);
                    },
                    value: _sliderValue,
                  ),
                ),
                Text("Very Likely"),
              ],
            ),
            Container(height: 14.0),
            Text("Likelihood: ${_sliderValue.toInt()}/5"),
          ],
        ),
      ),
    );
  }
}

/*
Padding(
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
*/

/*
IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("hello"),
                          );
                        });
                  },
                ),
*/
