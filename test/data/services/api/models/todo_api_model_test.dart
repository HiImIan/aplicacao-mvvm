// ignore_for_file: avoid_print

import 'package:aplicacao_mvvm/data/services/api/models/todo/todo_api_model.dart';

void main() {
  const TodoApiModel todoApiModel = TodoApiModel.create(name: 'teste');
  print(todoApiModel.toJson());
  const todoCreate = CreateTodoApiModel(name: 'Teste');
  print(todoCreate.toJson());

  const todoUpdate = UpdateTodoApiModel(id: '1', name: 'Teste');
  print(todoUpdate.toJson());
}
