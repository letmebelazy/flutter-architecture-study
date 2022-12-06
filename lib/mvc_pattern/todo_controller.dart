import 'package:architecture_patterns/mvc_pattern/todo_model.dart';
import 'package:flutter/material.dart';

// MVC패턴의 컨트롤러 부분
// 뷰와 컨트롤러의 역할을 명확하게 나눌 수 없는 플러터에서는 반쪽짜리 컨트롤러에 지나지 않음
class TodoControllerMVC {
  // TodoModelMVC를 초기화
  TodoModelMVC model = TodoModelMVC();

  // 투두를 추가하는 메서드
  void addTodo(newTitle) {
    model.addTodo(newTitle);
  }

  // 투두를 수정하는 메서드
  void editTodo(int index, String newTitle) {
    model.editTodo(index, newTitle);
  }

  // 투두 완료 상태를 수정하는 메서드
  void toggleTodo(int index) {
    model.toggleTodo(index);
  }

  // 스낵바 메시지 로직
  // 굳이 여기 나눌 이유가 없지만 이것마저 안 하면 플러터에서의 컨트롤러는
  // TodoModelMVC의 복사판처럼만 활용되므로 분리해서 넣어줌
  Text showSnackbarMessage(int index) {
    if (model.todos[index].isDone) {
      return const Text('선택한 투두가 완료 처리됩니다');
    } else {
      return const Text('선택한 투두가 미완료 처리됩니다');
    }
  }

  // 투두 텍스트 데코레이션 로직
  // 스낵바와 마찬가지로 원칙상 여기 들어갈 필요는 없음
  TextDecoration setTextDecoration(int index) {
    if (model.todos[index].isDone) {
      return TextDecoration.lineThrough;
    }
    return TextDecoration.none;
  }
}
