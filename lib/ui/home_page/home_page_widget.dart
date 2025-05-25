import 'package:aplicacao_mvvm/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_share_plus/open.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    const topicsStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const topicsHorizontalPadding = EdgeInsets.symmetric(horizontal: 20.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introdução'),
        centerTitle: true,
      ),
      body: Padding(
        padding: topicsHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 24),
            const Text(
              'Objetivo do aplicativo:',
              style: titleStyle,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Visualizar e gerenciar tarefas.',
                        style: topicsStyle),
            SizedBox(height: 8),
                    Text('• Navegar entre diferentes telas do app.',
                        style: topicsStyle),
            SizedBox(height: 8),
                    Text('• Explorar uma arquitetura moderna (MVVM).',
                        style: topicsStyle),
            SizedBox(height: 8),
                    Text('• Testar funcionalidades integradas com backend.',
                        style: topicsStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'O que você pode fazer neste aplicativo:',
              style: titleStyle,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: topicsHorizontalPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Adicionar uma nova tarefa com Nome e Descrição.',
                        style: topicsStyle),
                    SizedBox(height: 8),
                    Text('• Marcar uma tarefa como concluída.',
                        style: topicsStyle),
                    SizedBox(height: 8),
                    Text('• Editar uma tarefa.', style: topicsStyle),
                    SizedBox(height: 8),
                    Text('• Remover uma tarefa.', style: topicsStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Contate-me:', style: titleStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await Open.whatsApp(
                        whatsAppNumber: "5551993621435",
                        text: "Ian Souza Garcia");
                  },
                  child: Image.network(
                    'https://img.icons8.com/?size=100&id=16713&format=png&color=000000',
                    width: 48,
                    height: 48,
                  ),
                ),
           
            const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                   final sendEmail = await Open.mail(toAddress: 'iansouzagarcia@gmail.com',subject: 'Vi o seu aplicativo',body: 'Olá, Ian! Tudo bem?');
                  
                  if (!sendEmail) {
                     ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orange,
            content: SizedBox(
              height: 100,
              child: Center(child: Text('Nenhum aplicativo de email encontrado.',style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))),
            duration: Duration(seconds: 2),
          ),
        );
                  }
                  },
                  child: Image.network(
                    'https://img.icons8.com/?size=100&id=P7UIlhbpWzZm&format=png&color=000000',
                    width: 48,
                    height: 48,
                  ),
                ), const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    await Open.browser(
                        url: "https://www.linkedin.com/in/ian-s-g/");
                  },
                  child: Image.network(
                    'https://img.icons8.com/?size=100&id=xuvGCOXi8Wyg&format=png&color=000000',
                    width: 48,
                    height: 48,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        width: double.maxFinite,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            context.pushReplacement(Routes.todos);
          },
          child: const Text(
            'Vamos começar!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
