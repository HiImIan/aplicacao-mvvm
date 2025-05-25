import 'package:aplicacao_mvvm/config/dependences.dart';
import 'package:aplicacao_mvvm/main.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level} - ${record.loggerName} - ${record.message}');
   if (record.stackTrace != null) {
    print(record.error);    
    print(record.stackTrace);    
  }});
 
  runApp(MultiProvider(providers: providersRemote, child: const MyApp() ));
}   