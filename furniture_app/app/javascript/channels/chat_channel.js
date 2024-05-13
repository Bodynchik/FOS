import consumer from "channels/consumer"

document.addEventListener("turbo:load", function () {
  const chatMessages = document.getElementById("chat-messages");
  let subscription;

  function subscribeToChatChannel() {
    const manufacturerId = chatMessages.dataset.manufacturerId;
    const userId = chatMessages.dataset.userId;
    const userType = chatMessages.dataset.userType;
    const chatId = chatMessages.dataset.chatId;

    if (subscription) {
      subscription.unsubscribe();
    }

    subscription = consumer.subscriptions.create({
      channel: "ChatChannel",
      manufacturer_id: manufacturerId,
      user_id: userId,
      user_type: userType,
      chat_id: chatId
    }, {
      connected() {
        console.log("Connected to chat channel");
      },

      disconnected() {
        console.log("Disconnected from chat channel");
      },

      received(data) {
        const chatMessages = document.getElementById("chat-messages");
        chatMessages.insertAdjacentHTML("beforeend", `<div class="message"><strong>${data.username}:</strong> ${data.message}</div>`);
      },

      send_message(message) {
        const senderId = userType === "Виробник" ? manufacturerId : userId;
        this.perform("receive", {message: message, sender_id: senderId, sender_type: String(userType)});
      }

    });
  }

  subscribeToChatChannel();

  const logoutButtons = document.querySelectorAll("#link-logo, #logout-prof-user, #logout-but-user, #logout-prof-mun, #logout-but-mun");
  logoutButtons.forEach(logoutButton => {
    logoutButton.addEventListener("click", function () {
      if (subscription) {
        subscription.unsubscribe();
      }
    });
  });
});

document.addEventListener("turbo:load", function () {
  const messageForm = document.getElementById("message-form");
  const messageInput = document.getElementById("message-input");
  const chatMessages = document.getElementById("chat-messages");
  const userType = chatMessages.dataset.userType;
  const chatId = chatMessages.dataset.chatId;

  messageForm.addEventListener("submit", function (event) {
    event.preventDefault();
    const messageContent = messageInput.value.trim();
    if (messageContent !== "") {
      fetch(`/chats/${chatId}/messages`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        },
        body: JSON.stringify({
          message: {
            content: messageContent,
            user_type: userType,
          }
        })
      })
          .then(response => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response.json();
          })
          .then(data => {
            consumer.subscriptions.subscriptions[0].send_message(data.message.content);
            messageInput.value = "";
          })
          .catch(error => console.error("Error:", error));
    }
  });
});