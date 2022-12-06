import 'package:intl/intl.dart';
import '../models/todo.dart';

// TodoModelMVC와 동일
class TodoModelMVC2 {
  List<Todo> todos = [];

  void addTodo(String newTitle) {
    todos.add(Todo(title: newTitle));
  }

  void editTodo(int index, String newTitle) {
    todos[index].title = newTitle;
    todos[index].createdAt =
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
  }

  void toggleTodo(int index) {
    todos[index].isDone = !todos[index].isDone;
  }
}
