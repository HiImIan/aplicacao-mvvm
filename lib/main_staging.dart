import 'package:aplicacao_mvvm/config/dependences.dart';
import 'package:aplicacao_mvvm/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: providersRemote, child: const MyApp() ));
}