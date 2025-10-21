import 'package:flutter/material.dart';
import '../leilao/leilao.dart';
import '../leilao/leilao_detalhe_page.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late Future<List<Leilao>> leiloes;

  @override
  void initState() {
    super.initState();
    leiloes = loadAllLeiloes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda de Leilões')),
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
          FutureBuilder<List<Leilao>>(
            future: leiloes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final allLeiloes = snapshot.data!;
                return ListView.builder(
                  itemCount: allLeiloes.length,
                  itemBuilder: (context, index) {
                    final leilao = allLeiloes[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/${leilao.imagemCard}',
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text('${leilao.numero}º Leilão'),
                        subtitle: Text('${leilao.data} - ${leilao.horario}'),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/leilaoDetalhe',
                            arguments: leilao,
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('Nenhum leilão disponível.'));
              }
            },
          ),
        ],
      ),
    );
  }
}
