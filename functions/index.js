const { onDocumentUpdated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getMessaging } = require("firebase-admin/messaging");

initializeApp();

exports.notificarLeilaoAoVivo = onDocumentUpdated("leiloes/{leilaoId}", async (event) => {
  const antes = event.data.before.data();
  const depois = event.data.after.data();

  
  if (!antes.aoVivo && depois.aoVivo) {
    console.log("🔥 Leilão entrou AO VIVO!");

    const titulo = depois.titulo ?? "Leilão ao vivo!";
    const frase = depois.frase1 ?? "O leilão começou!";

    await getMessaging().send({
      topic: "todos",
      notification: {
        title: `🚨 AO VIVO: ${titulo}`,
        body: frase,
      },
    });

    console.log("✅ Notificação enviada ao tópico TODOS");
  } else {
    console.log("⏳ Alteração ignorada — não é false → true.");
  }
});
