import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

class TodosRepositoryDev extends ChangeNotifier implements TodosRepository {
  final List<Todo> _todos = [];


  @override
  List<Todo> get todos => _todos;
  
  @override
  Future<Result<Todo>> add(TodoInfo todoInfo) async {
    try {
  final lastTodoIndex = _todos.length;
  
  final Todo createdTodo =
      Todo(id: lastTodoIndex.toString(), todoInfo: todoInfo);
  
  return Result.ok(createdTodo);
} on Exception catch (e) {
  return Result.error(e);
} 
finally {
  notifyListeners();
}
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    if (_todos.contains(todo)) {
      _todos.remove(todo);
    }
    return Result.ok(null);
  }

  @override
  Future<Result<List<Todo>>> get() async {
    return Result.ok(_todos);
  }

  @override
  Future<Result<Todo>> getById(String id) async {
    return Result.ok(_todos.firstWhere((todo) => todo.id == id));
  }

  @override
  Future<Result<Todo>> update(Todo todo) async {
    try {
  final index = _todos.indexWhere((t) => t.id == todo.id);
  
  _todos[index] = todo;
  return Result.ok(todo);
} on Exception catch (e) {
  return Result.error(e);
} finally {
  notifyListeners();}
  }
  

}
