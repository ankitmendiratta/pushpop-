import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import './note.dart';
import './datebase_helper.dart';
import 'package:sqflite/sqflite.dart';

class MyNodeList extends StatefulWidget {
  final String appbartitle;
  final Note note;
  MyNodeList(this.note, this.appbartitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NodeDetailState(this.note, this.appbartitle);
  }
}

class NodeDetailState extends State<MyNodeList> {
  String appbartitle;
  Note note;
  NodeDetailState(this.note, this.appbartitle);

  var priorities = ['High', 'Low'];
  DatebaseHelper databaseHelper = DatebaseHelper();
  TextEditingController titlecont = TextEditingController();
  TextEditingController desccont = TextEditingController();

  var valueSelectedByUser = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titlecont.text = note.title;
    desccont.text = note.description;
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appbartitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }),
          ),
          body: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: DropdownButton(
                      items: priorities.map((String dropdownitm) {
                        return DropdownMenuItem<String>(
                          value: dropdownitm,
                          child: Text(dropdownitm),
                        );
                      }).toList(),
                      style: textStyle,
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('USer selected $valueSelectedByUser');
                          updatePriorityAsInt(valueSelectedByUser);
                        });
                      },
                      value: getPriorityAsString(note.priorirty),
                    ),
                  ),

                  //Second Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: titlecont,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Somrthing changed for title');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),

                  //Third Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: desccont,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Somrthing changed for desc');
                        updateDescription();
                      },
                      decoration: InputDecoration(
                          labelText: 'Decription',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),

                  //Fourth Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              debugPrint('Save Pressed');
                              _save();
                            });
                          },
                        )),
                        Container(width: 5.0),
                        Expanded(
                            child: RaisedButton(
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              debugPrint('Delete Pressed');
                              _deleteNote();
                            });
                          },
                        ))
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

//convert tring priority into integer efore saving into db
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priorirty = 1;
        break;

      case 'Low':
        note.priorirty = 2;
        break;
    }
  }

  //convert int priority to string  priority and display under dropdown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0];
        break;

      case 2:
        priority = priorities[1];
        break;
    }
  }

  void updateTitle() {
    note.title = titlecont.text;
  }

  void updateDescription() {
    note.description = desccont.text;
  }

  void _save() async {
    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await databaseHelper.updateNote(note);
    } else {
      result = await databaseHelper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note save successfull');
    } else {
      _showAlertDialog('Status', 'Problem saving notes');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _deleteNote() async {
    moveToLastScreen();
    if (note.id == null) {
      _showAlertDialog('Status', 'No note deleted');
      return;
    }

    int result = await databaseHelper.deleteeNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'note deleted successfully');
    } else {
      _showAlertDialog('Status', 'error on deleted');
    }
  }
}
