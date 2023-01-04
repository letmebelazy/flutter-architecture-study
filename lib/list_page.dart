import 'package:architecture_patterns/mvc_pattern/todo_view.dart';
import 'package:architecture_patterns/mvp_pattern/todo_view.dart';
import 'package:architecture_patterns/mvvm_pattern/todo_view.dart';
import 'package:architecture_patterns/no%20pattern/todo_page.dart';
import 'package:flutter/material.dart';

import 'mvc_pattern2/todo_view_and_controller.dart';

class ListPage extends StatelessWidget {
  ListPage({Key? key}) : super(key: key);
  // 우리가 다룰 아키텍처 패턴을 모아둔 페이지
  // 현재 MVC pattern 2까지 구현
  final List<String> patterns = [
    'no pattern',
    'MVC pattern',
    'MVC pattern 2',
    'MVP pattern',
    'MVVM pattern',
    'BLoC pattern',
    'Clean Architecture',
    'MVC+S pattern',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아키텍처 패턴 리스트'),
      ),
      body: ListView.builder(
        itemCount: patterns.length,
        itemBuilder: ((context, index) {
          return CustomListTile(
            index: index,
            title: patterns[index],
          );
        }),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final int index;
  final String title;

  // pushNamed로 라우팅하기 휘한 String 리스트
  final List<String> routes = [
    TodoPage.route,
    TodoPageMVC.route,
    TodoPageMVC2.route,
    TodoPageMVP.route,
    TodoPageMVVM.route,
  ];

  CustomListTile({
    required this.index,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // 누르면 해당 페이지로 이동함. 아직 구현되지 않은 페이지는 이동 불가
          if (index < 5) {
            Navigator.pushNamed(
              context,
              routes[index],
            );
          }
        },
        child: Text(title),
      ),
    );
  }
}
