import 'package:flutter/material.dart';
import './nodedetail.dart';

class MyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();
  }
}

class NoteListState extends State<MyList> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('button pressed');
          navigatetoDetail('Add Note');
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
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                'Dummy tile',
                style: titlestyle,
              ),
              subtitle: Text(
                'Dummy date',
                style: titlestyle,
              ),
              trailing: Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                debugPrint('List title pressed');
                navigatetoDetail('Edit Note');
              },
            ),
          );
        });
  }

  void navigatetoDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyNodeList(title);
    }));
  }
}
