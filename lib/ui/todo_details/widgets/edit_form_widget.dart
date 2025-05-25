import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/ui/common/utils/operation_feedback_handler.dart';
import 'package:aplicacao_mvvm/ui/todo_details/viewmodel/todo_details_viewmodel.dart';
import 'package:flutter/material.dart';

class EditFormWidget extends StatefulWidget {
  final TodoDetailsViewModel todoDetailsViewModel;
  final Todo todo;
  const EditFormWidget(
      {super.key, required this.todoDetailsViewModel, required this.todo});

  @override
  State<EditFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<EditFormWidget> {
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
      operation: widget.todoDetailsViewModel.updateTodo,
      getIsRunning: () => widget.todoDetailsViewModel.updateTodo.running,
      getIsCompleted: () => widget.todoDetailsViewModel.updateTodo.completed,
      getHasError: () => widget.todoDetailsViewModel.updateTodo.error,
      successMessage: 'Formulário editado com sucesso!',
      errorMessage: 'Erro ao editar o formulário!',
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
    final todoId = widget.todo.id;
    final todo = widget.todo;
    final todoInfo = todo.todoInfo;
    _nameController.text = todoInfo.name;
    _descriptionController.text = todoInfo.description;
    return AlertDialog(
      content: IntrinsicHeight(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Editar Todo'),
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
                  onPressed: () {
                    final updateTodo = widget.todoDetailsViewModel.updateTodo;
                    if (_formKey.currentState!.validate()) {
                      final newTodoInfo = todoInfo.copyWith(
                        name: _nameController.text,
                        description: _descriptionController.text,
                      );
                      final todoUpdated = todo.copyWith(todoInfo: newTodoInfo);
                      updateTodo.execute(todoUpdated).whenComplete(() => Navigator.of(context).pop());
                    }
                  },
                  child: Text('Editar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
