import 'package:flutter/material.dart';
import 'package:projeto_mb_teste/core/theme.dart';
import 'package:projeto_mb_teste/features/splash/splash_page.dart';
import 'package:projeto_mb_teste/features/login/login_page.dart';
import 'package:projeto_mb_teste/features/cadastro/cadastro_page.dart';
import 'package:projeto_mb_teste/features/leilao/agenda_page.dart';
import 'package:projeto_mb_teste/features/leilao/ao_vivo_page.dart';
import 'package:projeto_mb_teste/features/leilao/leilao_detalhe_page.dart';
import 'package:projeto_mb_teste/features/leilao/lotes_page.dart';
import 'package:projeto_mb_teste/features/leilao/lote_video_page.dart';
import 'package:projeto_mb_teste/features/home/home_page.dart';
import 'package:projeto_mb_teste/features/fale_conosco/fale_conosco_page.dart';
import 'package:projeto_mb_teste/features/leilao/leilao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MB Leilões',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const CadastroPage(),
        '/agenda': (context) => const AgendaPage(),
        '/aoVivo': (context) => const AoVivoPage(),
        '/home': (context) => const HomePage(),
        '/leilaoDetalhe': (context) => const LeilaoDetalhePage(),
        '/faleConosco': (context) => const FaleConoscoPage(),
        '/lotes': (context) {
          final leilao = ModalRoute.of(context)!.settings.arguments as Leilao;
          return LotesPage(leilao: leilao);
        },

        '/video': (context) {
          final videoUrl = ModalRoute.of(context)!.settings.arguments as String;
          return LoteVideoPage(videoUrl: videoUrl);
        },
      },
    );
  }
}
