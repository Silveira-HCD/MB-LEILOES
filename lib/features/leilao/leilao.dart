import 'package:cloud_firestore/cloud_firestore.dart';

class Leilao {
  final String id;
  final String titulo;
  final String data;
  final String horario;
  final String canal;
  final String imagemCard;
  final String imagemBanner;
  final String bannerUrl;
  final String frase1;
  final String frase2;
  final bool aoVivo;
  final String aoVivoUrl;

  Leilao({
    required this.id,
    required this.titulo,
    required this.data,
    required this.horario,
    required this.canal,
    this.imagemCard = '',
    this.imagemBanner = '',
    this.bannerUrl = '',
    this.frase1 = '',
    this.frase2 = '',
    this.aoVivo = false,
    this.aoVivoUrl = '',
  });

  factory Leilao.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Leilao(
      id: doc.id,
      titulo: data['titulo'] ?? 'Leilão sem título',
      data: data['data'] ?? '',
      horario: data['horario'] ?? '',
      canal: data['canal'] ?? '',
      imagemCard: data['imagemCard'] ?? '',
      imagemBanner: data['imagemBanner'] ?? '',
      bannerUrl: data['bannerUrl'] ?? data['imagemBanner'] ?? '',
      frase1: data['frase1'] ?? '',
      frase2: data['frase2'] ?? '',
      aoVivo: data['aoVivo'] ?? false,
      aoVivoUrl: data['aoVivoUrl'] ?? '',
    );
  }
}
