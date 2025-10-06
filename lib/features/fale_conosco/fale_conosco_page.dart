import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaleConoscoPage extends StatelessWidget {
  const FaleConoscoPage({super.key});

  void _launchWhatsApp({required String number, required String message}) async {
    final url = Uri.parse('whatsapp://send?phone=$number&text=$message');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fale Conosco'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Entre em contato com nossa equipe!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Botão para o WhatsApp do Financeiro
              ElevatedButton.icon(
                onPressed: () => _launchWhatsApp(
                  number: '+5565996009644',
                  message: 'Olá, gostaria de falar com o financeiro da MB Leilões',
                ),
                icon: const Icon(Icons.phone),
                label: const Text('Financeiro'),
              ),
              const SizedBox(height: 16),

              // Botão para o WhatsApp de Vendas
              ElevatedButton.icon(
                onPressed: () => _launchWhatsApp(
                  number: '+5565981430544',
                  message: 'Olá, gostaria de falar com a equipe de vendas.',
                ),
                icon: const Icon(Icons.phone),
                label: const Text('Vendas - Jennifer'),
              ),
              const SizedBox(height: 16),

              // Botão para o WhatsApp de vendas
              ElevatedButton.icon(
                onPressed: () => _launchWhatsApp(
                  number: '+5565981711994',
                  message: 'Olá, gostaria de falar com a equipe de vendas',
                ),
                icon: const Icon(Icons.phone),
                label: const Text('Vendas - Barbara'),
              ),
              const SizedBox(height: 30),

              const Text(
                'Siga-nos nas redes sociais:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Botões para as redes sociais
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async => await launchUrl(Uri.parse('https://www.instagram.com/mbleiloes')),
                    icon: const Icon(Icons.camera_alt), // Ícone do insta
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () async => await launchUrl(Uri.parse('https://www.tiktok.com/@mbleiloesmt')),
                    icon: const Icon(Icons.tiktok), // Ícone do ttk
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () async => await launchUrl(Uri.parse('https://www.youtube.com/@mbleiloes/featured')),
                    icon: const Icon(Icons.play_circle_fill), // Ícone do yt
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () async => await launchUrl(Uri.parse('https://www.facebook.com/mbleiloes')),
                    icon: const Icon(Icons.facebook), // ícone do fb
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}