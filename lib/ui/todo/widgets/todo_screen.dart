import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/add_todo_widget.dart';
import 'package:aplicacao_mvvm/ui/todo/widgets/todos_list.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  final TodoViewmodel todoViewmodel;
  const TodoScreen({super.key, required this.todoViewmodel});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    widget.todoViewmodel.deleteTodo.addListener(_onResult);
  }

  void _onResult() {
    if (widget.todoViewmodel.deleteTodo.running) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: IntrinsicHeight(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          });
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (widget.todoViewmodel.deleteTodo.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Tarefa removida com sucesso!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      if (widget.todoViewmodel.deleteTodo.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ocorreu um erro ao remover a tarefa!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.todoViewmodel.deleteTodo.removeListener(_onResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Screen')),
      body: ListenableBuilder(
        listenable: widget.todoViewmodel.load,
        builder: (context, child) {
          if (widget.todoViewmodel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.todoViewmodel.load.error) {
            return const Center(
                child: Text('Ocorreu um erro ao carregar todos...'));
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.todoViewmodel,
          builder: (context, child) {
            return TodosList(
              onDeleteTodo: (todo) {
                widget.todoViewmodel.deleteTodo.execute(todo);
              },
              todos: widget.todoViewmodel.todos,
              todoViewmodel: widget.todoViewmodel,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoWidget(todoViewmodel: widget.todoViewmodel);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
