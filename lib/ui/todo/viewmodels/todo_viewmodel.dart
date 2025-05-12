import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/utils/commands/commands.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

class TodoViewmodel extends ChangeNotifier {
  final TodosRepository todosRepository;

  late Command0 load;

  late Command1<void, String> addTodo;

  late Command1<void, Todo> deleteTodo;
  TodoViewmodel({required this.todosRepository})
      : _todosRepository = todosRepository {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
  }

  final TodosRepository _todosRepository;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<Result> _load() async {
    try {
      final result = await _todosRepository.get();

      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          break;
        case Error():
      }

      return result;
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<Todo>> _addTodo(String name) async {
    try {
      final result = await _todosRepository.add(name);
      switch (result) {
        case Ok<Todo>():
          _todos.add(result.value);
          break;
        case Error():
      }
      return result;
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteTodo(Todo todo) async {
    try {
      final result = await _todosRepository.delete(todo);
      switch (result) {
        case Ok<void>():
          _todos.remove(todo);
          break;
        case Error():
      }
      return result;
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
