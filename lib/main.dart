import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';

import 'package:projeto_mb_teste/core/theme.dart';
import 'package:projeto_mb_teste/features/splash/splash_page.dart';
import 'package:projeto_mb_teste/features/login/login_page.dart';
import 'package:projeto_mb_teste/features/cadastro/cadastro_page.dart';
import 'package:projeto_mb_teste/features/leilao/agenda_leilao_page.dart';
import 'package:projeto_mb_teste/features/leilao/ao_vivo_page.dart';
import 'package:projeto_mb_teste/features/leilao/leilao_detalhe_page.dart';
import 'package:projeto_mb_teste/features/leilao/lotes_page.dart';
import 'package:projeto_mb_teste/features/leilao/lote_video_page.dart';
import 'package:projeto_mb_teste/features/fale_conosco/fale_conosco_page.dart';
import 'package:projeto_mb_teste/features/leilao/leilao.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('📩 Notificação recebida em background: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;


  await messaging.requestPermission();


  await messaging.subscribeToTopic("todos");
  print("✅ Inscrito no tópico: TODOS");


  final token = await messaging.getToken();
  print('🔥 TOKEN DO DISPOSITIVO: $token');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Notificação recebida em primeiro plano: ${message.notification?.title}');
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MB Leilões',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const CadastroPage(),
        '/agenda': (context) => const AgendaLeilaoPage(),
        '/aoVivo': (context) => const AoVivoPage(),
        '/home': (context) => const AgendaLeilaoPage(),
        '/faleConosco': (context) => FaleConoscoPage(),
        '/leilaoDetalhe': (context) {
          final leilao = ModalRoute.of(context)!.settings.arguments as Leilao;
          return LeilaoDetalhePage(leilao: leilao);
        },
        '/lotes': (context) {
          final leilao = ModalRoute.of(context)!.settings.arguments as Leilao;
          return LotesPage(leilao: leilao);
        },
        '/video': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return LoteVideoPage(
            videoUrl: args['videoUrl'],
            titulo: args['titulo'],
          );
        },
      },
    );
  }
}
