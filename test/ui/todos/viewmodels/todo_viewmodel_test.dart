import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository.dart';
import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository_dev.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/domain/use_cases/todo_update_use_case.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TodoViewModel todoViewModel;
  late TodosRepository todosRepository;
  late TodoUpdateUseCase todoUpdateUseCase;
  setUp(() {
    todosRepository = TodosRepositoryDev();
    todoUpdateUseCase = TodoUpdateUseCase(todosRepository: todosRepository);
    todoViewModel = TodoViewModel(
        todosRepository: todosRepository, todoUpdateUseCase: todoUpdateUseCase);
  });
  group('Should test TodoViewModel', () {
    test('Verifying ViewModel initialState', () {
      expect(todoViewModel.todos, isEmpty);
    });

    test('Should add Todo', () async {
      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute(
          const TodoInfo(name: 'nome', description: 'descrição', done: false));

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.todoInfo.name, contains('nome'));

      expect(todoViewModel.todos.first.id, isNotNull);
    });

    test('Should remove Todo', () async {
      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute(
          const TodoInfo(name: 'nome', description: 'descrição', done: false));

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.todoInfo.name, contains('nome'));

      expect(todoViewModel.todos.first.id, isNotNull);

      await todoViewModel.deleteTodo.execute(todoViewModel.todos.first);

      expect(todoViewModel.todos, isEmpty);
    });
  });
}
