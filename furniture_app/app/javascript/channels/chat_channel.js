import consumer from "channels/consumer"

document.addEventListener("turbo:load", function() {
  const chatMessages = document.getElementById("chat-messages");
  const manufacturerId = chatMessages.dataset.manufacturerId;
  const userId = chatMessages.dataset.userId;
  const userType = chatMessages.dataset.userType;

  consumer.subscriptions.create({ channel: "ChatChannel", manufacturer_id: manufacturerId, user_id: userId, user_type: userType }, {
    connected() {
      console.log("Connected to chat channel");
    },

    disconnected() {
    },

    received(data) {
      const chatMessages = document.getElementById("chat-messages");
      chatMessages.insertAdjacentHTML("beforeend", `<div class="message"><strong>${data.username}:</strong> ${data.message}</div>`);
    },

    send_message(message) {
      const senderId = userType === "Виробник" ? manufacturerId : userId;
      this.perform("receive", { message: message, sender_id: senderId, sender_type: String(userType) });
    }
  });
});

document.addEventListener("turbo:load", function() {
  const messageForm = document.getElementById("message-form");
  const messageInput = document.getElementById("message-input");

  messageForm.addEventListener("submit", function(event) {
    event.preventDefault();
    const message = messageInput.value;
    if (message.trim() !== "") {
      consumer.subscriptions.subscriptions[0].send_message(message);
      messageInput.value = "";
    }
  });
});