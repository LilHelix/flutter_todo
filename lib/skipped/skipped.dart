import 'package:flutter/material.dart';

class SkippedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SkippedState();

}

class SkippedState extends State<SkippedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Skipped'),
      ),
      body: Column(),
    );
  }
}