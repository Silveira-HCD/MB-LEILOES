import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'leilao.dart';

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
      appBar: AppBar(
        title: const Text('Agenda de Leilões'),
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
                Navigator.pushReplacementNamed(context, '/home');
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
          } else if (snapshot.hasData) {
            final now = DateTime.now();
            final allLeiloes = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: allLeiloes.length,
              itemBuilder: (context, index) {
                final leilao = allLeiloes[allLeiloes.length - 1 - index];
                final leilaoDateTimeCuiaba = DateFormat('dd/MM HH:mm').parse('${leilao.data} 09:00');
                final isLive = now.isAfter(leilaoDateTimeCuiaba.subtract(const Duration(minutes: 5))) && now.isBefore(leilaoDateTimeCuiaba.add(const Duration(hours: 1, minutes: 30)));

                final VoidCallback? onTapAction;
                if (isLive) {
                  onTapAction = () {
                    Navigator.pushNamed(context, '/aoVivo');
                  };
                } else if (now.isAfter(leilaoDateTimeCuiaba)) {
                  onTapAction = () {
                    Navigator.pushNamed(context, '/leilaoDetalhe', arguments: leilao);
                  };
                } else {
                  onTapAction = null;
                }

                return GestureDetector(
                  onTap: onTapAction,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 60,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  leilao.numero,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  softWrap: true,
                                ),
                                if (isLive)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    color: Colors.red,
                                    child: const Text(
                                      'AO VIVO',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      leilao.data,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.access_time, size: 16),
                                    const SizedBox(width: 4),
                                    const Text(
                                      '09:00h (MT)',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Nenhum leilão futuro encontrado.'));
          }
        },
      ),
    );
  }
}