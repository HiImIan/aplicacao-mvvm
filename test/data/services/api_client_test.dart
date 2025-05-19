import 'package:aplicacao_mvvm/data/services/api/api_client.dart';
import 'package:aplicacao_mvvm/data/services/api/models/todo/todo_api_model.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ApiClient apiClient;
  setUp(() {
    apiClient = ApiClient();
  });
  group('Should test [ApiClient]', () {
    test('should return ok when getTodos()', () async {
      final result = await apiClient.getTodos();

      expect(result.asOk.value, isA<List<Todo>>());
    });

    test('should return a todo when creating postTodo()', () async {
      const CreateTodoApiModel todoToCreate =
          CreateTodoApiModel(name: 'Todo created on test');

      final result = await apiClient.postTodo(todoToCreate);

      expect(result.asOk.value, isA<Todo>());
    });

    test('Should return ok when todo is deleted with deleteTodo()', () async {
      const CreateTodoApiModel todoToCreate =
          CreateTodoApiModel(name: 'Todo to delete');

      final createdTodoResult = await apiClient.postTodo(todoToCreate);

      final result = await apiClient.deleteTodo(createdTodoResult.asOk.value);
      expect(result, isA<void>());
    });

    test('Should return ok when todo is update with updateTodo()', () async {
      const CreateTodoApiModel todoToCreate =
          CreateTodoApiModel(name: 'Todo to create');

      final createdTodoResult = await apiClient.postTodo(todoToCreate);

      final result = await apiClient.updateTodo(UpdateTodoApiModel(
          id: createdTodoResult.asOk.value.id!, name: 'create todo updated'));
      expect(result, isA<Result<Todo>>());
    });
  });
}
