import 'package:aplicacao_mvvm/core/typedefs/todos.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final OnDeleteTodo onDeleteTodo;
  final Todo todo;
  final TodoViewmodel todoViewmodel;
  const TodoTile(
      {super.key,
      required this.todo,
      required this.todoViewmodel,
      required this.onDeleteTodo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${todo.id}'),
      title: Text(todo.name),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () => onDeleteTodo(todo),
      ),
    );
  }
}
