// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';

class Todo {
  final String id;
  final TodoInfo todoInfo;

  const Todo({required this.id, required this.todoInfo});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(id: json['id'], todoInfo: TodoInfo.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': todoInfo.name,
      'description': todoInfo.description,
      'done': todoInfo.done
    };
  }

  Todo copyWith({
    String? id,
    TodoInfo? todoInfo,
  }) {
    return Todo(
      id: id ?? this.id,
      todoInfo: todoInfo ?? this.todoInfo,
    );
  }
}
