import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository_remote.dart';
import 'package:aplicacao_mvvm/data/services/api/api_client.dart';
import 'package:aplicacao_mvvm/domain/use_cases/todo_update_use_case.dart';
import 'package:aplicacao_mvvm/routing/routes.dart';
import 'package:aplicacao_mvvm/ui/home_page/home_page_widget.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/todo_screen.dart';
import 'package:aplicacao_mvvm/ui/todo_details/viewmodel/todo_details_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo_details/widgets/todo_details_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfig() {
  final todoRepository = TodosRepositoryRemote(
    apiClient: ApiClient(host: '192.168.0.225'),
  );

  final todoUpdateUseCase = TodoUpdateUseCase(
      todosRepository: todoRepository);
  return GoRouter(routes: [
    GoRoute(
        path: Routes.initialRoute,
        builder: (context, state) {
          return const HomePage();
        }),
    GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodoScreen(
            todoViewModel: TodoViewModel(todosRepository: todoRepository,todoUpdateUseCase: todoUpdateUseCase),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id'];
              final TodoDetailsViewModel todoDetailsViewModel =
                  TodoDetailsViewModel(todosRepository: todoRepository,todoUpdateUseCase: todoUpdateUseCase,);
              todoDetailsViewModel.load.execute(todoId!);
              return TodoDetailsScreen(
                  todoDetailsViewModel: todoDetailsViewModel);
            },
          )
        ]),
  ]);
}
