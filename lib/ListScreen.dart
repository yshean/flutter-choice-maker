import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// import 'PwdRowWidget.dart';
import 'models/Choice.dart';
import 'ChoiceRowWidget.dart';

class ListScreen extends StatelessWidget {
  final List<Choice> entries;
  final Map _result = {};

  ListScreen({Key key, this.entries}) {
    // Create a set of (unique) categories
    Set categories = Set.from(entries.map((v) => v.category));

    // Sort entries according to percentage
    entries.sort((Choice a, Choice b) => b.percentage.compareTo(a.percentage));

    for (var cat in categories) {
      _result[cat] = entries.where((entry) => (entry.category == cat));
    }
  }

  // need to replace index with the item ID (need to be created)
  void btnLaunchTouched(String id) async {
    print("btn launch" + id);
  }

  void btnDeleteTouched(String id) async {
    print("btn delete" + id);
  }

  _gotoAddScreen(BuildContext context) async {
    print("go to add screen");
  }

  List<Widget> _buildList(String category) {
    List<Widget> arr = List<Widget>();
    // var resKeys = result.keys.toList();

    // for (var category in resKeys) {
    for (var i = 0; i < _result[category].length; i++) {
      var choice = _result[category].toList()[i];
      arr.add(GestureDetector(
          child: Slidable(
        key: ValueKey(choice.id),
        actionPane: SlidableDrawerActionPane(),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.indigo,
            icon: Icons.edit,
            onTap: () => btnLaunchTouched(choice.id),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => btnDeleteTouched(choice.id),
          ),
        ],
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
        ),
        child: ChoiceRowWidget(
          choiceEntry: choice,
        ),
      )));
    }

    return arr.toList();
  }

  @override
  Widget build(BuildContext context) {
    if (entries.length == 0) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/no_entries.png'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Nothing here yet. Add one?',
                  style: Theme.of(context).textTheme.title,
                ),
              )
            ],
          ),
        ),
      );
    }

    return ListView.builder(
        itemCount: _result.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var category = _result.keys.toList()[index];
          return StickyHeader(
              header: Container(
                height: 40.0,
                color: Colors.grey.shade100,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              content: Column(children: _buildList(category)));
        });
  }
}
