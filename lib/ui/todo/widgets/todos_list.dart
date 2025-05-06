import 'package:aplicacao_mvvm/core/typedefs/todos.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/todo_tile.dart';
import 'package:flutter/material.dart';

class TodosList extends StatelessWidget {
  final List<Todo> todos;
  final TodoViewmodel todoViewmodel;
  final OnDeleteTodo onDeleteTodo;
  const TodosList(
      {super.key,
      required this.todos,
      required this.todoViewmodel,
      required this.onDeleteTodo});

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text('Nenhuma tarefa encontrada!'),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoTile(
          todo: todo,
          todoViewmodel: todoViewmodel,
          onDeleteTodo: onDeleteTodo,
        );
      },
    );
  }
}
