import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models/Choice.dart';

var uuid = Uuid();

class AddNewDialog extends StatefulWidget {
  // final String id = uuid.v4();
  final Choice choice;

  const AddNewDialog({Key key, this.choice});

  @override
  _AddNewDialogState createState() => _AddNewDialogState();
}

class _AddNewDialogState extends State<AddNewDialog> {
  double _sliderValue = 3.0;
  String _answer;
  TextEditingController _answerController = TextEditingController();

  static List<DropdownMenuItem> _dropdownMenuItems = [
    DropdownMenuItem(value: "What for lunch?", child: Text("What for lunch?")),
    DropdownMenuItem(
        value: "What for dinner?", child: Text("What for dinner?")),
  ];
  String _selectedQuestion = _dropdownMenuItems[0].value;

  // if widget.id == null, then it's adding new entry
  // else, it's editing existing entry

  @override
  void initState() {
    super.initState();
    if (widget.choice == null) {
      print("Add new");
    } else {
      print("Edit existing");
      setState(() {
        _sliderValue = widget.choice.likelihood.toDouble();
        _answer = widget.choice.answer;
        _answerController.text = widget.choice.answer;
        _selectedQuestion = widget.choice.category;
      });
    }
  }

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
                    answer: _answer,
                    likelihood: _sliderValue.toInt(),
                    category: _selectedQuestion,
                    id: widget.choice == null ? uuid.v4() : widget.choice.id,
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
                  _answerController.text = value;
                });
              },
              controller: _answerController,
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
