import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/add_form_widget.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/todos_list.dart';
import 'package:aplicacao_mvvm/ui/common/utils/operation_feedback_handler.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  final TodoViewModel todoViewModel;
  const TodoScreen({super.key, required this.todoViewModel});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Function? _removeListener;

  @override
  void initState() {
    super.initState();
    
    // Registra o listener usando a classe utilitária
    _removeListener = OperationFeedbackHandler.registerOperationListener(
      context: context,
      operation: widget.todoViewModel.deleteTodo,
      getIsRunning: () => widget.todoViewModel.deleteTodo.running,
      getIsCompleted: () => widget.todoViewModel.deleteTodo.completed,
      getHasError: () => widget.todoViewModel.deleteTodo.error,
      successMessage: 'Tarefa removida com sucesso!',
      errorMessage: 'Ocorreu um erro ao remover a tarefa!',
    );
  }

  @override
  void dispose() {
    // Remove o listener usando a função retornada
    if (_removeListener != null) {
      _removeListener!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Screen')),
      body: ListenableBuilder(
        listenable: widget.todoViewModel.load,
        builder: (context, child) {
          if (widget.todoViewModel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.todoViewModel.load.error) {
            return const Center(
                child: Text('Ocorreu um erro ao carregar todos...'));
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.todoViewModel,
          builder: (context, child) {
            return TodosList(
              onDeleteTodo: (todo) {
                widget.todoViewModel.deleteTodo.execute(todo);
              },
              todos: widget.todoViewModel.todos,
              todoViewmodel: widget.todoViewModel,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddFormWidget(todoViewModel: widget.todoViewModel);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
