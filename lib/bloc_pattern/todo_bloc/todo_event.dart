part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEvent extends TodoEvent {
  final String newTitle;
  AddEvent({required this.newTitle});
}

class EditEvent extends TodoEvent {
  final int index;
  final String newTitle;
  EditEvent({required this.index, required this.newTitle});
}

class ToggleEvent extends TodoEvent {
  final int index;
  ToggleEvent({required this.index});
}
