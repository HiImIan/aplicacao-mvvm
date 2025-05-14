import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/routing/routes.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/utils/typedefs/todos.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoTile extends StatelessWidget {
  final OnDeleteTodo onDeleteTodo;
  final Todo todo;
  final TodoViewModel todoViewModel;
  const TodoTile(
      {super.key,
      required this.todo,
      required this.todoViewModel,
      required this.onDeleteTodo});

  @override
  Widget build(BuildContext context) {
    final todoInfo = todo.todoInfo;
    return GestureDetector(
      onTap: () => context.push(Routes.todoDetails(todo.id)),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: todoInfo.done,
            onChanged: (value) {
              todoViewModel.updateTodo.execute(todo.copyWith(
                todoInfo: todoInfo.copyWith(
                  done: value,
                ),
              ));
            },
          ),
          title: Text(todoInfo.name),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => onDeleteTodo(todo),
          ),
        ),
      ),
    );
  }
}
