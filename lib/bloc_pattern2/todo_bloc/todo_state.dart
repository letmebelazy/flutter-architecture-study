part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({required this.todos});

  @override
  List<Object?> get props => [todos];

  factory TodoState.init(TodoModelBloc2 model) {
    return TodoState(
      todos: model.todos,
    );
  }

  TodoState copyWith(List<Todo>? todos) {
    return TodoState(todos: todos ?? this.todos);
  }

  @override
  bool? get stringify => true;
}
