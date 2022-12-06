import 'package:architecture_patterns/mvc_pattern2/todo_model.dart';
import 'package:flutter/material.dart';

// 뷰와 컨트롤러를 하나의 페이지에서 관리
// 실제로 플러터는 위젯들이 각각 뷰와 컨트롤러 역할을 둘 다 지니고 있기 때문에
// 위젯의 집합체인 UI 페이지 또한 뷰와 컨트롤러를 동시에 들고 있음
// 그래서 뷰와 컨트롤러를 나눌 수 없기 때문에 이렇게 두 역할을 하나의 페이지에서 다루는 것이 오히려 원칙에 맞음
class TodoPageMVC2 extends StatefulWidget {
  // 라우트 네임
  static const String route = '/todo_page_mvc2';
  const TodoPageMVC2({Key? key}) : super(key: key);

  @override
  State<TodoPageMVC2> createState() => _TodoPageMVC2State();
}

class _TodoPageMVC2State extends State<TodoPageMVC2> {
  // 이번에는 모델을 직접 불러와서 선언
  // 반복적으로 말하지만 뷰에서 모델의 로직에 직접 접근하는 것은 원칙에 위배
  // 코드가 아예 없어야하는 것은 아님
  // 예를 들면 뷰에서 모델의 클래스 타입을 컨트롤러를 통해 주입 받는 경우
  // 해당 클래스를 선언한 파일을 임포트하고 그 인스턴스를 사용해야하기 때문
  // 다만 이렇게 로직을 관리하는 모델을 직접 주입 받고 그 메서드를 직접 호출하는 것은 원칙에 위배
  // 플러터에서 MVC를 활용하려면 어떻게라도 원칙을 위반할 수 밖에 없음
  TodoModelMVC2 model = TodoModelMVC2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVC 패턴으로 개발하는 경우 2'),
      ),
      body: ListView.builder(
        itemCount: model.todos.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onLongPress: () {
              setState(() {
                // 컨트롤러가 아닌 모델에 직접 접근해서 메서드를 호출 - 원칙 위반
                model.toggleTodo(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: model.todos[index].isDone
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
                            model.editTodo(index, tempTodo);
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
              // 메서드뿐만 아니라 필드에 접근하는 것 또한 원칙 위반
              model.todos[index].title,
              style: TextStyle(
                decoration: model.todos[index].isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: Text(model.todos[index].isDone ? '완료' : ''),
            subtitle: Text(model.todos[index].createdAt),
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
                        model.addTodo(tempTodo);
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
