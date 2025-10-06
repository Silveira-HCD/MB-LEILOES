import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class Leilao {
  final String numero;
  final String imagemCard;
  final String imagemBanner;
  final String data;
  final String horario;
  final String canal;

  Leilao({
    required this.numero,
    required this.imagemCard,
    required this.imagemBanner,
    required this.data,
    required this.horario,
    required this.canal,
  });

  factory Leilao.fromJson(Map<String, dynamic> json) {
    return Leilao(
      numero: json['numero'],
      imagemCard: json['imagemCard'],
      imagemBanner: json['imagemBanner'],
      data: json['data'],
      horario: json['horario'],
      canal: json['canal'],
    );
  }
}

Future<List<Leilao>> loadAllLeiloes() async {
  final jsonString = await rootBundle.loadString('assets/images/leiloes.json');
  final jsonMap = json.decode(jsonString);
  final List<dynamic> leiloesJson = jsonMap['leiloes'];

  return leiloesJson.map((json) => Leilao.fromJson(json)).toList();
}

// Esta é a nova função para verificar se há um leilão ao vivo
Future<Leilao?> getLiveLeilao() async {
  final now = DateTime.now();
  final allLeiloes = await loadAllLeiloes();

  if (allLeiloes.isEmpty) return null;

  final proximoLeilao = allLeiloes[0];
  final leilaoDateTimeCuiaba = DateFormat('dd/MM HH:mm').parse('${proximoLeilao.data} 09:00');

  final isLive = now.isAfter(leilaoDateTimeCuiaba.subtract(const Duration(minutes: 5))) && now.isBefore(leilaoDateTimeCuiaba.add(const Duration(hours: 1, minutes: 30)));

  return isLive ? proximoLeilao : null;
}