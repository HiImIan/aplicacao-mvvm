import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/ui/common/utils/operation_feedback_handler.dart';
import 'package:aplicacao_mvvm/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:flutter/material.dart';

class AddFormWidget extends StatefulWidget {
  final TodoViewModel todoViewModel;
  const AddFormWidget({super.key, required this.todoViewModel});

  @override
  State<AddFormWidget> createState() => _AddFormWidgetState();
}

class _AddFormWidgetState extends State<AddFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final verticalGap = const SizedBox(height: 16);

  Function? _feedBackListener;

  @override
  void initState() {
    super.initState();
    _feedBackListener = OperationFeedbackHandler.registerOperationListener(
      context: context,
      operation: widget.todoViewModel.addTodo,
      getIsRunning: () => widget.todoViewModel.addTodo.running,
      getIsCompleted: () => widget.todoViewModel.addTodo.completed,
      getHasError: () => widget.todoViewModel.addTodo.error,
      successMessage: 'Formulário enviado com sucesso!',
      errorMessage: 'Erro ao adicionar o a fazer!',
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    if (_feedBackListener != null) {
      _feedBackListener!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicHeight(
        child: SingleChildScrollView(
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
                verticalGap,
                TextFormField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Descrição da tarefa',
                      labelText: 'Descrição da tarefa',
                      border: OutlineInputBorder()),
                ),
                verticalGap,
                ElevatedButton(
                  onPressed: () async {
                    final addTodo = widget.todoViewModel.addTodo;
                    if (_formKey.currentState!.validate()) {
                      await addTodo.execute(TodoInfo(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          done: false));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
