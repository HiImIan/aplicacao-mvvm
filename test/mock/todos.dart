import 'package:aplicacao_mvvm/data/services/api/models/todo/todo_api_model.dart';
import 'package:aplicacao_mvvm/domain/models/todo.dart';
import 'package:aplicacao_mvvm/domain/models/todo_infos.dart';

const mockGetById = Todo(
  id: '1',
  todoInfo: TodoInfo(name: 'i was got', description: 'later', done: false),
);

const createTodoMock =
    CreateTodoApiModel(name: 'i was created', description: 'now', done: false);

const addTodoMock = Todo(
    id: '1',
    todoInfo: TodoInfo(name: 'i was created', description: 'now', done: false));

final List<Todo> todos = [
  addTodoMock,const Todo(
    id: '2',
    todoInfo: TodoInfo(name: 'i was created today', description: 'later', done: true))
];

const updateTodoMock =  UpdateTodoApiModel(id: '1',name: 'novo nome',description: 'nova descrição',done: true);

const updateTodoResultMock = Todo(
  id: '1',
  todoInfo: TodoInfo(name: 'novo nome', description: 'nova descrição', done: true),
);