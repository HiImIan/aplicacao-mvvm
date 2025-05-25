
import 'package:flutter/material.dart';

class TutorialExplain extends StatelessWidget {  final TextStyle titleStyle;
  final EdgeInsets topicsHorizontalPadding;
  final TextStyle topicsStyle;
  const TutorialExplain({
    super.key,
    required this.titleStyle,
    required this.topicsHorizontalPadding,
    required this.topicsStyle,
  });



  @override
  Widget build(BuildContext context) {
    const sizedBoxHeight = SizedBox(height: 8);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'O que você pode fazer neste aplicativo:',
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
                Text('• Adicionar uma nova tarefa com Nome e Descrição.',
                    style: topicsStyle),
                sizedBoxHeight,
                Text('• Marcar uma tarefa como concluída.',
                    style: topicsStyle),
                sizedBoxHeight,
                Text('• Editar uma tarefa.', style: topicsStyle),
               sizedBoxHeight,
                Text('• Remover uma tarefa.', style: topicsStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
