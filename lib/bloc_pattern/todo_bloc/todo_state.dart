part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({required this.todos});

  @override
  List<Object?> get props => [todos];

  factory TodoState.init(List<Todo> todos) {
    return TodoState(
      todos: todos,
    );
  }

  TodoState copyWith(List<Todo>? todos) {
    return TodoState(todos: todos ?? this.todos);
  }
}
