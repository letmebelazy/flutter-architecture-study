part of 'todo_bloc.dart';

class TodoCleanState extends Equatable {
  final List<Todo> todos;

  const TodoCleanState({required this.todos});

  factory TodoCleanState.init() {
    return const TodoCleanState(todos: []);
  }

  @override
  List<Object> get props => [todos];

  @override
  bool? get stringify => true;

  TodoCleanState copyWith({required List<Todo>? todos}) {
    return TodoCleanState(todos: todos ?? this.todos);
  }
}
