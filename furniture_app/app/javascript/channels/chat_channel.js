import consumer from "channels/consumer"

document.addEventListener('DOMContentLoaded', function() {
  const chatMessages = document.getElementById('chat-messages');
  const manufacturerId = chatMessages.dataset.manufacturerId;
  const userId = chatMessages.dataset.userId;
  const userType = chatMessages.dataset.userType; // Определение типа отправителя
  console.log(manufacturerId);
  console.log(userId);
  console.log(userType); // Проверяем, получили ли тип отправителя

  consumer.subscriptions.create({ channel: "ChatChannel", manufacturer_id: manufacturerId, user_id: userId, user_type: userType }, {
    connected() {
      console.log("Connected to chat channel");
    },

    disconnected() {
    },

    received(data) {
      const chatMessages = document.getElementById('chat-messages');
      console.log("Sending message:", chatMessages);
      chatMessages.insertAdjacentHTML('beforeend', `<div class="message"><strong>${data.username}:</strong> ${data.message}</div>`);
    },

    send_message(message) {
      console.log("Manufacturer:", manufacturerId);
      console.log("User:", userId);
      console.log("User Type:", userType); // Добавили вывод типа отправителя
      console.log("Sending message:", message);
      const senderId = userType === 'Производитель' ? manufacturerId : userId;
      this.perform('receive', { message: message, sender_id: senderId, sender_type: String(userType) }); // Передаем тип отправителя вместе с сообщением
    }
  });
});

document.addEventListener('DOMContentLoaded', function() {
  const messageForm = document.getElementById('message-form');
  const messageInput = document.getElementById('message-input');

  messageForm.addEventListener('submit', function(event) {
    event.preventDefault();
    const message = messageInput.value;
    if (message.trim() !== '') {
      consumer.subscriptions.subscriptions[0].send_message(message);
      messageInput.value = '';
    }
  });
});