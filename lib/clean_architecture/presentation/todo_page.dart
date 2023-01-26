import 'package:architecture_patterns/clean_architecture/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPageClean extends StatelessWidget {
  static const String route = '/clean_architecture';
  const TodoPageClean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture로 개발하는 경우'),
      ),
      body: BlocBuilder<TodoCleanBloc, TodoCleanState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: ((context, index) {
              return ListTile(
                onLongPress: () {
                  context
                      .read<TodoCleanBloc>()
                      .add(ToggleTodoEvent(index: index));
                  // 투두 완료 상태가 변경되면 스낵바로 알림
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 500),
                      content: state.todos[index].isDone
                          ? const Text('선택한 투두가 완료 처리됩니다')
                          : const Text('선택한 투두가 미완료 처리됩니다'),
                    ),
                  );
                },
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
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
                              context.read<TodoCleanBloc>().add(EditTodoEvent(
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
                  state.todos[index].title,
                  style: TextStyle(
                    // 텍스트 스타일을 변경하는 메서드
                    decoration: state.todos[index].isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Text(state.todos[index].isDone ? '완료' : ''),
                subtitle: Text(state.todos[index].createdAt),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
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
                      context
                          .read<TodoCleanBloc>()
                          .add(AddTodoEvent(newTitle: tempTodo));
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
