import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:flutter/material.dart';

class TodoDescription extends StatelessWidget {
  const TodoDescription({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          todo.todoInfo.description,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ));
  }
}
