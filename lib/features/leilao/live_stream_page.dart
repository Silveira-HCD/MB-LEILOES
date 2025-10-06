import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({super.key});

  @override
  State<LiveStreamPage> createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  bool _isPlayerLoaded = false;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://equipea.com.br/player/?canal=canaldoboi'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leilão ao Vivo'),
      ),
      body: _isPlayerLoaded
          ? WebViewWidget(controller: controller)
          : GestureDetector(
        onTap: () {
          setState(() {
            _isPlayerLoaded = true;
          });
        },
        child: Container(
          color: Colors.black,
          child: const Center(
            child: Icon(
              Icons.play_circle_filled,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }
}