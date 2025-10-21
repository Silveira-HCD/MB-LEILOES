import 'package:flutter/material.dart';
import 'leilao.dart';

class LeilaoDetalhePage extends StatelessWidget {
  const LeilaoDetalhePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Leilao leilao = ModalRoute.of(context)!.settings.arguments as Leilao;

    return Scaffold(
      appBar: AppBar(
        title: Text(leilao.numero),
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

          //  Gradiente leve para contraste
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.transparent,
                    Colors.black.withOpacity(0.35),
                  ],
                ),
              ),
            ),
          ),

          // 🔹 Conteúdo principal
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Imagem principal do leilão
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/${leilao.imagemBanner}',
                        fit: BoxFit.cover,
                        height: 180,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Título
                    Text(
                      leilao.numero,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black54,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Informações
                    _infoLine(Icons.calendar_today, 'Data: ${leilao.data}'),
                    _infoLine(Icons.access_time, 'Horário: ${leilao.horario}'),
                    _infoLine(Icons.tv, 'Canal: ${leilao.canal}'),

                    const SizedBox(height: 24),

                    // 🔴 Botão AO VIVO
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/aoVivo');
                      },
                      icon: const Icon(Icons.videocam),
                      label: const Text('ASSISTIR AO VIVO'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 🟡 Botão VER LOTES
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/lotes',
                          arguments: leilao,
                        );
                      },
                      icon: const Icon(Icons.list),
                      label: const Text('VER LOTES'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[700],
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Divider(color: Colors.white70),
                    const SizedBox(height: 12),

                    const Text(
                      'Acompanhe os lotes e vídeos deste leilão diretamente pelo aplicativo. '
                          'Cada lote conta com seu vídeo individual para melhor visualização.',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.4,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black54,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoLine(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
