import consumer from "channels/consumer"

document.addEventListener('DOMContentLoaded', function() {
  const chatMessages = document.getElementById('chat-messages');
  const userId = chatMessages.dataset.userId;

  consumer.subscriptions.create({ channel: "ChatChannel", user_id: userId }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("Connected to chat channel");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      const chatMessages = document.getElementById('chat-messages');
      console.log("Sending message:", chatMessages);
      chatMessages.insertAdjacentHTML('beforeend', `<div class="message"><strong>${data.username}:</strong> ${data.message}</div>`);
    },

    send_message(message) {
      console.log("User:", userId);
      console.log("Sending message:", message);
      this.perform('receive', { message: message });
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