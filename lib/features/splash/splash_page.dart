import 'package:flutter/material.dart';
import 'package:projeto_mb_teste/features/leilao/leilao.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLeilaoStatus();
  }

  void _checkLeilaoStatus() async {
    final liveLeilao = await getLiveLeilao();
    Future.delayed(const Duration(seconds: 3), () {
      if (liveLeilao != null) {
        Navigator.pushReplacementNamed(context, '/aoVivo');
      } else {
        Navigator.pushReplacementNamed(context, '/home'); // Vai para a Home
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 180,
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}