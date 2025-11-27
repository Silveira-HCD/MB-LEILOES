# 🐂 MB Leilões — Aplicativo Mobile

Aplicativo oficial da **MB Leilões**, desenvolvido em **Flutter** e atualmente utilizado em produção para divulgação de leilões de gado, lotes e transmissões ao vivo, com gerenciamento remoto via Firebase.

Projeto focado em **autonomia operacional**, permitindo atualizar conteúdos e transmissões **sem necessidade de publicar nova versão do app**.

---

## 🧑‍💻 Autor do Projeto

**Carlos Henrique Costa da Silveira**  
Desenvolvedor Flutter  

📧 E-mail: silveira.hcd@gmail.com  
🔗 GitHub: https://github.com/Silveira-HCD  

> Responsável pelo desenvolvimento completo do aplicativo (frontend, integração com Firebase, arquitetura e deploy).

---

## 📱 Funcionalidades Implementadas

- ✅ Splash Screen personalizada
- ✅ Menu lateral (Drawer)
- ✅ Página inicial com **banner dinâmico** do leilão atual
- ✅ Agenda de Leilões integrada ao **Firebase Firestore**
- ✅ Página de Lotes com:
- ✅ ordenação personalizada
- ✅ ativação/desativação (on/off) diretamente pelo Firestore
- ✅vídeos individuais via YouTube
- ✅ Controle remoto do botão **“AO VIVO”**
- ✅ Transmissão ao vivo via WebView
- ✅ Tela de Fale Conosco com acesso direto ao WhatsApp
- ✅ Layout responsivo e otimizado para Android

---

## 🔥 Diferenciais Técnicos

- Atualização de dados **em tempo real**
- Nenhuma dependência de nova build para:
  - ativar/desativar leilões
  - controlar exibição de lotes
  - iniciar ou encerrar transmissões ao vivo
- Arquitetura preparada para múltiplos eventos e equipes
- Aplicação distribuída pela **Google Play Store (teste fechado)**

---

## 🧩 Stack Tecnológica

- **Flutter (Dart)** — mobile multiplataforma  
- **Firebase Firestore** — banco de dados em tempo real  
- **Firebase Analytics** — métricas de uso  
- **Firebase Cloud Messaging** — notificações push  
- **YouTube Embed** — vídeos dos lotes  
- **Git & GitHub** — versionamento  
- **Google Play Console** — distribuição Android  

---

## 🧠 Estrutura do Projeto

```text
lib/
├── features/
│   ├── home/
│   ├── leilao/
│   │   ├── agenda_leilao_page.dart
│   │   ├── lotes_page.dart
│   │   ├── live_stream_page.dart
│   └── fale_conosco/
├── models/
├── services/
└── main.dart
