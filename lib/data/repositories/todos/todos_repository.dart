import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';

abstract class TodosRepository {
  Future<Result<List<Todo>>> get();

  Future<Result<Todo>> add(TodoInfo name);

  Future<Result<void>> delete(Todo todo);

  Future<Result<Todo>> getById(String id);

  Future<Result<Todo>> update(Todo todo);
}
