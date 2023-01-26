import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';

class LocalDatasourse {
  static final LocalDatasourse _instance = LocalDatasourse._init();

  LocalDatasourse._init();

  factory LocalDatasourse() {
    return _instance;
  }

  List<Todo> todos = [];

  void addTodo(String newTitle) {
    Todo newTodo = Todo(title: newTitle);
    todos.add(newTodo);
  }

  void editTodo(int index, String newTitle) {
    todos[index] = Todo(title: newTitle);
  }

  void toggleTodo(int index) {
    todos[index].isDone = !todos[index].isDone;
  }
}
