import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_mb_teste/features/leilao/leilao.dart';
import 'package:projeto_mb_teste/features/leilao/lotes_page.dart';
import 'package:projeto_mb_teste/features/leilao/live_stream_page.dart';

class LeilaoDetalhePage extends StatefulWidget {
  final Leilao leilao;

  const LeilaoDetalhePage({super.key, required this.leilao});

  @override
  State<LeilaoDetalhePage> createState() => _LeilaoDetalhePageState();
}

class _LeilaoDetalhePageState extends State<LeilaoDetalhePage> {
  String _horario = '';
  String _canal = '';
  late final String _bannerToShow;

  @override
  void initState() {
    super.initState();


    _bannerToShow = widget.leilao.imagemBanner.isNotEmpty
        ? widget.leilao.imagemBanner
        : widget.leilao.bannerUrl;


    _horario = widget.leilao.horario;
    _canal = widget.leilao.canal;



    if (_horario.isEmpty || _canal.isEmpty) {
      _carregarInfoDaAgendaPeloTitulo(widget.leilao.titulo);
    }
  }

  Future<void> _carregarInfoDaAgendaPeloTitulo(String titulo) async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('agenda_leiloes')
          .where('titulo', isEqualTo: titulo)
          .limit(1)
          .get();

      if (snap.docs.isNotEmpty) {
        final data = snap.docs.first.data();
        setState(() {
          if (_horario.isEmpty) {
            _horario = (data['horario'] ?? '').toString();
          }
          if (_canal.isEmpty) {
            _canal = (data['canal'] ?? '').toString();
          }
        });
      }
    } catch (_) {

    }
  }

  String _formatarData(String dataOriginal) {

    if (dataOriginal.contains('/')) return dataOriginal;

    try {
      final p = dataOriginal.split('-');
      if (p.length == 3) return '${p[2]}/${p[1]}/${p[0]}';
    } catch (_) {}
    return dataOriginal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.leilao.titulo),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo_bois.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _bannerToShow,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),


                Text(
                  widget.leilao.titulo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: Colors.white70),
                    const SizedBox(width: 6),
                    Text(
                      _formatarData(widget.leilao.data),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    if (_horario.isNotEmpty) ...[
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time, size: 18, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(_horario, style: const TextStyle(color: Colors.white70)),
                    ],
                  ],
                ),
                const SizedBox(height: 8),


                if (_canal.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.live_tv, size: 18, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(_canal, style: const TextStyle(color: Colors.white70)),
                    ],
                  ),

                const SizedBox(height: 20),


                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LotesPage(leilao: widget.leilao)),
                    );
                  },
                  icon: const Icon(Icons.list),
                  label: const Text('VER LOTES'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 20),


                const Text(
                  'Acompanhe os lotes e vídeos deste leilão diretamente pelo aplicativo. '
                      'Cada lote conta com seu vídeo individual para melhor visualização.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 20),


                if (widget.leilao.aoVivo && widget.leilao.aoVivoUrl.isNotEmpty)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LiveStreamPage(canalUrl: widget.leilao.aoVivoUrl),
                        ),
                      );
                    },
                    icon: const Icon(Icons.videocam),
                    label: const Text('ASSISTIR AO VIVO'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),


                const SizedBox(height: 287),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
