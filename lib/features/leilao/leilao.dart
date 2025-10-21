import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

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
      numero: json['numero'] ?? '',
      imagemCard: json['imagemCard'] ?? '',
      imagemBanner: json['imagemBanner'] ?? '',
      data: json['data'] ?? '',
      horario: json['horario'] ?? '',
      canal: json['canal'] ?? '',
    );
  }
}

Future<List<Leilao>> loadAllLeiloes() async {
  try {
    final jsonString = await rootBundle.loadString('assets/images/leiloes.json');
    final jsonMap = json.decode(jsonString);

    if (jsonMap != null && jsonMap['leiloes'] is List) {
      final List<dynamic> leiloesJson = jsonMap['leiloes'];
      return leiloesJson.map((json) => Leilao.fromJson(json)).toList();
    } else {
      print('JSON não contém lista válida de leilões.');
      return [];
    }
  } catch (e) {
    print('Erro ao carregar leilões: $e');
    return [];
  }
}
