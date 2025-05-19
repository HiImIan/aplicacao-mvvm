import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/use_cases/todo_update_use_case.dart';
import 'package:aplicacao_mvvm/utils/commands/commands.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

class TodoDetailsViewModel extends ChangeNotifier {
  final TodosRepository _todosRepository;
  final TodoUpdateUseCase _todoUpdateUseCase;

  TodoDetailsViewModel({
    required TodoUpdateUseCase todoUpdateUseCase,
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        _todoUpdateUseCase = todoUpdateUseCase {
    load = Command1(_load);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
  }

  late final Command1<Todo, String> load;

  late final Command1<Todo, Todo> updateTodo;

  late Todo _todo;

  Todo get todo => _todo;

  Future<Result<Todo>> _load(String id) async {
    try {
      final result = await _todosRepository.getById(id);
      switch (result) {
        case Ok<Todo>():
          _todo = result.value;
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
}
