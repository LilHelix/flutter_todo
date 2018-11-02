import 'package:flutter/material.dart';
import 'package:trello_copycat/database/database_helper.dart';
import 'package:trello_copycat/model/todo_model.dart';
import 'package:trello_copycat/utils/utils.dart';

class NewTodoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoState();
}

class TodoState extends State<NewTodoWidget> {
  TodoProvider databaseProvider = new TodoProvider();
  String _todoText;

  static DateTime _defaultDate = DateTime.now().add(Duration(hours: 1));

  DateTime _selectedDate = _defaultDate;
  TimeOfDay _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New to-do'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveTodo();
              },
              tooltip: 'Save to-do',
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please enter your todo',
                    hintStyle:
                        TextStyle(fontSize: 24.0, color: Colors.black54)),
                onChanged: (String text) => _todoTextChanged(text),
                style: TextStyle(fontSize: 24.0, color: Colors.black),
                autofocus: true,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
                    child: OutlineButton(
                        shape: StadiumBorder(),
                        borderSide: BorderSide(color: Colors.blue),
                        onPressed: () => _selectDate(),
                        child: Text('Select date'))),
                Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                    child: Text(_selectedDate != null
                        ? DateUtils.reformatDateToReadable(_selectedDate)
                        : ''))
              ],
            )
          ],
        ));
  }

  _saveTodo() {
    Todo todo = new Todo();
    todo.expirationDate = _selectedDate != null
        ? _selectedDate
        : DateTime.now().add(Duration(hours: 1));
    todo.type = TodoType.PENDING;
    todo.text = _todoText;
    databaseProvider
        .open()
        .then((any) => databaseProvider.createNewTodo(todo))
        .whenComplete(() => databaseProvider.close())
        .whenComplete(() => Navigator.of(context).pop());
  }

  _todoTextChanged(String text) {
    _todoText = text;
  }

  _selectDate() async {
    _selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(hours: 2)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (_selectedDate != null) {
      _selectedTime = await showTimePicker(
          context: context, initialTime: TimeOfDay(hour: 12, minute: 0));
    }
    if (_selectedTime != null) {
      _selectedDate = _selectedDate.add(
          Duration(hours: _selectedTime.hour, minutes: _selectedTime.minute));
    }
    setState(() {});
  }

}
