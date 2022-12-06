import 'package:architecture_patterns/mvc_pattern/todo_model.dart';
import 'package:flutter/material.dart';

class TodoControllerMVC {
  TodoModelMVC model = TodoModelMVC();

  void addTodo(newTitle) {
    model.addTodo(newTitle);
  }

  void editTodo(int index, String newTitle) {
    model.editTodo(index, newTitle);
  }

  void toggleTodo(int index) {
    model.toggleTodo(index);
  }

  Text showSnackbarMessage(int index) {
    if (model.todos[index].isDone) {
      return const Text('선택한 투두가 완료 처리됩니다');
    } else {
      return const Text('선택한 투두가 미완료 처리됩니다');
    }
  }

  TextDecoration setTextDecoration(int index) {
    if (model.todos[index].isDone) {
      return TextDecoration.lineThrough;
    }
    return TextDecoration.none;
  }
}
