import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';

class TodosRepositoryDev implements TodosRepository {
  final List<Todo> _todos = [];
  @override
  Future<Result<Todo>> add(TodoInfo todoInfo) async {
    final lastTodoIndex = _todos.length;

    final Todo createdTodo =
        Todo(id: lastTodoIndex.toString(), todoInfo: todoInfo);

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

  @override
  Future<Result<Todo>> getById(String id) async {
    return Result.ok(_todos.firstWhere((todo) => todo.id == id));
  }

  @override
  Future<Result<Todo>> update(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);

    _todos[index] = todo;
    return Result.ok(todo);
  }
}
