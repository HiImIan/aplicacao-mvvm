import 'package:aplicacao_mvvm/routing/routes.dart';
import 'package:aplicacao_mvvm/ui/home_page/widgets/contacts_info.dart';
import 'package:aplicacao_mvvm/ui/home_page/widgets/objetive_explain.dart';
import 'package:aplicacao_mvvm/ui/home_page/widgets/tutorial_explain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    const topicsHorizontalPadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 4);
    const sizedBoxHeight =  SizedBox(height: 40);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introdução'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: topicsHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24),
            ObjectiveExplain(
              topicsHorizontalPadding: topicsHorizontalPadding,
                titleStyle: titleStyle, topicsStyle: topicsStyle),
           sizedBoxHeight,
            TutorialExplain(titleStyle: titleStyle, topicsHorizontalPadding: topicsHorizontalPadding, topicsStyle: topicsStyle),
           sizedBoxHeight,
            Text('Contate-me:', style: titleStyle),
            SizedBox(height: 8),
            ContactsInfo(),
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
