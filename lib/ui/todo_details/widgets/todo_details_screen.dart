import 'package:aplicacao_mvvm/ui/todo_details/viewmodel/todo_details_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo_details/widgets/edit_form_widget.dart';
import 'package:aplicacao_mvvm/ui/todo_details/widgets/todo_description_widget.dart';
import 'package:aplicacao_mvvm/ui/todo_details/widgets/todo_name_widget.dart';
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
              
    final todo = viewModel.todo;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TodoName(todo: todo),
                    const SizedBox(height: 8),
                    TodoDescription(todo: todo),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: ListenableBuilder(
            listenable: widget.todoDetailsViewModel.load,
            builder: (context, child) {
              if (widget.todoDetailsViewModel.load.running ||
                  widget.todoDetailsViewModel.load.error) {
                return const SizedBox();
              }
             return child!;
            },
            child: FloatingActionButton(
          onPressed: () {showDialog(
            context: context,
            builder: (context) {
              final todo = viewModel.todo;
              return EditFormWidget(todoDetailsViewModel: viewModel,todo: todo);
            },
          );},
          child: const Icon(Icons.edit),
        )
          ),
        
         );
  }
}
