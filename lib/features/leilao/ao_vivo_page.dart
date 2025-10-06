import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AoVivoPage extends StatefulWidget {
  const AoVivoPage({super.key});

  @override
  State<AoVivoPage> createState() => _AoVivoPageState();
}

class _AoVivoPageState extends State<AoVivoPage> {
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
      body: WebViewWidget(controller: controller),
    );
  }
}