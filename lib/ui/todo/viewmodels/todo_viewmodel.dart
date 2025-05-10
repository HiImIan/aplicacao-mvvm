import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/utils/commands/commands.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel() {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
  }
  late Command0 load;

  late Command1<void, String> addTodo;

  late Command1<String, Todo> deleteTodo;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<Result> _load() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Todo> todos = [];

    _todos = todos;

    notifyListeners();

    return Result.ok(todos);
  }

  Future<Result<Todo>> _addTodo(String name) async {
    final lastTodoIndex = _todos.length;

    await Future.delayed(const Duration(seconds: 1));
    final createdTodo = Todo(id: (lastTodoIndex + 1).toString(), name: name);
    _todos.add(createdTodo);
    notifyListeners();

    return Result.ok(createdTodo);
  }

  Future<Result<String>> _deleteTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 1));
    _todos.remove(todo);
    notifyListeners();
    return Result.ok('Removido com sucesso!');
  }
}
