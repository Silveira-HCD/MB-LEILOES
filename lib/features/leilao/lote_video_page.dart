import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LoteVideoPage extends StatefulWidget {
  final String videoUrl;

  const LoteVideoPage({super.key, required this.videoUrl});

  @override
  State<LoteVideoPage> createState() => _LoteVideoPageState();
}

class _LoteVideoPageState extends State<LoteVideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reprodução do Lote')),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Column(
            children: [
              player,
              const SizedBox(height: 20),
              const Text(
                'Reprodução do vídeo do lote selecionado',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          );
        },
      ),
    );
  }
}
