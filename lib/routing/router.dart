import 'package:aplicacao_mvvm/routing/routes.dart';
import 'package:aplicacao_mvvm/ui/home_page/home_page_widget.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/todo_screen.dart';
import 'package:aplicacao_mvvm/ui/todo_details/viewmodel/todo_details_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo_details/widgets/todo_details_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter routerConfig() {
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
            todoViewModel: TodoViewModel(
                todosRepository: context.read(),
                todoUpdateUseCase: context.read()),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id'];
              final TodoDetailsViewModel todoDetailsViewModel =
                  TodoDetailsViewModel(
                todosRepository: context.read(),
                todoUpdateUseCase: context.read(),
              );
              todoDetailsViewModel.load.execute(todoId!);
              return TodoDetailsScreen(
                  todoDetailsViewModel: todoDetailsViewModel);
            },
          )
        ]),
  ]);
}
