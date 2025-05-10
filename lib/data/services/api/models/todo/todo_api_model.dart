import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_api_model.freezed.dart';
part 'todo_api_model.g.dart';

// command to generate the code:
// dart pub run build_runner build
@freezed
class TodoApiModel with _$TodoApiModel {
  const factory TodoApiModel.create({
    required String name,
  }) = CreateTodoApiModel;

  const factory TodoApiModel.update({
    required String id,
    required String name,
  }) = UpdateTodoApiModel;

  factory TodoApiModel.fromJson(Map<String, Object?> json) =>
      _$TodoApiModelFromJson(json);
}
