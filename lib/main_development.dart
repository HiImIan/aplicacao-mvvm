import 'package:aplicacao_mvvm/config/dependences.dart';
import 'package:aplicacao_mvvm/main.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  runApp(MultiProvider(providers: providersLocal,child: const MyApp(),));
}
