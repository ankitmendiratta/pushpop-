import 'package:flutter/material.dart';
import './nodelist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(title: 'My Data', home: MyList());
  }
}
