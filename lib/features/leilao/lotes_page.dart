import 'package:flutter/material.dart';
import 'package:projeto_mb_teste/features/leilao/leilao.dart';
import 'package:projeto_mb_teste/features/leilao/lote_video_page.dart';

class LotesPage extends StatelessWidget {
  final Leilao leilao;

  const LotesPage({super.key, required this.leilao});

  @override
  Widget build(BuildContext context) {
    final lotes = [
      {'numero': '2', 'video': 'https://youtu.be/fHkW065unsY'},
      {'numero': '4', 'video': 'https://youtu.be/k1qAsCZgPIM'},
      {'numero': '11', 'video': 'https://youtu.be/6-oW67JB2Sk'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lotes do ${leilao.numero}'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fundo_bois.png',
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
            itemCount: lotes.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final lote = lotes[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text('Lote ${lote['numero']}'),
                  trailing: const Icon(Icons.play_circle_fill, color: Colors.red),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoteVideoPage(videoUrl: lote['video']!),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
