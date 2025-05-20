import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

abstract class TodosRepository extends ChangeNotifier{

  List<Todo> get todos;

  Future<Result<List<Todo>>> get();

  Future<Result<Todo>> getById(String id);

  Future<Result<Todo>> add(TodoInfo name);

  Future<Result<Todo>> update(Todo todo);
  
  Future<Result<void>> delete(Todo todo);
}
