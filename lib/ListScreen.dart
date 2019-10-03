import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// import 'PwdRowWidget.dart';
import 'models/Choice.dart';
import 'ChoiceRowWidget.dart';

class ListScreen extends StatelessWidget {
  final List<Choice> filteredEntries;

  const ListScreen({Key key, this.filteredEntries});
  // final List<Pwd> filteredEntries = [
  //   Pwd(
  //       name: "YS",
  //       email: "yshean@gmail.com",
  //       url: "dd",
  //       password: "gfgfg",
  //       notes: "jjjj"),
  //   Pwd(
  //       name: "Ferrick",
  //       email: "ferrick@email.com",
  //       url: "dd",
  //       password: "gfgf",
  //       notes: "kkk")
  // ];

  void btnLaunchTouched(int index) async {
    String answer = filteredEntries[index].answer;
    print("btn launch" + answer);
  }

  void btnDeleteTouched(int index) async {
    String answer = filteredEntries[index].answer;
    print("btn launch" + answer);
  }

  _gotoAddScreen(BuildContext context) async {
    print("go to add screen");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: filteredEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: new StickyHeader(
            header: new Container(
              height: 40.0,
              color: Colors.grey.shade100,
              padding: new EdgeInsets.symmetric(horizontal: 15.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'ALL',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            content: Slidable(
              key: ValueKey(index),
              actionPane: SlidableDrawerActionPane(),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Launch',
                  color: Colors.indigo,
                  icon: Icons.launch,
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
                choiceEntry: filteredEntries[index],
              ),
            ),
          ),
          onTap: () => _gotoAddScreen(
            context,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(color: Color.fromRGBO(108, 123, 138, 0.2)),
    );
  }
}
