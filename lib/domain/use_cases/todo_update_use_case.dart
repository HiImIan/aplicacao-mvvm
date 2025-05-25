import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:logging/logging.dart';

class TodoUpdateUseCase {
  final TodosRepository _todosRepository;
  final _log = Logger('TodoUpdateUseCase');

  TodoUpdateUseCase({required TodosRepository todosRepository})
      : _todosRepository = todosRepository;

  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _todosRepository.update(todo);
      switch (result) {
        case Ok<Todo>():
          _log.fine('Todo atualizado');
          return Result.ok(result.value);

        default:
          return result;
      }
    } on Exception catch (error, stackTrace) {
          _log.warning('Erro ao atualizar todo', error, stackTrace);
      return Result.error(error);
    }
  }
}
