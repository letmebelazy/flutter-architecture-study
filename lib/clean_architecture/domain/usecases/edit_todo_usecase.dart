import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';
import 'package:architecture_patterns/clean_architecture/domain/repositories/todo_repository.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/usecase.dart';

class EditTodoUsecase implements Usecase {
  final TodoRepository _repository;

  EditTodoUsecase(this._repository);

  List<Todo> call(int index, String newTitle) {
    _repository.editTodo(index, newTitle);
    return _repository.getAllTodos();
  }
}
