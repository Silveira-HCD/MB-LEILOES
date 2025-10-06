import 'package:flutter/material.dart';
import 'leilao.dart';

class LeilaoDetalhePage extends StatelessWidget {
  const LeilaoDetalhePage({super.key});

  @override
  Widget build(BuildContext context) {
    final leilao = ModalRoute.of(context)!.settings.arguments as Leilao;

    return Scaffold(
      appBar: AppBar(
        title: Text(leilao.numero),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Esta é a tela de detalhes do leilão:'),
            const SizedBox(height: 16),
            Text(
              leilao.numero,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}