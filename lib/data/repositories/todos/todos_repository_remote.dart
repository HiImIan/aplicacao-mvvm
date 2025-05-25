import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/data/services/api/api_client.dart';
import 'package:aplicacao_mvvm/data/services/api/models/todo/todo_api_model.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

class TodosRepositoryRemote extends ChangeNotifier implements TodosRepository {
  final ApiClient _apiClient;

  TodosRepositoryRemote({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  List<Todo> get todos => _todos;

  List<Todo> _todos = [];

  final Map<String, Todo> _cachedTodos = {};

  @override
  Future<Result<List<Todo>>> get() async {
    try {
      final result = await _apiClient.getTodos();
      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          return Result.ok(result.value);

        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<Todo>> getTodoById(String id) async {
    if (_cachedTodos.containsKey(id)) {
      return Result.ok(_cachedTodos[id]!);
    }
    try {
      final result = await _apiClient.getTodoById(id);

      switch (result) {
        case Ok<Todo>():
          _cachedTodos[id] = result.value;
          return Result.ok(result.value);

        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<Todo>> add(TodoInfo todoInfo) async {
    try {
      final result = await _apiClient.postTodo(CreateTodoApiModel(
          name: todoInfo.name,
          description: todoInfo.description,
          done: todoInfo.done));

      switch (result) {
        case Ok<Todo>():
          _cachedTodos[result.value.id] = result.value;
        _todos.add(result.value);
          return Result.ok(result.value);

        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<Todo>> update(Todo todo) async {
    try {
      final todoInfo = todo.todoInfo;
      final result = await _apiClient.updateTodo(UpdateTodoApiModel(
          id: todo.id,
          name: todoInfo.name,
          description: todoInfo.description,
          done: todoInfo.done));

      switch (result) {
        case Ok<Todo>():
          final todoIndex =
              _todos.indexWhere((element) => element.id == todo.id);
          _todos[todoIndex] = result.value;
          _cachedTodos[todo.id] = result.value;
          return Result.ok(result.value);

        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    try {
      final result = await _apiClient.deleteTodo(todo);

      switch (result) {
        case Ok<void>():
        _todos.remove(todo);
        _cachedTodos.remove(todo.id);
          return Result.ok(null);

        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
