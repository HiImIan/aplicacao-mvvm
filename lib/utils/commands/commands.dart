import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter/material.dart';

// Command 0 não possui parametros de entrada
typedef CommandAction0<Output> = Future<Result<Output>> Function();

// Command 1 possui um parametro de entrada
typedef CommandAction1<Output, Input> = Future<Result<Output>> Function(
    Input input);

abstract class Command<Output> extends ChangeNotifier {
  // verifica se o command esttá em execução
  bool _running = false;

  bool get running => _running;

  // representação do estado, como Ok ou Error ou Null
  Result<Output>? _result;

  Result<Output>? get result => _result;

  // verifica se o estado é completo
  bool get completed => _result is Ok;

  // verifica se houve erro
  bool get error => _result is ResultError;

  Future<void> _execute(CommandAction0<Output> action) async {
    if (_running) return; // se já estiver em execução, não faz nada

    _running = true; // marca como em execução
    _result = null; // reinicia o resultado

    notifyListeners(); // notifica os ouvintes

    try {
      _result = await action(); // executa a ação e armazena o resultado
    } finally {
      _running = false; // marca como não em execução
      notifyListeners(); // notifica os ouvintes novamente
    }
  }
}

class Command0<Output> extends Command<Output> {
  final CommandAction0<Output> action;

  Command0(this.action);

  Future<void> execute() async {
    await _execute(() => action());
  }
}

class Command1<Output, Input> extends Command<Output> {
  final CommandAction1<Output, Input> action;
  Command1(this.action);

  Future<void> execute(Input params) async {
    await _execute(() => action(params));
  }
}
