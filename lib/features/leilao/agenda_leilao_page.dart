import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'leilao.dart';
import 'leilao_detalhe_page.dart';

class AgendaLeilaoPage extends StatefulWidget {
  const AgendaLeilaoPage({super.key});

  @override
  State<AgendaLeilaoPage> createState() => _AgendaLeilaoPageState();
}

class _AgendaLeilaoPageState extends State<AgendaLeilaoPage> {
  late Future<Map<String, dynamic>> dadosAgenda;

  @override
  void initState() {
    super.initState();
    dadosAgenda = carregarAgendaCompleta();
  }




  Future<Map<String, dynamic>> carregarAgendaCompleta() async {
    final Map<String, dynamic> resultado = {};


    final atualSnap = await FirebaseFirestore.instance
        .collection('leiloes')
        .orderBy('data')
        .limit(1)
        .get();

    if (atualSnap.docs.isNotEmpty) {
      resultado['atual'] = Leilao.fromFirestore(atualSnap.docs.first);
    } else {
      resultado['atual'] = null;
    }


    final futurosSnap = await FirebaseFirestore.instance
        .collection('agenda_leiloes')
        .orderBy('data')
        .get();

    List<Leilao> futuros = futurosSnap.docs.map((doc) {
      final data = doc.data();
      return Leilao(
        id: doc.id,
        titulo: data['titulo'] ?? '',
        data: data['data'] ?? '',
        horario: data['horario'] ?? '',
        canal: data['canal'] ?? '',
        imagemCard: data['imagemCard'] ?? '',
        imagemBanner: data['imagemBanner'] ?? '',
      );
    }).toList();

    resultado['futuros'] = futuros;

    return resultado;
  }

  String formatarData(String d) {
    if (d.contains('/')) return d;
    try {
      final p = d.split('-');
      return '${p[2]}/${p[1]}/${p[0]}';
    } catch (_) {}
    return d;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de Leilões'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/fundo_bois.png', fit: BoxFit.cover),
          ),

          FutureBuilder<Map<String, dynamic>>(
            future: dadosAgenda,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final dados = snapshot.data!;
              final Leilao? leilaoAtual = dados['atual'];
              final List<Leilao> futuros = dados['futuros'];

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (leilaoAtual != null) ...[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, left: 4),
                      child: Text(
                        "Próximo Leilão",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _cardLeilao(leilaoAtual, context),
                    const SizedBox(height: 20),
                  ],

                  if (futuros.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, left: 4),
                      child: Text(
                        "Leilões futuros",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ...futuros.map((l) => _cardLeilao(l, context)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _cardLeilao(Leilao leilao, BuildContext context) {
    final dataFormatada = formatarData(leilao.data);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.9),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: (leilao.imagemCard.isNotEmpty &&
              (leilao.imagemCard.startsWith('http')))
              ? Image.network(
            leilao.imagemCard,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          )
              : Container(
            width: 80,
            height: 80,
            color: Colors.orangeAccent.withOpacity(0.2),
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported, color: Colors.brown),
          ),
        ),

        title: Text(
          leilao.titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.black54),
                const SizedBox(width: 4),
                Text(dataFormatada, style: const TextStyle(color: Colors.black54)),
              ],
            ),
            if (leilao.canal.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.live_tv, size: 14, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(leilao.canal, style: const TextStyle(color: Colors.black54)),
                ],
              ),
          ],
        ),

        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orangeAccent),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LeilaoDetalhePage(leilao: leilao),
            ),
          );
        },
      ),
    );
  }
}
