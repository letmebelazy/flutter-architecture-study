import 'package:architecture_patterns/bloc_pattern2/todo_bloc/todo_bloc.dart';
import 'package:architecture_patterns/bloc_pattern2/todo_model.dart';
import 'package:architecture_patterns/bloc_pattern2/todo_view.dart';
import 'package:architecture_patterns/mvc_pattern/todo_view.dart';
import 'package:architecture_patterns/mvc_pattern2/todo_view_and_controller.dart';
import 'package:architecture_patterns/mvp_pattern/todo_presenter.dart';
import 'package:architecture_patterns/mvp_pattern/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_pattern/todo_view.dart';
import 'clean_architecture/presentation/bloc/todo_bloc.dart';
import 'clean_architecture/presentation/todo_page.dart';
import 'list_page.dart';
import 'mvp_pattern/todo_model.dart';
import 'mvvm_pattern/todo_view.dart';
import 'no pattern/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(
            TodoModelBloc2(),
          ),
        ),
        BlocProvider(
          create: (context) => TodoCleanBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Architecture Patterns',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ListPage(),
        initialRoute: '/',
        routes: {
          // 하나의 투두앱을 패턴별로 적용해서 만든 페이지 리스트
          '/list_page': (context) => ListPage(),
          // 한 파일 내에 어떠한 패턴도 없이 막 코딩으로 구현한 페이지
          '/todo_page': (context) => const TodoPage(),
          // 현재 플러터 mvc패턴 라이브러리에서 하는 방식으로 구현한 페이지
          '/todo_page_mvc': (context) => const TodoPageMVC(),
          // 위 페이지보다 훨씬 더 mvc패턴 원칙에 충실해서 구현한 페이지
          '/todo_page_mvc2': (context) => const TodoPageMVC2(),
          // 플러터 mvp패턴
          '/todo_page_mvp': (context) => TodoPageMVP(
              todoPresenter: TodoPresenterImpl(model: TodoModelMVP())),
          // 플러터 mvvm패턴
          '/todo_page_mvvm': (context) => const TodoPageMVVM(),
          // 플러터 bloc패턴
          '/todo_page_bloc': (context) => TodoPageBloc(),
          // 패키지를 이용한 bloc패턴
          '/todo_page_bloc2': (context) => const TodoPageBloc2(),
          // 클린 아키텍처 맛보기
          '/clean_architecture': (context) => const TodoPageClean(),
        },
      ),
    );
  }
}
