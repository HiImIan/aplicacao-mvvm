import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository_dev.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TodoViewmodel todoViewModel;
  late TodosRepository todosRepository;
  setUp(() {
    todosRepository = TodosRepositoryDev();
    todoViewModel = TodoViewmodel(todosRepository: todosRepository);
  });
  group('Should test TodoViewModel', () {
    test('Verifying ViewModel initialState', () {
      expect(todoViewModel.todos, isEmpty);
    });

    test('Should add Todo', () async {
      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('Test');

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.name, contains('Test'));

      expect(todoViewModel.todos.first.id, isNotNull);
    });

    test('Should remove Todo', () async {
      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('Test');

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.name, contains('Test'));

      expect(todoViewModel.todos.first.id, isNotNull);

      await todoViewModel.deleteTodo.execute(todoViewModel.todos.first);

      expect(todoViewModel.todos, isEmpty);
    });
  });
}
