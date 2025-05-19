import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository_dev.dart';
import 'package:aplicacao_mvvm/domain/use_cases/todo_update_use_case.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/todo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final todosRepository = TodosRepositoryDev();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: false,
      ),
      home: TodoScreen(
        todoViewModel: TodoViewModel(
          todosRepository: todosRepository,
        todoUpdateUseCase: TodoUpdateUseCase(todosRepository: todosRepository),
        ),
      ),
    );
  }
}
