import 'package:aplicacao_mvvm/core/result/result.dart';
import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';

class TodosRepositoryDev implements TodosRepository {
  final List<Todo> _todos = [];
  @override
  Future<Result<Todo>> add(String name) async {
    final lastTodoIndex = _todos.length;

    final Todo createdTodo = Todo(id: lastTodoIndex, name: name);

    return Result.ok(createdTodo);
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
}
