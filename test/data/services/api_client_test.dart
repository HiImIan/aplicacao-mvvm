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
      CreateTodoApiModel todoToCreate = const CreateTodoApiModel(
        name: 'abc',
        done: false,
        description: '123',
      );
      final result = await apiClient.postTodo(todoToCreate);

      expect(result.asOk.value, isA<Todo>());
    });

    test('Should return ok when todo is deleted with deleteTodo()', () async {
      CreateTodoApiModel todoToCreate = const CreateTodoApiModel(
        name: 'delete me',
        done: true,
        description: 'now!',
      );

      final createdTodoResult = await apiClient.postTodo(todoToCreate);

      final result = await apiClient.deleteTodo(createdTodoResult.asOk.value);
      expect(result, isA<void>());
    });

    test('Should return ok when todo is update with updateTodo()', () async {
      CreateTodoApiModel todoToCreate = const CreateTodoApiModel(
        name: 'update me',
        done: false,
        description: 'now!',
      );

      final createdTodoResult = await apiClient.postTodo(todoToCreate);

      final result = await apiClient.updateTodo(UpdateTodoApiModel(
        id: createdTodoResult.asOk.value.id,
        name: 'i was updated',
        done: true,
        description: 'wow!',
      ));
      expect(result, isA<Result<Todo>>());
    });

    test('Should getTodoById()', () async {
      CreateTodoApiModel todoToCreate = const CreateTodoApiModel(
        name: 'catch me',
        done: false,
        description: 'now!',
      );

      final createdTodoResult = await apiClient.postTodo(todoToCreate);

      final result =
          await apiClient.getTodoById(createdTodoResult.asOk.value.id);

      expect(result, isA<Result<Todo>>());

      expect(result.asOk.value.id, createdTodoResult.asOk.value.id);

      print(result.asOk.value.toJson());
    });
  });
}
