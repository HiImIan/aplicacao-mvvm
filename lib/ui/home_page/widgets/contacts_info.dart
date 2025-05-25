
import 'package:flutter/material.dart';
import 'package:open_share_plus/open.dart';

class ContactsInfo extends StatelessWidget {
  const ContactsInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            final sendEmail = await Open.mail(
                toAddress: 'iansouzagarcia@gmail.com',
                subject: 'Vi o seu aplicativo',
                body: 'Olá, Ian! Tudo bem?');
    
            if (!sendEmail) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.orange,
                  content: SizedBox(
                      height: 100,
                      child: Center(
                          child: Text(
                        'Nenhum aplicativo de email encontrado.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
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
        ),
        const SizedBox(width: 8),
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
    );
  }
}
