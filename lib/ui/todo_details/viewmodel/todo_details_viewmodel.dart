import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/utils/commands/commands.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

class TodoDetailsViewModel extends ChangeNotifier {
  final TodosRepository _todosRepository;

  TodoDetailsViewModel({required TodosRepository todosRepository})
      : _todosRepository = todosRepository {
    load = Command1(_load);
  }

  late final Command1<Todo, String> load;

  late Todo _todo;

  Todo get todo => _todo;

  Future<Result<Todo>> _load(String id) async {
    try {
      final result = await _todosRepository.getById(id);
      switch (result) {
        case Ok<Todo>():
          _todo = result.value;
          return Result.ok(_todo);
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
