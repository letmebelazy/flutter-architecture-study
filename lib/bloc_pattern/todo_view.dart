import 'package:architecture_patterns/bloc_pattern/todo_bloc/todo_bloc.dart';
import 'package:flutter/material.dart';

import 'todo_model.dart';

class TodoPageBloc extends StatelessWidget {
  // 현 페이지에 오기 위한 라우트 이름
  // 크게 신경 쓸 필요 없음
  static const String route = '/todo_page_bloc';
  final TodoBloc bloc = TodoBloc(model: TodoModelBloc());
  TodoPageBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(bloc.state.todos);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOC 패턴으로 개발하는 경우'),
      ),
      body: StreamBuilder<TodoState>(
          stream: bloc.todoList,
          initialData: bloc.state,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.todos.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  onLongPress: () {
                    bloc.listenEvent(ToggleEvent(index: index));
                    // 투두 완료 상태가 변경되면 스낵바로 알림
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 500),
                        content: snapshot.data!.todos[index].isDone
                            ? const Text('선택한 투두가 완료 처리됩니다')
                            : const Text('선택한 투두가 미완료 처리됩니다'),
                      ),
                    );
                  },
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        // 패턴을 쓰지 않은 페이지와 마찬가지로
                        // 텍스트필드의 값을 저장할 임시값
                        String tempTodo = '';
                        return AlertDialog(
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Column(
                              children: [
                                const Text('수정할 내용을 입력하세요.'),
                                TextField(
                                  // 텍스트필드의 입력값이 바뀔 때마다 임시값에 저장
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
                                bloc.listenEvent(EditEvent(
                                    index: index, newTitle: tempTodo));
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  title: Text(
                    snapshot.data!.todos[index].title,
                    style: TextStyle(
                      // 텍스트 스타일을 변경하는 메서드
                      decoration: snapshot.data!.todos[index].isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing:
                      Text(snapshot.data!.todos[index].isDone ? '완료' : ''),
                  subtitle: Text(snapshot.data!.todos[index].createdAt),
                );
              }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String tempTodo = '';
              return AlertDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    children: [
                      const Text('새로 추가할 투두를 입력하세요.'),
                      TextField(
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
                      bloc.listenEvent(AddEvent(newTitle: tempTodo));
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
}
