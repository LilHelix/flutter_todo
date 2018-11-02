import 'package:flutter/material.dart';

class DoneWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DoneState();

}

class DoneState extends State<DoneWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text('Done', style: TextStyle(color: Colors.black)),
      ),
      body: Column(),
    );
  }
}