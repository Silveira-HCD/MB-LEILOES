import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../leilao/leilao.dart';
import '../leilao/leilao_detalhe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Leilao>> leiloes;

  @override
  void initState() {
    super.initState();
    leiloes = loadAllLeiloes();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(40, 25, 15, 0.95),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // 🔹 DrawerHeader sem texto, apenas logo ajustável
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.orangeAccent),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 180, // ajuste livre aqui
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Início', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: Colors.white),
              title: const Text('Ao Vivo', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/aoVivo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.event, color: Colors.white),
              title: const Text('Agenda de Leilões', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/agenda');
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.white),
              title: const Text('Fale Conosco', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/faleConosco');
              },
            ),
            const Divider(color: Colors.white54),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.white70),
              title: const Text('Sobre o App', style: TextStyle(color: Colors.white70)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Início'),
        backgroundColor: Colors.orangeAccent.withOpacity(0.9),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fundo_bois.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: FutureBuilder<List<Leilao>>(
              future: leiloes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }

                final allLeiloes = snapshot.data ?? [];
                if (allLeiloes.isEmpty) {
                  return const Center(child: Text('Nenhum leilão encontrado.'));
                }

                allLeiloes.sort((a, b) {
                  final dateA = DateFormat('dd/MM').parse(a.data);
                  final dateB = DateFormat('dd/MM').parse(b.data);
                  return dateB.compareTo(dateA);
                });

                final proximoLeilao = allLeiloes.first;

                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTopBanner(context, proximoLeilao),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/aoVivo'),
                            icon: const Icon(Icons.videocam),
                            label: const Text('AO VIVO'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/agenda'),
                            icon: const Icon(Icons.event),
                            label: const Text('AGENDA DE LEILÕES'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/faleConosco'),
                            icon: const Icon(Icons.chat),
                            label: const Text('FALE CONOSCO'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBanner(BuildContext context, Leilao leilao) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/leilaoDetalhe', arguments: leilao);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/${leilao.imagemBanner}',
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.live_tv, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'AO VIVO AGORA!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
