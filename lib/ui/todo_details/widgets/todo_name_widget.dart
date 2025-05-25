import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:flutter/material.dart';

class TodoName extends StatelessWidget {
  const TodoName({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final todoInfo = todo.todoInfo;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Nome: ${todoInfo.name}',
        style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
