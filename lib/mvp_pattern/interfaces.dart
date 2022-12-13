import 'package:architecture_patterns/mvp_pattern/todo_model.dart';

abstract class TodoView {
  void refreshView(TodoModelMVP model);
}

abstract class TodoPresenter {
  late TodoModelMVP model;
  void setView(TodoView view);
  void addTodo(String newTitle);
  void editTodo(int index, String newTitle);
  void toggleTodo(int index);
}
