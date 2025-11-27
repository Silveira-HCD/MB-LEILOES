import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contato {
  final String nome;
  final String cargo;
  final String telefone;

  Contato({required this.nome, required this.cargo, required this.telefone});
}

class FaleConoscoPage extends StatelessWidget {
  FaleConoscoPage({super.key});

  final List<Contato> contatos = [
    Contato(nome: "Murilo Barros", cargo: "Diretor", telefone: "5565999722622"),
    Contato(nome: "Jennifer Dalla Nora", cargo: "Comercial", telefone: "5565981430544"),
    Contato(nome: "Barbara Mendes", cargo: "Comercial", telefone: "5565981711994"),
    Contato(nome: "Daniele Cristina", cargo: "Financeiro", telefone: "5565996009644"),
    Contato(nome: "Adriana Malhado", cargo: "Financeiro / Embarque", telefone: "5565996921885"),
  ];

  Future<void> _abrirWhatsApp(String telefone, String nome) async {
    final mensagem = Uri.encodeComponent("Olá, gostaria de falar com $nome.");
    final Uri url = Uri.parse("https://wa.me/$telefone?text=$mensagem");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  IconData _defineIcone(String cargo) {
    final lower = cargo.toLowerCase();
    if (lower.contains("comercial")) return Icons.storefront;
    if (lower.contains("financeiro")) return Icons.attach_money;
    if (lower.contains("embarque")) return Icons.local_shipping;
    if (lower.contains("diretor")) return Icons.assignment_ind;
    return Icons.person;
  }

  Widget _buildContatoButton(Contato c) {
    return Card(
      color: Colors.white.withOpacity(0.92),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.orangeAccent,
          child: Icon(_defineIcone(c.cargo), color: Colors.white),
        ),
        title: Text(
          c.nome,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        subtitle: Text(
          c.cargo,
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: const Icon(Icons.message, color: Colors.green, size: 28),
        onTap: () => _abrirWhatsApp(c.telefone, c.nome),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fale Conosco"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/fundo_bois.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const Text(
                  "Entre em contato com nossa equipe:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 24),
                ...contatos.map(_buildContatoButton),
                const SizedBox(height: 32),
                Center(
                  child: TextButton(
                    onPressed: () => _abrirWhatsApp("5565981277267", "o Desenvolvedor Carlos"),
                    child: const Text(
                      "Falar com o Desenvolvedor",
                      style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
