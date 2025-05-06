import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Should test TodoViewModel', () {
    test('Verifying ViewModel initialState', () {
      final TodoViewmodel todoViewModel = TodoViewmodel();

      expect(todoViewModel.todos, isEmpty);
    });

    test('Should add Todo', () async {
      final TodoViewmodel todoViewModel = TodoViewmodel();

      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('Test');

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.name, contains('Test'));

      expect(todoViewModel.todos.first.id, isNotNull);
    });

    test('Should remove Todo', () async {
      final TodoViewmodel todoViewModel = TodoViewmodel();

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
