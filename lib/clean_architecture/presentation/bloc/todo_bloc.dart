import 'package:architecture_patterns/clean_architecture/data/datasource/local_datasource.dart';
import 'package:architecture_patterns/clean_architecture/data/repositories/todo_repository_impl.dart';
import 'package:architecture_patterns/clean_architecture/domain/entities/todo.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/add_todo_usecase.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/edit_todo_usecase.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/get_todos_usecase.dart';
import 'package:architecture_patterns/clean_architecture/domain/usecases/toggle_todo_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoCleanBloc extends Bloc<TodoCleanEvent, TodoCleanState> {
  // 원래는 이렇게 직접적으로 생성해서 쓰면 안 됨(합성보다 집약이 좋음) - 라이프타임이 종속되며 의존성이 생기기 때문
  // 의존성 주입 패키지를 사용하지 않고 간단히 해결하기 위해 부득이하게 클래스 내에서 초기화
  final GetTodosUsecase getTodosUsecase =
      GetTodosUsecase(TodoRepositoryImpl(datasource: LocalDatasourse()));
  final AddTodoUsecase addTodoUsecase =
      AddTodoUsecase(TodoRepositoryImpl(datasource: LocalDatasourse()));
  final EditTodoUsecase editTodoUsecase =
      EditTodoUsecase(TodoRepositoryImpl(datasource: LocalDatasourse()));
  final ToggleTodoUsecase toggleTodoUsecase =
      ToggleTodoUsecase(TodoRepositoryImpl(datasource: LocalDatasourse()));

  TodoCleanBloc() : super(TodoCleanState.init()) {
    on<GetTodosEvent>((event, emit) {
      emit(state.copyWith(todos: getTodosUsecase()));
    });

    on<AddTodoEvent>((event, emit) {
      emit(state.copyWith(todos: addTodoUsecase(event.newTitle)));
    });

    on<EditTodoEvent>((event, emit) {
      emit(state.copyWith(todos: editTodoUsecase(event.index, event.newTitle)));
    });

    on<ToggleTodoEvent>((event, emit) {
      emit(state.copyWith(todos: toggleTodoUsecase(event.index)));
    });
  }
}
