import 'package:intl/intl.dart';

class Todo {
  String title;
  bool isDone = false;
  late String createdAt;

  Todo({required this.title})
      : createdAt = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
}
