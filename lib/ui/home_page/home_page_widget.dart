import 'package:aplicacao_mvvm/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const titleStyle =  TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    const topicsStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const topicsHorizontalPadding =  EdgeInsets.symmetric(horizontal: 20.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introdução'),
        centerTitle: true,
      ),
      body:  Padding(
        padding: topicsHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24),
            Text(
              'Objetivo do aplicativo:',
              style: titleStyle,
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Visualizar e gerenciar tarefas',
                        style: topicsStyle),
                    Text('• Navegar entre diferentes telas do app',
                        style: topicsStyle),
                    Text('• Explorar uma arquitetura moderna (MVVM)',
                        style: topicsStyle),
                    Text('• Testar funcionalidades integradas com backend',
                        style: topicsStyle),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'O que você pode fazer neste aplicativo:',
              style: titleStyle,
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: topicsHorizontalPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Adicionar uma nova tarefa com Nome e Descrição',
                        
                        style: topicsStyle),
                    Text('• Marcar uma tarefa como concluída',
                        style: topicsStyle),
                    Text('• Remover uma tarefa', 
                        style: topicsStyle),
                    Text('• Editar uma tarefa',
                        style: topicsStyle),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () async {
                const url = 'https://wa.me/SEUNUMERO'; // Substitua pelo seu número
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              child: Image.network(
                'https://play-lh.googleusercontent.com/gmSt5wthfRdyU70ffBIHNS9cUGsMnn0W2GK8nkjUMcmgIgthZce97_6NkHZcq8NN0OA',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24),
              ],
            ),
            
        ),
      bottomSheet: SizedBox(
              width: double.maxFinite,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  context.pushReplacement (Routes.todos);
                },
                child: const Text('Vamos começar!',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ),
    );
  }
}
