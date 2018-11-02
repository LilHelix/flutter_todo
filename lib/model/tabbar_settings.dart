import 'package:flutter/material.dart';
import 'package:trello_copycat/done/done.dart';
import 'package:trello_copycat/skipped/skipped.dart';
import 'package:trello_copycat/todo/todo.dart';

class TabbarItem {
  Widget widget;
  BottomNavigationBarItem bottomNavigationBarItem;

  TabbarItem(this.widget, this.bottomNavigationBarItem);
}

class TabbarSettings {
  List<TabbarItem> items;

  TabbarSettings.defaultImpl() {
    items = List();
    items.add(TabbarItem(
        SkippedWidget(),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_late), title: Text('Skipped'))));
    items.add(TabbarItem(
        TodoWidget(),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm), title: Text('To-do'))));
    items.add(TabbarItem(
        DoneWidget(),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in), title: Text('Done'))));
  }

  List<BottomNavigationBarItem> getBottomItems() {
    return items.map((TabbarItem t) => t.bottomNavigationBarItem).toList();
  }

  getItemByIndex(int currentIndex) {
    return items[currentIndex];
  }

  getScreenByIndex(int currentIndex) {
    return items[currentIndex].widget;
  }
}
