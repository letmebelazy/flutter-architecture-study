import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';

abstract class TodoRepository {
  List<Todo> getAllTodos();

  void addTodo(String newTitle);

  void editTodo(int index, String newTitle);

  void toggleTodo(int index);
}
