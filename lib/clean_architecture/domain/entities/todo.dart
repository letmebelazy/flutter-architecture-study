import 'package:intl/intl.dart';

class Todo {
  // 투두 제목
  String title;
  // 투두 완료 상태
  bool isDone = false;
  // 투두가 만들어지거나 수정된 날짜/시간을 저장하는 문자열
  late String createdAt;

  // 투두를 생성할 때의 필수 인자는 제목이고, 만들어지거나 수정된 시간은 DateTime.now 메서드를 통해
  // 현재 시각으로 저장하고 초기화리스트를 통해 자동으로 문자열로 바꿔서 저장
  Todo({required this.title})
      : createdAt = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
}
