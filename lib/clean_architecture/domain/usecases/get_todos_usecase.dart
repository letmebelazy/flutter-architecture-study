import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';
import 'package:architecture_patterns/clean_architecture/domain/repositories/todo_repository.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/usecase.dart';

class GetTodosUsecase implements Usecase {
  final TodoRepository _repository;

  GetTodosUsecase(this._repository);

  List<Todo> call() {
    return _repository.getAllTodos();
  }
}
