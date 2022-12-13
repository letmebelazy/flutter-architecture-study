import 'package:architecture_patterns/mvp_pattern/interfaces.dart';
import 'package:architecture_patterns/mvp_pattern/todo_model.dart';
import '../models/todo.dart';

class TodoPresenterImpl implements TodoPresenter {
  @override
  TodoModelMVP model;
  @override
  List<Todo> todos = [];
  late TodoView view;

  TodoPresenterImpl({required this.model}) : todos = model.todos;

  @override
  void setView(view) {
    this.view = view;
    view.refreshView(model);
  }

  @override
  void addTodo(String newTitle) {
    model.todos.add(Todo(title: newTitle));
    view.refreshView(model);
  }

  @override
  void editTodo(int index, String newTitle) {
    model.todos[index].title = newTitle;
    view.refreshView(model);
  }

  @override
  void toggleTodo(int index) {
    model.todos[index].isDone = !model.todos[index].isDone;
    view.refreshView(model);
  }
}
