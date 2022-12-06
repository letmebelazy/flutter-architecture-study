import 'package:flutter/material.dart';
import '../models/todo.dart';

// 패턴 없이 막코딩으로 구현한 투두앱
class TodoPage extends StatefulWidget {
  // 라우트 네임
  static const route = '/todo_page';
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // 투두를 저장할 리스트 초기화. 클래스를 나누지 않고 하나의 클래스에서 데이터가 관리됨
  // Todo 모델은 공통으로 사용함
  // 아키텍처에 대한 필요성을 못 느끼는 경우 이마저도 같은 파일 내에서 정의하고 사용함
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('패턴 없이 개발하는 경우'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: ((context, index) {
          return ListTile(
            // 투두를 오래 누르면 투두의 완료 상태를 바꿔줌
            onLongPress: () {
              setState(() {
                // 선택한 투두가 미완이라면 완료로, 완료라면 미완으로 바꿔줌
                todos[index].isDone = !todos[index].isDone;
              });
              // 선택한 투두가 어떻게 처리되었는지 스낵바로 알려줌
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: todos[index].isDone
                      ? const Text('선택한 투두가 완료 처리됩니다')
                      : const Text('선택한 투두가 미완료 처리됩니다'),
                ),
              );
            },
            // 투두를 터치하면 수정할 수 있는 다이얼로그가 나옴
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  // 텍스트필드의 입력값을 저장해주는 임시값
                  String tempTodo = '';
                  return AlertDialog(
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Column(
                        children: [
                          const Text('수정할 내용을 입력하세요.'),
                          TextField(
                            // 텍스트필드에 값이 입력될 때마다(변경될 때마다) 임시값에 저장
                            onChanged: (v) {
                              tempTodo = v;
                            },
                          )
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('수정'),
                        onPressed: () {
                          setState(() {
                            // 수정 버튼을 누르면 임시값을 활용하여 수정
                            _editTodo(index, tempTodo);
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
            title: Text(
              todos[index].title,
              style: TextStyle(
                // 투두의 완료 상태를 체크해서 완료면 삭선을 넣고, 아니면 어떤 스타일도 넣지 않음
                decoration: todos[index].isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            // 투두의 완료 상태를 체크해서 완료면 리스트타일 오른쪽 끝에 완료를 명시, 아니면 명시하지 않음
            trailing: Text(todos[index].isDone ? '완료' : ''),
            subtitle: Text(todos[index].createdAt),
          );
        }),
      ),
      // 투두를 추가하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              // 수정과 같은 방식으로 텍스트필드의 임시값을 초기화
              String tempTodo = '';
              return AlertDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    children: [
                      const Text('새로 추가할 투두를 입력하세요.'),
                      TextField(
                        // 값이 입력될 때마다 임시값에 저장
                        onChanged: (v) {
                          tempTodo = v;
                        },
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('추가'),
                    onPressed: () {
                      setState(() {
                        // 추가 버튼을 누르면 임시값을 활용하여 투두로 추가해줌
                        _addTodo(tempTodo);
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodo(String tempTodo) {
    Todo newTodo = Todo(title: tempTodo);
    todos.add(newTodo);
  }

  void _editTodo(int index, String tempTodo) {
    todos[index].title = tempTodo;
  }
}
