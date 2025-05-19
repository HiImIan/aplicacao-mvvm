import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';

class TodoUpdateUseCase  {
  final TodosRepository _todosRepository;

  TodoUpdateUseCase({required TodosRepository todosRepository}) : _todosRepository = todosRepository;

Future<Result<Todo>> updateTodo(Todo todo) async{
  try {
  final result = await _todosRepository.update(todo);
  
  switch (result) {
    case Ok<Todo>():
      return Result.ok(result.value);
      
    default:
      return result;
  }
} on Exception catch (error) {
  return Result.error(error);
}
}
}