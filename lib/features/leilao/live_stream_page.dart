import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveStreamPage extends StatefulWidget {
  final String? canalUrl;

  const LiveStreamPage({super.key, this.canalUrl});

  @override
  State<LiveStreamPage> createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // URL fallback
    final url = widget.canalUrl?.isNotEmpty == true
        ? widget.canalUrl!
        : 'https://equipea.com.br/player/?canal=canaldoboi';

    // Força modo imersivo — some barra inferior durante o vídeo
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadRequest(Uri.parse(url));
  }

  @override
  void dispose() {
    // Retorna o modo normal da interface ao sair da página
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Leilão ao Vivo'),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: bottomInset + 12,
          ),
          child: WebViewWidget(controller: controller),
        ),
      ),
    );
  }
}
