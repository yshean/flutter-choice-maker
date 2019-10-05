import 'package:choice_maker/AddNewDialog.dart';
import 'package:choice_maker/stores/choices.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

// import 'PwdRowWidget.dart';
import 'models/Choice.dart';
import 'ChoiceRowWidget.dart';

class ListScreen extends StatelessWidget {
  final List<Choice> entries;
  final Map _result = {};

  ListScreen({Key key, this.entries}) {
    // Create a set of (unique) categories
    Set categories = Set.from(entries.map((v) => v.category));

    // Sort entries according to likelihood
    entries.sort((Choice a, Choice b) => b.likelihood.compareTo(a.likelihood));

    for (var cat in categories) {
      _result[cat] = entries.where((entry) => (entry.category == cat));
    }
  }

  // need to replace index with the item ID (need to be created)
  void btnEditTouched(BuildContext context, Choice choice, editChoice) async {
    print("btn edit" + choice.id);
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

  void btnDeleteTouched(String id) async {
    print("btn delete" + id);
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

  List<Widget> _buildList(BuildContext context, String category, editChoice) {
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
            onTap: () => btnEditTouched(context, choice, editChoice),
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
    final Choices choices = Provider.of<Choices>(context);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Choice List"),
      ),
      body: entries.length == 0
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
                  itemCount: _result.keys.length,
                  itemBuilder: (BuildContext ctx, int index) {
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
                        content: Column(
                            children: _buildList(
                                context, category, choices.editChoice)));
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _gotoAddScreen(context, choices.addChoice),
        tooltip: 'Add a choice',
        child: Icon(Icons.add),
      ),
    );
  }
}
