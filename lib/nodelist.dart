import 'package:flutter/material.dart';
import './nodedetail.dart';
import 'dart:async';
import './note.dart';
import './datebase_helper.dart';
import 'package:sqflite/sqflite.dart';

class MyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();
  }
}

class NoteListState extends State<MyList> {
  int count = 0;

  DatebaseHelper databaseHelper = DatebaseHelper();
  List<Note> noteList;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('button pressed');
          navigatetoDetail(Note('', '', 2), 'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getListView() {
    TextStyle titlestyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getprioritycolor(this.noteList[position].priorirty),
                child: getPriorityIcon(this.noteList[position].priorirty),
              ),
              title: Text(
                this.noteList[position].title,
                style: titlestyle,
              ),
              subtitle: Text(
                this.noteList[position].date,
                style: titlestyle,
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.grey),
                onTap: () {
                  _delete(context, noteList[position]);
                },
              ),
              onTap: () {
                debugPrint('List title pressed');
                navigatetoDetail(this.noteList[position], 'Edit Note');
              },
            ),
          );
        });
  }

//Return the priority color
  Color getprioritycolor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;

      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

//Return e priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  //Delete
  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteeNote(note.id);
    if (result != 0) {
      _showSnakeBar(context, 'ote delete successfully');
      updateListView();
    }
  }

  void _showSnakeBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void navigatetoDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyNodeList(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFututre = databaseHelper.initializeDatbase();
    dbFututre.then((database) {
      Future<List<Note>> notelistfuture = databaseHelper.getNoteList();
      notelistfuture.then((noteLisi) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
