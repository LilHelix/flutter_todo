import 'package:flutter/material.dart';
import 'package:trello_copycat/model/tabbar_settings.dart';

final tabbarSettings = TabbarSettings.defaultImpl();

void main() => runApp(new TrelloCopycatApp());

class TrelloCopycatApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Task manager',
      home: MainScreenWidget(),
    );
  }
}

class MainScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreenWidget> {

  static const ITEM_SKIPPED = 0;
  static const ITEM_TODO = 1;
  static const ITEM_DONE = 2;

  int _currentIndex = ITEM_TODO;

  @override
  Widget build(BuildContext context) {
    TabbarItem item = tabbarSettings.getItemByIndex(_currentIndex);
    return new Scaffold(
      body: item.widget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: tabbarSettings.getBottomItems(),
        currentIndex: _currentIndex,
        onTap: (int index) => onTabTapped(index),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
