import 'package:choice_maker/AddNewDialog.dart';
import 'package:choice_maker/stores/choices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'models/Choice.dart';
import 'ChoiceRowWidget.dart';

class ListScreen extends StatelessWidget {
  void btnEditTouched(BuildContext context, Choice choice, editChoice) async {
    print("btn edit " + choice.id);
    // similar to add
    // but populate the selected id's data

    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewDialog(choice: choice)),
    ) as Choice;
    if (data != null) {
      print('Id ${data.id} was edited!');
      editChoice(data);
    }
  }

  void btnDeleteTouched(Choice choice, deleteChoice) {
    print("btn delete " + choice.id);
    deleteChoice(choice.id);
    // choices.removeWhere((item) => item.id == choice.id);
    // setState(() {});
  }

  _gotoAddScreen(BuildContext context, addChoice) async {
    print("go to add screen");
    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewDialog()),
    ) as Choice;

    if (data != null) {
      // Utils.showPopup(context, 'INFO', '${data.name} saved successfully!');
      print('${data.answer} of id ${data.id} is saved successfully!');
      addChoice(data);
      // entries = await userSrv.getListPwds();
      // setState(() {
      //   filteredEntries = entries;
      // });
    }
  }

  List<Widget> _buildList(BuildContext context, String category, editChoice,
      Map<String, List<Choice>> result, deleteChoice) {
    List<Widget> arr = List<Widget>();
    // var resKeys = result.keys.toList();

    // for (var category in resKeys) {
    for (var i = 0; i < result[category].length; i++) {
      Choice choice = result[category][i];
      arr.add(GestureDetector(
          child: Slidable(
        key: ValueKey(choice.id),
        actionPane: SlidableDrawerActionPane(),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.indigo,
            icon: Icons.edit,
            onTap: () => btnEditTouched(context, choice, editChoice),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => btnDeleteTouched(choice, deleteChoice),
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
    final Choices choices = Provider.of<Choices>(context);
    print("Choices length: " + choices.choices.length.toString());

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Choice List"),
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
                          'Nothing here yet. Add one?',
                          style: Theme.of(context).textTheme.title,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: ListView.builder(
                    itemCount: choices.choicesMap.keys.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      var category = choices.choicesMap.keys.toList()[index];
                      var catItems = choices.choices
                          .where((ch) => ch.category == category);
                      if (catItems.length == 0) {
                        return SizedBox.shrink();
                      }
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
                          content: Observer(
                            builder: (_) => Column(
                                children: _buildList(
                                    context,
                                    category,
                                    choices.editChoice,
                                    choices.choicesMap,
                                    choices.deleteChoice)),
                          ));
                    }),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _gotoAddScreen(context, choices.addChoice),
          tooltip: 'Add a choice',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
