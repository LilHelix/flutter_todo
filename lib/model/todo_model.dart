const String COLUMN_ID = 'id';
const String COLUMN_TEXT = 'text';
const String COLUMN_DATE = 'date';
const String COLUMN_STATE = 'state';

class Todo {
  int id;
  String text;
  DateTime expirationDate;
  TodoType type;

  Todo();

  Map<String, dynamic> toSerializable() {
    var map = <String, dynamic>{
      COLUMN_TEXT: text,
      COLUMN_DATE: expirationDate.millisecondsSinceEpoch,
      COLUMN_STATE: type.index
    };
    if (id != null) {
      map[COLUMN_ID] = id;
    }
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[COLUMN_ID];
    text = map[COLUMN_TEXT];
    expirationDate = DateTime.fromMillisecondsSinceEpoch(map[COLUMN_DATE]);
    type = TodoType.values[map[COLUMN_STATE]];
  }

}

enum TodoType {
  PENDING,
  SKIPPED,
  DONE
}