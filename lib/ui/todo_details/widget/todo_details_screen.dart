import 'package:aplicacao_mvvm/ui/todo_details/viewmodel/todo_details_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo_details/widget/todo_name_widget.dart';
import 'package:flutter/material.dart';

class TodoDetailsScreen extends StatefulWidget {
  final TodoDetailsViewModel todoDetailsViewModel;
  const TodoDetailsScreen({super.key, required this.todoDetailsViewModel});

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.todoDetailsViewModel;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo Details'),
        ),
        body: ListenableBuilder(
          listenable: viewModel.load,
          builder: (context, child) {
            final loadStatus = viewModel.load;
            if (loadStatus.running) {
              return const Center(child: CircularProgressIndicator());
            } else if (loadStatus.error) {
              return Center(
                child: Text(
                    'Ocorreu um erro ao carregar os detalhes do Todo: ${loadStatus.error}'),
              );
            }
            return child!;
          },
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: TodoName(todo: viewModel.todo),
              );
            },
          ),
        ));
  }
}
