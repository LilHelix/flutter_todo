import 'package:flutter/material.dart';
import 'package:trello_copycat/database/database_helper.dart';
import 'package:trello_copycat/model/todo_model.dart';
import 'package:trello_copycat/new_todo.dart';
import 'package:trello_copycat/todo/todo_list.dart';

class TodoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoState();
}

class TodoState extends State<TodoWidget> {
  TodoProvider provider = TodoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: Text(
            'To-do',
            style: TextStyle(color: Colors.black),
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
        onPressed: () => _addTodo(context),
      ),
      body: Center(
        child: FutureBuilder(
          future: provider.open()
            .then((dynamic) => provider.getPending())
            .whenComplete(() => provider.close()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Todo> todos = snapshot.data;
              return PendingTodoListWidget(todos);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  _addTodo(BuildContext passedContext) {
    Navigator.push(passedContext,
        MaterialPageRoute(builder: (context) => NewTodoWidget()));
  }

}
