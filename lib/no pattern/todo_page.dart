import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoPage extends StatefulWidget {
  static const route = '/todo_page';
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
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
            onLongPress: () {
              setState(() {
                todos[index].isDone = !todos[index].isDone;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: todos[index].isDone
                      ? const Text('선택한 투두가 완료 처리됩니다')
                      : const Text('선택한 투두가 미완료 처리됩니다'),
                ),
              );
            },
            onTap: () {
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
                          const Text('수정할 내용을 입력하세요.'),
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
                        child: const Text('수정'),
                        onPressed: () {
                          setState(() {
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
                decoration: todos[index].isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: Text(todos[index].isDone ? '완료' : ''),
            subtitle: Text(todos[index].createdAt),
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
                      setState(() {
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
