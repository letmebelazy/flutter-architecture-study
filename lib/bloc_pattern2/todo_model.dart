import 'package:intl/intl.dart';
import '../models/todo.dart';

class TodoModelBloc2 {
  // 투두를 저장하는 리스트 초기화
  List<Todo> todos = [
    Todo(title: '집 청소'),
    Todo(title: '설거지'),
    Todo(title: '빨래'),
  ];

  // 투두를 추가
  void addTodo(String newTitle) {
    todos.add(Todo(title: newTitle));
  }

  // 투두를 수정
  void editTodo(int index, String newTitle) {
    todos[index].title = newTitle;
    todos[index].createdAt =
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
  }

  // 투두 완료 상태 변경
  void toggleTodo(int index) {
    todos[index].isDone = !todos[index].isDone;
  }
}
