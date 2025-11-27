import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_mb_teste/features/leilao/leilao.dart';
import 'package:projeto_mb_teste/features/leilao/lote_video_page.dart';

class LotesPage extends StatelessWidget {
  final Leilao leilao;

  const LotesPage({super.key, required this.leilao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lotes do ${leilao.titulo}'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo_bois.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('leiloes')
              .doc(leilao.id)
              .collection('lotes')
              .orderBy('ordem')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar lotes.'));
            }


            final docs = snapshot.data?.docs ?? [];


            final lotes = docs.where((doc) {
              final dado = doc.data() as Map<String, dynamic>;
              return dado['ativo'] == true;
            }).toList();

            if (lotes.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum lote disponível no momento.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lotes.length,
              itemBuilder: (context, index) {
                final lote = lotes[index].data() as Map<String, dynamic>;

                final nome = lote['nome'] ?? 'Lote sem nome';
                final descricao = lote['descricao'] ?? '';
                final imagem = lote['imagem'] ?? leilao.bannerUrl;
                final videoUrl = lote['videoUrl'] ?? '';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imagem,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(
                      nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    subtitle: Text(
                      descricao,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(
                      Icons.play_circle_fill,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onTap: () {
                      if (videoUrl.isEmpty) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoteVideoPage(
                            videoUrl: videoUrl,
                            titulo: nome,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
