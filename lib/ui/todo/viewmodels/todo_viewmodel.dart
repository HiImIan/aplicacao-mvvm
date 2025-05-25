import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/domain/use_cases/todo_update_use_case.dart';
import 'package:aplicacao_mvvm/utils/commands/commands.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class TodoViewModel extends ChangeNotifier {
  late Command0 load;

  late Command1<void, TodoInfo> addTodo;

  late Command1<void, Todo> deleteTodo;

  late Command1<Todo, Todo> updateTodo;

  final TodosRepository _todosRepository;

  final TodoUpdateUseCase _todoUpdateUseCase;

  final _log = Logger('TodoViewModel');

  TodoViewModel(
      {required TodosRepository todosRepository,
      required TodoUpdateUseCase todoUpdateUseCase})
      : _todosRepository = todosRepository,
        _todoUpdateUseCase = todoUpdateUseCase {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
    _todosRepository.addListener(() {
      _todos = _todosRepository.todos;
      notifyListeners();
    });
  }

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<Result> _load() async {
    try {
      final result = await _todosRepository.get();
      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          _log.fine('Todos carregados');
          break;
        case Error():
          _log.warning('Falha ao carregar todos', result.asError.error);
          break;
      }

      return result;
    } on Exception catch (error, stackTrace) {
      _log.warning('Falha ao carregar todos', error, stackTrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<Todo>> _addTodo(TodoInfo todoInfo) async {
    try {
      final result = await _todosRepository.add(todoInfo);
      switch (result) {
        case Ok<Todo>():
          _log.fine('Todos criado');
          break;
        case Error():
          _log.warning('Erro ao criar todo');
          break;
      }
      return result;
    } on Exception catch (error, stackTrace) {
      _log.warning('Erro ao criar todo', error, stackTrace);
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
          _log.fine('Todos deletado');
          break;
        case Error():
          _log.warning('Erro ao deletar todo');
          break;
      }
      return result;
    } on Exception catch (error, stackTrace) {
      _log.warning('Erro ao deletar todo', error, stackTrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
