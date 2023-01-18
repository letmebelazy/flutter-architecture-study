part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends TodoEvent {
  final String newTitle;
  const AddEvent({required this.newTitle});
}

class EditEvent extends TodoEvent {
  final int index;
  final String newTitle;
  const EditEvent({required this.index, required this.newTitle});
}

class ToggleEvent extends TodoEvent {
  final int index;
  const ToggleEvent({required this.index});
}
