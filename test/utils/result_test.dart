import 'package:aplicacao_mvvm/utils/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Should test Ok Result', () {
    test('Should create Ok Result', () {
      final result = Result.ok('Ok');

      expect(result.asOk.value, 'Ok');
    });

    test('Should create Error Result', () {
      final result = Result.error(Exception('Ocorreu um erro...'));

      expect(result.asError.error, isA<Exception>());
    });

    test('Should create Ok Result with Extension', () {
      final result = 'Ok'.ok();

      expect(result.asOk.value, 'Ok');
    });

    test('Should create Error Result with Extension', () {
      final result = Exception('Ocorreu um erro...').error();

      expect(result.asError.error, isA<Exception>());
    });
  });
}
