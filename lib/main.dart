import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository_remote.dart';
import 'package:aplicacao_mvvm/data/services/api/api_client.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: false,
      ),
      home: TodoScreen(
        todoViewmodel: TodoViewmodel(
          todosRepository: TodosRepositoryRemote(
            apiClient: ApiClient(host: '192.168.0.224'),
          ),
        ),
      ),
    );
  }
}
