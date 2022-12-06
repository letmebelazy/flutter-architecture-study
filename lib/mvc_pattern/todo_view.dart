import 'package:architecture_patterns/mvc_pattern/todo_controller.dart';
import 'package:flutter/material.dart';

class TodoPageMVC extends StatefulWidget {
  static const String route = '/todo_page_mvc';
  const TodoPageMVC({Key? key}) : super(key: key);

  @override
  State<TodoPageMVC> createState() => _TodoPageMVCState();
}

class _TodoPageMVCState extends State<TodoPageMVC> {
  TodoControllerMVC controller = TodoControllerMVC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVC 패턴으로 개발하는 경우'),
      ),
      body: ListView.builder(
        itemCount: controller.model.todos.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onLongPress: () {
              setState(() {
                controller.model.toggleTodo(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: controller.showSnackbarMessage(index),
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
                            controller.model.editTodo(index, tempTodo);
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
              controller.model.todos[index].title,
              style: TextStyle(
                decoration: controller.setTextDecoration(index),
              ),
            ),
            trailing: Text(controller.model.todos[index].isDone ? '완료' : ''),
            subtitle: Text(controller.model.todos[index].createdAt),
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
                        controller.model.addTodo(tempTodo);
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
}
