import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../leilao/leilao.dart';
import '../leilao/leilao_detalhe_page.dart';
import '../leilao/live_stream_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Leilao? leilao;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    carregarLeilao();
  }

  Future<void> carregarLeilao() async {
    try {
      final snapshot =
      await FirebaseFirestore.instance.collection('leiloes').limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          leilao = Leilao.fromFirestore(snapshot.docs.first);
        });
      }
    } catch (e) {
      print('Erro ao carregar leilão: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Início'),
        backgroundColor: Colors.orangeAccent.withOpacity(0.9),
        elevation: 0,
      ),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/fundo_bois.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: leilao == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTopBanner(context, leilao!),
                  const SizedBox(height: 16),
                  if (leilao!.frase1.isNotEmpty)
                    Text(
                      leilao!.frase1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (leilao!.frase2.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        leilao!.frase2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),


                  if (leilao!.aoVivo)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LiveStreamPage(
                              canalUrl: leilao!.aoVivoUrl,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.videocam, color: Colors.black),
                      label: const Text(
                        'AO VIVO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),
                  _buildButton(
                    context,
                    icon: Icons.event,
                    label: 'AGENDA DE LEILÕES',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/agenda'),
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    context,
                    icon: Icons.chat,
                    label: 'FALE CONOSCO',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/faleConosco'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(40, 25, 15, 0.95),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orangeAccent),
            child: Center(
              child: Image.asset('assets/images/logo.png', height: 90),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Início', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.event, color: Colors.white),
            title: const Text('Agenda de Leilões',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/agenda');
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat, color: Colors.white),
            title: const Text('Fale Conosco',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/faleConosco');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopBanner(BuildContext context, Leilao leilao) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/leilaoDetalhe',
          arguments: leilao,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          leilao.bannerUrl,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.broken_image, size: 50, color: Colors.orangeAccent),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      icon: Icon(icon, color: Colors.black),
      label: Text(
        label,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
