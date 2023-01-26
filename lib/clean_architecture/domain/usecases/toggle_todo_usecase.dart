import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';
import 'package:architecture_patterns/clean_architecture/domain/repositories/todo_repository.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/usecase.dart';

class ToggleTodoUsecase implements Usecase {
  final TodoRepository _repository;

  ToggleTodoUsecase(this._repository);

  List<Todo> call(int index) {
    _repository.toggleTodo(index);
    return _repository.getAllTodos();
  }
}
