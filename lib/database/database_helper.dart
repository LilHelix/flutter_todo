import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trello_copycat/model/todo_model.dart';

const String TODO_TABLE_NAME = 'table_todo';

class TodoProvider {
  Database db;

  Future open() async {
    await Sqflite.devSetDebugModeOn(true);
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "demo.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $TODO_TABLE_NAME ( 
            $COLUMN_ID integer primary key autoincrement, 
            $COLUMN_TEXT text not null,
            $COLUMN_DATE integer,
            $COLUMN_STATE integer not null)
      ''');
    });
  }

  Future<Todo> createNewTodo(Todo todo) async {
    todo.id = await db.insert(TODO_TABLE_NAME, todo.toSerializable());
    return todo;
  }

  Future<List<Todo>> getPending() async {
    List<Map<String, dynamic>> maps = await db.query(
        TODO_TABLE_NAME,
        where: '$COLUMN_STATE = ${TodoType.PENDING.index}',
        orderBy: '$COLUMN_DATE ASC'
    );
    return maps.map((Map<String, dynamic> map) => Todo.fromMap(map)).toList();
  }

  Future<int> delete(Todo todo) async {
    return await db.transaction((txn) async {
      return await txn.delete(TODO_TABLE_NAME, where: "$COLUMN_ID = ?", whereArgs: [todo.id]);
    });
  }

//  Future<int> update(Todo todo) async {
//    return await db.update(tableTodo, todo.toMap(),
//        where: "$columnId = ?", whereArgs: [todo.id]);
//  }

  Future close() async => db.close();
}
