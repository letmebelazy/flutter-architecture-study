part of 'todo_bloc.dart';

abstract class TodoCleanEvent extends Equatable {
  const TodoCleanEvent();

  @override
  List<Object> get props => [];
}

class GetTodosEvent extends TodoCleanEvent {}

class AddTodoEvent extends TodoCleanEvent {
  final String newTitle;

  const AddTodoEvent({required this.newTitle});
}

class EditTodoEvent extends TodoCleanEvent {
  final int index;
  final String newTitle;

  const EditTodoEvent({required this.index, required this.newTitle});
}

class ToggleTodoEvent extends TodoCleanEvent {
  final int index;

  const ToggleTodoEvent({required this.index});
}
