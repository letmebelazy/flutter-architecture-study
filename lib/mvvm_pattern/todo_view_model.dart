import 'package:architecture_patterns/mvvm_pattern/todo_model.dart';
import 'package:get/get.dart';

class TodoViewModel extends GetxController {
  final Rx<TodoModelMVVM> model = TodoModelMVVM().obs;

  void addTodo(String newTodo) {
    model.value.addTodo(newTodo);
  }

  void editTodo(int index, String newTodo) {
    model.value.editTodo(index, newTodo);
  }

  void toggleTodo(int index) {
    model.value.toggleTodo(index);
  }
}
