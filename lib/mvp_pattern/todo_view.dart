import 'package:architecture_patterns/mvp_pattern/interfaces.dart';
import 'package:architecture_patterns/mvp_pattern/todo_model.dart';
import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoPageMVP extends StatefulWidget {
  // 현 페이지에 오기 위한 라우트 이름
  // 크게 신경 쓸 필요 없음
  final TodoPresenter todoPresenter;
  static const String route = '/todo_page_mvp';
  const TodoPageMVP({Key? key, required this.todoPresenter}) : super(key: key);

  @override
  State<TodoPageMVP> createState() => _TodoPageMVPState();
}

class _TodoPageMVPState extends State<TodoPageMVP> implements TodoView {
  late TodoModelMVP model;

  @override
  void initState() {
    super.initState();
    widget.todoPresenter.setView(this);
  }

  @override
  void refreshView(TodoModelMVP model) {
    setState(() {
      this.model = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVP 패턴으로 개발하는 경우'),
      ),
      body: ListView.builder(
        itemCount: widget.todoPresenter.todos.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onLongPress: () {
              widget.todoPresenter.toggleTodo(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: widget.todoPresenter.todos[index].isDone
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
                          widget.todoPresenter.editTodo(index, tempTodo);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
            title: Text(
              widget.todoPresenter.todos[index].title,
              style: TextStyle(
                decoration: widget.todoPresenter.todos[index].isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing:
                Text(widget.todoPresenter.todos[index].isDone ? '완료' : ''),
            subtitle: Text(widget.todoPresenter.todos[index].createdAt),
          );
        }),
      ),
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
                      widget.todoPresenter.addTodo(tempTodo);
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
