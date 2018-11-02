import 'package:flutter/material.dart';
import 'package:trello_copycat/database/database_helper.dart';
import 'package:trello_copycat/model/todo_model.dart';
import 'package:trello_copycat/utils/utils.dart';

const TRANSPARENT_GREEN = Color.fromARGB(26, 0, 191, 0);

class PendingTodoListWidget extends StatefulWidget {
  List<Todo> _items;

  PendingTodoListWidget(this._items);

  @override
  State<StatefulWidget> createState() => PendingTodoListState(_items);
}

class PendingTodoListState extends State<PendingTodoListWidget> {
  List<Todo> _items;
  TodoProvider _todoProvider;

  PendingTodoListState(this._items) {
    _todoProvider = TodoProvider();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: 2 * _items.length - 1,
        itemBuilder: (BuildContext ctx, int index) {
          if (index.isOdd) return Divider(height: 1.0);
          var todo = _items[index ~/ 2];
          return Container(
              color: index == 0 ? TRANSPARENT_GREEN : Colors.transparent,
              child: BasePendingTodoTile(todo, (Todo todo) => _deleteTodo(todo),
                  (Todo todo) => _markTodoAsDone(todo)));
        });
  }

  _deleteTodo(Todo todo) {
    _todoProvider
        .open()
        .then((any) => _todoProvider.delete(todo))
        .whenComplete(() => _onDeleteSuccess(todo))
        .then((any) => _todoProvider.close());
  }

  _onDeleteSuccess(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  _markTodoAsDone(Todo todo) {}

  _onError() {}
}

class BasePendingTodoTile extends Column {
  Todo _todo;

  Function(Todo todo) _onDoneTapped;
  Function(Todo todo) _onDeleteTapped;

  BasePendingTodoTile(this._todo, this._onDeleteTapped, this._onDoneTapped);

  get children {
    return <Widget>[
      ListTile(
        leading: Icon(Icons.add_alarm),
        title: Text(_todo.text),
        subtitle: Text(DateUtils.reformatDateToReadable(_todo.expirationDate)),
      ),
      ButtonTheme.bar(
          child: ButtonBar(
        children: <Widget>[
          OutlineButton(
              shape: StadiumBorder(),
              borderSide: BorderSide(color: Colors.redAccent),
              onPressed: () => _deleteThisTodo(_todo),
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              )),
          OutlineButton(
              shape: StadiumBorder(),
              borderSide: BorderSide(color: Colors.green),
              onPressed: () => _moveTodoToDone(_todo),
              child: Text(
                'Mark as done',
                style: TextStyle(color: Colors.green),
              )),
        ],
      ))
    ];
  }

  _moveTodoToDone(Todo todo) {
    _onDoneTapped(todo);
  }

  _deleteThisTodo(Todo todo) {
    _onDeleteTapped(todo);
  }
}
