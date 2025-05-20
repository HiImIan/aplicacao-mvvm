import 'package:flutter/material.dart';

class OperationFeedbackHandler {
  /// Gerencia o feedback visual para operações assíncronas
  static void handleOperationResult({
    required BuildContext context,
    required Listenable operation,
    required bool isRunning,
    required bool isCompleted,
    required bool hasError,
    String successMessage = 'Operação concluída com sucesso!',
    String errorMessage = 'Ocorreu um erro ao executar a operação!',
    Color successColor = Colors.green,
    Color errorColor = Colors.red,
    Duration snackBarDuration = const Duration(seconds: 2),
  }) {
    if (isRunning) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: IntrinsicHeight(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      
      if (isCompleted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            content: Text(successMessage),
            duration: snackBarDuration,
          ),
        );
      }
      
      if (hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: errorColor,
            content: Text(errorMessage),
            duration: snackBarDuration,
          ),
        );
      }
    }
  }

  /// Registra um listener para uma operação específica
  static void Function() registerOperationListener({
    required BuildContext context,
    required Listenable operation,
    required Function() getIsRunning,
    required Function() getIsCompleted,
    required Function() getHasError,
    String successMessage = 'Operação concluída com sucesso!',
    String errorMessage = 'Ocorreu um erro ao executar a operação!',
  }) {
    void listener() {
      handleOperationResult(
        context: context,
        operation: operation,
        isRunning: getIsRunning(),
        isCompleted: getIsCompleted(),
        hasError: getHasError(),
        successMessage: successMessage,
        errorMessage: errorMessage,
      );
    }
    
    operation.addListener(listener);
    
    // Retorna a função para remover o listener quando não for mais necessário
    return () => operation.removeListener(listener);
  }
}