import 'package:intl/intl.dart';
import '../models/todo.dart';

// models 폴더의 Todo 클래스와 다른 역할을 하는 점에 주의
// Todo 클래스는 데이터를 구조화한 것이며
// TodoModelMVC 클래스는 그 데이터들을 저장/관리하고 추가, 수정하는 등의 로직을 수행
class TodoModelMVC {
  // 투두를 저장하는 리스트 초기화
  List<Todo> todos = [];

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
