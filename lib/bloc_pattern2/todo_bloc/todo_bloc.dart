import 'package:architecture_patterns/bloc_pattern2/todo_model.dart';
import 'package:architecture_patterns/models/todo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoModelBloc2 model;

  TodoBloc(this.model) : super(TodoState.init(model)) {
    on<AddEvent>((event, emit) {
      model.addTodo(event.newTitle);
      emit(state.copyWith(model.todos));
    });

    on<EditEvent>((event, emit) {
      model.editTodo(event.index, event.newTitle);
      emit(state.copyWith(model.todos));
    });

    on<ToggleEvent>((event, emit) {
      model.toggleTodo(event.index);
    });
  }
}
