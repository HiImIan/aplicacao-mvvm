import 'package:aplicacao_mvvm/utils/commands/commands.dart';
import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Should test commands', () {
    test('Should test command0 returns Ok', () async {
      final command0 = Command0<String>(getOkResult);

      expect(command0.completed, false);
      expect(command0.running, false);
      expect(command0.error, false);
      expect(command0.result, isNull);

      await command0.execute();
      expect(command0.error, false);
      expect(command0.running, false);
      expect(command0.result, isNotNull);

      expect(command0.result!.asOk.value,
          'The operation has been completed successfully!');
    });

    test('Should test command0 returns Ok', () async {
      final command0 = Command0<String>(getErrorResult);

      expect(command0.completed, false);
      expect(command0.running, false);
      expect(command0.error, false);
      expect(command0.result, isNull);

      await command0.execute();
      expect(command0.error, true);
      expect(command0.running, false);
      expect(command0.result, isNotNull);

      expect(command0.result!.asError.error, isA<Exception>());
    });

    test('Should test Command1 Ok result', () async {
      final command1 = Command1<String, String>(getOkResult1);

      expect(command1.running, false);
      expect(command1.error, false);
      expect(command1.completed, false);
      expect(command1.result, isNull);

      await command1.execute('Test');

      expect(command1.running, false);
      expect(command1.error, false);
      expect(command1.completed, true);

      expect(command1.result, isA<Ok>());
      expect(command1.result!.asOk.value, 'Test');
    });

    test('Should test Command1 Error result', () async {
      final command1 = Command1<bool, String>(getErrorResult1);

      expect(command1.running, false);
      expect(command1.error, false);
      expect(command1.completed, false);
      expect(command1.result, isNull);

      await command1.execute('Test');

      expect(command1.running, false);
      expect(command1.error, true);
      expect(command1.completed, false);

      expect(command1.result, isA<ResultError>());
    });
  });
}

Future<Result<String>> getOkResult() async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.ok('The operation has been completed successfully!');
}

Future<Result<String>> getErrorResult() async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.error(
      Exception('The operation has been completed with error!'));
}

Future<Result<String>> getOkResult1(String params) async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.ok(params);
}

Future<Result<bool>> getErrorResult1(String params) async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.error(Exception('Return Error with params: $params'));
}
