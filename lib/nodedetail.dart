import 'package:flutter/material.dart';

class MyNodeList extends StatefulWidget {
  String appbartitle;
  MyNodeList(this.appbartitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NodeDetailState(this.appbartitle);
  }
}

class NodeDetailState extends State<MyNodeList> {
  String appbartitle;
  NodeDetailState(this.appbartitle);

  var priorities = ['High', 'Low'];
  TextEditingController titlecont = TextEditingController();
  TextEditingController desccont = TextEditingController();

  var valueSelectedByUser = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

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
                      value: 'Low',
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('USer selected $valueSelectedByUser');
                        });
                      },
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
    Navigator.pop(context);
  }
}
