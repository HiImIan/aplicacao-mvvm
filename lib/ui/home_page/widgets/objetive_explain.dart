import 'package:flutter/material.dart';

class ObjectiveExplain extends StatelessWidget {
  final TextStyle titleStyle;
  final TextStyle topicsStyle;
  final EdgeInsets topicsHorizontalPadding;
  const ObjectiveExplain({
    super.key,
    required this.titleStyle,
    required this.topicsStyle, required this.topicsHorizontalPadding,
  });


  @override
  Widget build(BuildContext context) {
    const sizedBoxHeight = SizedBox(height: 8);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Objetivo do aplicativo:',
          style: titleStyle,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: topicsHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Visualizar e gerenciar tarefas.', style: topicsStyle),
                sizedBoxHeight,
                Text('• Navegar entre diferentes telas do app.',
                    style: topicsStyle),
                sizedBoxHeight,
                Text('• Explorar uma arquitetura moderna (MVVM).',
                    style: topicsStyle),
                sizedBoxHeight,
                Text('• Testar funcionalidades integradas com backend.',
                    style: topicsStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
