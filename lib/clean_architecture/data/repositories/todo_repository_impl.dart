import 'package:architecture_patterns/clean_architecture/data/datasource/local_datasource.dart';
import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';
import 'package:architecture_patterns/clean_architecture/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final LocalDatasourse datasource;

  TodoRepositoryImpl({required this.datasource});

  @override
  void addTodo(String newTitle) {
    datasource.addTodo(newTitle);
  }

  @override
  void editTodo(int index, String newTitle) {
    datasource.editTodo(index, newTitle);
  }

  @override
  List<Todo> getAllTodos() {
    return datasource.todos;
  }

  @override
  void toggleTodo(int index) {
    datasource.toggleTodo(index);
  }
}
