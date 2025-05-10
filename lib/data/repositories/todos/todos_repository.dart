import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';

abstract class TodosRepository {
  Future<Result<List<Todo>>> get();

  Future<Result<Todo>> add(String name);

  Future<Result<void>> delete(Todo todo);
}
