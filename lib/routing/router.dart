import 'package:aplicacao_mvvm/data/repositories/todos/todos_repository_remote.dart';
import 'package:aplicacao_mvvm/data/services/api/api_client.dart';
import 'package:aplicacao_mvvm/routing/routes.dart';
import 'package:aplicacao_mvvm/ui/home_page/home_page_widget.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/todo_screen.dart';
import 'package:aplicacao_mvvm/ui/todo_details/viewmodel/todo_details_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo_details/widget/todo_details_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfig() {
  final todoRepository = TodosRepositoryRemote(
    apiClient: ApiClient(host: '192.168.0.225'),
  );
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
            todoViewmodel: TodoViewModel(todosRepository: todoRepository),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id'];
              final TodoDetailsViewModel todoDetailsViewModel =
                  TodoDetailsViewModel(todosRepository: todoRepository);
              todoDetailsViewModel.load.execute(todoId!);
              return TodoDetailsScreen(
                  todoDetailsViewModel: todoDetailsViewModel);
            },
          )
        ]),
  ]);
}
