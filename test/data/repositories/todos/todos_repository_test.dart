import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository_remote.dart';
import 'package:aplicacao_mvvm/data/services/api/api_client.dart';
import 'package:aplicacao_mvvm/data/services/api/models/todo/todo_api_model.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/todos.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late TodosRepositoryRemote todosRepository;

  late ApiClient apiClient;

  setUp(() {
    apiClient = MockApiClient();
    todosRepository = TodosRepositoryRemote(apiClient: apiClient);
  });

  group('Todos repository remote test', () {
    test('getById()', () async {
      when(() => apiClient.getTodoById(any())).thenAnswer(
        (invocation) => Future.value(
          Result.ok(mockGetById),
        ),
      );

      final result = await todosRepository.getTodoById('1');

      expect(result, isA<Result<Todo>>());

      final todo = result.asOk.value;
      expect(todo.id, '1');
      expect(todo.todoInfo.name, 'name');
      expect(todo.todoInfo.description, 'description');
      expect(todo.todoInfo.done, false);

      final secondCallResult = await todosRepository.getTodoById('1');

      expect(secondCallResult, isA<Result<Todo>>());

      final secondTodo = secondCallResult.asOk.value;
      expect(secondTodo.id, '1');
      expect(secondTodo.todoInfo.name, 'name');
      expect(secondTodo.todoInfo.description, 'description');
      expect(secondTodo.todoInfo.done, false);

      verify(() => apiClient.getTodoById(any())).called(1);
    });

    test('add()', () async {
      when(() => apiClient.postTodo(
            createTodoMock,
          )).thenAnswer(
        (invocation) => Future.value(
          Result.ok(addTodoMock),
        ),
      );

      bool wasNotifier = false;

      todosRepository.addListener(
        () => wasNotifier = true,
      );

      final result = await todosRepository.add(const TodoInfo(
          name: 'i was created', description: 'now', done: false));

      expect(result, isA<Ok<Todo>>());

      final createdTodo = result.asOk.value;

      expect(todosRepository.todos.contains(addTodoMock), isTrue);

      expect(createdTodo.id, '1');
      expect(createdTodo.todoInfo.name, 'i was created');
      expect(createdTodo.todoInfo.description, 'now');
      expect(createdTodo.todoInfo.done, false);

      expect(wasNotifier, true);
    });

    test('delete()', () async{
      when(() => apiClient.deleteTodo(addTodoMock)).thenAnswer(
        (invocation) => Future.value(Result.ok(null)),
      );

      when(() => apiClient.getTodos()).thenAnswer(
        (invocation) => Future.value(
          Result.ok([addTodoMock]),
        ),
      );

      final result = await todosRepository.get();

      expect(result, isA<Ok<List<Todo>>>());

      expect(todosRepository.todos.contains(addTodoMock),isTrue);

      bool wasNotifier = false;

      todosRepository.addListener(
        () => wasNotifier = true,
      );

      final deleteResult = await todosRepository.delete(addTodoMock);

      expect(deleteResult, isA<Ok<void>>());

      expect(todosRepository.todos.contains(addTodoMock), isFalse);

      expect(wasNotifier, isTrue);
    });

    test('updateTodo()', () async{
      when(() => apiClient.getTodos()).thenAnswer(
        (invocation) => Future.value(
          Result.ok(todos),
        ),
      );

      when(() => apiClient.updateTodo(updateTodoMock)).thenAnswer(
        (invocation) => Future.value(
          Result.ok(updateTodoResultMock),
        ),
      );

      final result = await todosRepository.get();

      expect(result, isA<Ok<List<Todo>>>());


      bool wasNotifier = false;

      todosRepository.addListener(
        () => wasNotifier = true,
      );

      final updateTodoResult = await todosRepository.update(
        todos.first.copyWith(todoInfo: todos.first.todoInfo.copyWith(name: 'novo nome',description: 'nova descrição',done: true,)),
      );

      expect(updateTodoResult, isA<Ok<Todo>>());

      final updatedTodo = updateTodoResult.asOk.value;

      expect(updatedTodo.id, '1');
      expect(updatedTodo.todoInfo.name, 'novo nome');
      expect(updatedTodo.todoInfo.description, 'nova descrição');
      expect(updatedTodo.todoInfo.done, true);

      expect(todosRepository.todos.contains(updatedTodo), isTrue);

      expect(wasNotifier, isTrue);
    });
  });
}
