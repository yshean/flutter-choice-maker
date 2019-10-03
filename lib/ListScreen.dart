import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// import 'PwdRowWidget.dart';
import 'models/Choice.dart';
import 'ChoiceRowWidget.dart';

class ListScreen extends StatelessWidget {
  final List<Choice> entries;
  final List<Choice> filteredEntries = [];

  Map result = {};
  List<Widget> finalList = [Text("Hello")];

  ListScreen({Key key, this.entries}) {
    // loop through categories
    // use contains() to check if item belongs to the category
    Set categories = new Set.from(entries.map((v) => v.category));
    // print(categories);

    for (var cat in categories) {
      result[cat] = entries.where((entry) => (entry.category == cat));
    }
    // print(result);

    // finalList = _buildList(result);
    finalList = [Text("hi")];
    // print(finalList);

    // filteredEntries.add(Choice(category: "A", answer: "AAA", percentage: 50));
  }

  void btnLaunchTouched(int index) async {
    String answer = filteredEntries[index].answer;
    print("btn launch" + answer);
  }

  void btnDeleteTouched(int index) async {
    String answer = filteredEntries[index].answer;
    print("btn delete" + answer);
  }

  _gotoAddScreen(BuildContext context) async {
    print("go to add screen");
  }

  List<Widget> _buildList(Map res) {
    List<Widget> list = new List<Widget>();
    var resKeys = res.keys.toList();

    for (var category in resKeys) {
      list.add(new StickyHeader(
          header: new Container(
            height: 40.0,
            color: Colors.grey.shade100,
            padding: new EdgeInsets.symmetric(horizontal: 15.0),
            alignment: Alignment.centerLeft,
            child: Text(
              category,
              // style: Theme.of(context).textTheme.body1,
            ),
          ),
          content: ListView.separated(
            itemCount: res[category].length,
            itemBuilder: (BuildContext context, int index) {
              return res[category].map((choice) => GestureDetector(
                      child: Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.indigo,
                        icon: Icons.edit,
                        onTap: () => btnLaunchTouched(index),
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => btnDeleteTouched(index),
                      ),
                    ],
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),
                    child: ChoiceRowWidget(
                      choiceEntry: choice,
                    ),
                  )));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(color: Color.fromRGBO(108, 123, 138, 0.2)),
          )));
    }

    // print(list);
    return list;
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

    // return Column(children: finalList);
    return ListView.builder(
        itemCount: result.keys.toList().length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              child: Slidable(
            key: ValueKey(index),
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: Colors.indigo,
                icon: Icons.edit,
                onTap: () => btnLaunchTouched(index),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => btnDeleteTouched(index),
              ),
            ],
            dismissal: SlidableDismissal(
              child: SlidableDrawerDismissal(),
            ),
            child: ChoiceRowWidget(
              choiceEntry:
                  Choice(answer: "YS", percentage: 99.0, category: "A"),
            ),
          ));
        });
  }
}
