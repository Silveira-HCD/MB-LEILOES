import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaleConoscoPage extends StatelessWidget {
  const FaleConoscoPage({super.key});

  Future<void> _launchWhatsApp({
    required String number,
    required String message,
  }) async {
    final Uri url = Uri.parse('https://wa.me/$number?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(globalNavigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fale Conosco')),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fundo_bois.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Conteúdo principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Entre em contato com nossa equipe!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // 1️⃣ Murilo
                    ElevatedButton.icon(
                      onPressed: () => _launchWhatsApp(
                        number: '5565999722622',
                        message:
                        'Olá, gostaria de falar com Murilo sobre vendas.',
                      ),
                      icon: const Icon(Icons.phone),
                      label: const Text('Vendas - Murilo'),
                    ),
                    const SizedBox(height: 16),

                    // 2️⃣ Financeiro
                    ElevatedButton.icon(
                      onPressed: () => _launchWhatsApp(
                        number: '5565996009644',
                        message:
                        'Olá, gostaria de falar com o financeiro da MB Leilões.',
                      ),
                      icon: const Icon(Icons.phone),
                      label: const Text('Financeiro'),
                    ),
                    const SizedBox(height: 16),

                    // 3️⃣ Jennifer
                    ElevatedButton.icon(
                      onPressed: () => _launchWhatsApp(
                        number: '5565981430544',
                        message:
                        'Olá, gostaria de falar com a Jennifer sobre vendas',
                      ),
                      icon: const Icon(Icons.phone),
                      label: const Text('Vendas - Jennifer'),
                    ),
                    const SizedBox(height: 16),

                    // 4️⃣ Barbara
                    ElevatedButton.icon(
                      onPressed: () => _launchWhatsApp(
                        number: '5565981711994',
                        message:
                        'Olá, gostaria de falar com a Barbara sobre vendas.',
                      ),
                      icon: const Icon(Icons.phone),
                      label: const Text('Vendas - Barbara'),
                    ),
                    const SizedBox(height: 40),

                    // 5️⃣ Desenvolvedor
                    TextButton(
                      onPressed: () => _launchWhatsApp(
                        number: '5565981277267',
                        message:
                        'Olá, estou entrando em contato com o desenvolvedor Carlos.',
                      ),
                      child: const Text(
                        'Falar com o Desenvolvedor',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
