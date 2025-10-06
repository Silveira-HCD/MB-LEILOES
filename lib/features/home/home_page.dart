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
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('Carlos Silveira'),
              accountEmail: const Text('silveira.hcd@gmail.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Ao Vivo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/aoVivo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Agenda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/agenda');
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Fale Conosco'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/faleConosco');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Avisos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                    ),
                    const Text('Versão 1.6.5', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Leilao>>(
        future: leiloes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final allLeiloes = snapshot.data!;
            final Leilao? proximoLeilao = allLeiloes.isNotEmpty ? allLeiloes[0] : null;

            final leilaoStart = DateTime.utc(now.year, now.month, now.day, 8, 55).subtract(const Duration(hours: 4));
            final leilaoEnd = DateTime.utc(now.year, now.month, now.day, 13, 0).subtract(const Duration(hours: 4));
            final isLive = now.weekday == DateTime.sunday && now.isAfter(leilaoStart) && now.isBefore(leilaoEnd);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (proximoLeilao != null)
                      _buildTopBanner(context, proximoLeilao, isLive),

                    const SizedBox(height: 16),

                    if (isLive)
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/aoVivo');
                        },
                        icon: const Icon(Icons.videocam),
                        label: const Text('AO VIVO'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),

                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/agenda');
                      },
                      icon: const Icon(Icons.event),
                      label: const Text('AGENDA DE LEILÕES'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/faleConosco');
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text('FALE CONOSCO'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Nenhum leilão futuro encontrado.'));
          }
        },
      ),
    );
  }

  Widget _buildTopBanner(BuildContext context, Leilao leilao, bool isLive) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/leilaoDetalhe', arguments: leilao);
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage('assets/images/${leilao.imagemBanner}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            if (isLive)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/aoVivo');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.red.withOpacity(0.8),
                    child: const Text(
                      'AO VIVO AGORA!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}