import 'package:architecture_patterns/mvc_pattern/todo_controller.dart';
import 'package:flutter/material.dart';

class TodoPageMVC extends StatefulWidget {
  // 현 페이지에 오기 위한 라우트 이름
  // 크게 신경 쓸 필요 없음
  static const String route = '/todo_page_mvc';
  const TodoPageMVC({Key? key}) : super(key: key);

  @override
  State<TodoPageMVC> createState() => _TodoPageMVCState();
}

class _TodoPageMVCState extends State<TodoPageMVC> {
  // 컨트롤러 초기화
  // MVC의 원칙 상 뷰가 컨트롤러를 주입하는 것은 안 되지만
  // 플러터는 각각의 위젯이 뷰와 컨트롤러를 동시에 담당하기 때문에 위 원칙을 지키기 매우 힘듦
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
                // 뷰에서 모델에 직접 접근하면 안 되기 때문에 컨트롤러가 필요
                // 하지만 사실상 사용자 입력을 받는 ListTile의 해당 메서드가 컨트롤러 역할을
                // 하기 때문에 플러터의 MVC패턴은 모순이 발생할 수밖에 없음
                // 어쨌든 투두의 완료 상태를 바꿔줌
                controller.model.toggleTodo(index);
              });
              // 투두 완료 상태가 변경되면 스낵바로 알림
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  // 완료 상태에 따라 스낵바 메시지를 다르게 보여주는 메서드
                  content: controller.showSnackbarMessage(index),
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
                          setState(() {
                            // 임시값을 활용하여 투두를 수정
                            // 역시 컨트롤러에서 모델 부분의 코드를 접근하여 호출
                            // 뷰에서 직접 모델의 코드를 불러 쓰는 것은 원칙 위반
                            // 하지만 뷰에서 컨트롤러의 코드를 쓰는 것도 원칙 위반
                            // 어찌 됐든 모순이 발생
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
                // 텍스트 스타일을 변경하는 메서드
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
