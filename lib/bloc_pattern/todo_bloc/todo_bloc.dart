import 'dart:async';

import 'package:architecture_patterns/bloc_pattern/todo_model.dart';
import 'package:equatable/equatable.dart';
import '../../models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc {
  final TodoModelBloc model;
  late TodoState state;

  TodoBloc({required this.model}) {
    state = TodoState.init(model.todos);
  }

  final StreamController<TodoState> _todoListController =
      StreamController<TodoState>();

  Stream<TodoState> get todoList => _todoListController.stream;

  void listenEvent(TodoEvent event) {
    if (event is AddEvent) {
      model.addTodo(event.newTitle);
    }

    if (event is EditEvent) {
      model.editTodo(event.index, event.newTitle);
    }

    if (event is ToggleEvent) {
      model.toggleTodo(event.index);
    }

    _todoListController.sink.add(state.copyWith(model.todos));
  }
}
