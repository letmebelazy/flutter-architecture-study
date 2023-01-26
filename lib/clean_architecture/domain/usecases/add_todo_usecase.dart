import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';
import 'package:architecture_patterns/clean_architecture/domain/repositories/todo_repository.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/usecase.dart';

class AddTodoUsecase implements Usecase {
  final TodoRepository _repository;

  AddTodoUsecase(this._repository);

  List<Todo> call(String newTitle) {
    _repository.addTodo(newTitle);
    return _repository.getAllTodos();
  }
}
