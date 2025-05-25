import 'package:aplicacao_mvvm/routing/router.dart';
import 'package:flutter/material.dart';
import 'main_staging.dart' as staging;

void main() => staging.main();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: false,
      ),
      routerConfig: routerConfig(),
    );
  }
}
