import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:flutter/material.dart';

class AddTodoWidget extends StatefulWidget {
  final TodoViewmodel todoViewmodel;
  const AddTodoWidget({super.key, required this.todoViewmodel});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final verticalGap = const SizedBox(height: 16);

  @override
  void initState() {
    super.initState();
    widget.todoViewmodel.addTodo.addListener(_onResult);
  }

  void _onResult() {
    if (widget.todoViewmodel.addTodo.running) {
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
      if (widget.todoViewmodel.addTodo.completed) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Tarefa adicionada com sucesso!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      if (widget.todoViewmodel.addTodo.error) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ocorreu um erro ao adicionar a tarefa!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    widget.todoViewmodel.addTodo.removeListener(_onResult);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicHeight(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Adicionar Todo'),
              verticalGap,
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    hintText: 'Nome da tarefa',
                    labelText: 'Nome da tarefa',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim() == '') {
                    return 'Campo obrigatório!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.todoViewmodel.addTodo.execute(_nameController.text);
                    _nameController.clear();
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
