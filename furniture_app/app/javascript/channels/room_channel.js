import consumer from "./consumer";

let subscription;

document.addEventListener("turbo:load", function () {
    const roomMessages = document.getElementById("room-messages");
    const roomMessage = document.getElementById("room-message");
    const roomId = roomMessages.dataset.roomId;
    const userId = roomMessages.dataset.userId;

    function scrollToBottom() {
        const lastMessage = roomMessage.lastElementChild;
        if (lastMessage) {
            lastMessage.scrollIntoView({ behavior: 'smooth' });
        }
    }

    function subscribeToChatChannel() {
        if (subscription) {
            subscription.unsubscribe();
        }
        subscription = consumer.subscriptions.create({ channel: "RoomChannel", room_id: roomId }, {
            connected() {
                console.log("Connected to chat channel");
            },
            received(data) {
                const messagesContainer = document.querySelector("#room-message");
                messagesContainer.insertAdjacentHTML("beforeend", `<div class="message"><strong>${data.username}:</strong> ${data.message}</div>`);
                scrollToBottom();
            },
            send_message(message) {
                this.perform("receive", { message: message, sender_id: userId });
            }
        });
    }

    subscribeToChatChannel();
});

document.addEventListener("turbo:load", function () {
    const roomMessageForm = document.getElementById("room-message-form");
    const roomMessageInput = document.getElementById("room-message-input");
    const roomMessage = document.getElementById("room-message");
    const roomMessages = document.getElementById("room-messages");
    const roomId = roomMessages.dataset.roomId;

    function scrollToBottom() {
        const lastMessage = roomMessage.lastElementChild;
        if (lastMessage) {
            lastMessage.scrollIntoView({ behavior: 'smooth' });
        }
    }

    roomMessageForm.addEventListener("submit", function (event) {
        event.preventDefault();
        const roomMessageContent = roomMessageInput.value.trim();
        console.log(roomMessageContent);
        if (roomMessageContent !== "") {
            fetch(`/rooms/${roomId}/room_messages`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
                },
                body: JSON.stringify({
                    message: {
                        body: roomMessageContent,
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
                    consumer.subscriptions.subscriptions[0].send_message(data.message.body);
                    roomMessageInput.value = "";
                    setTimeout(scrollToBottom, 100);
                })
                .catch(error => console.error("Error:", error));
        }
    });

    scrollToBottom();

    window.addEventListener("beforeunload", function () {
        if (subscription) {
            subscription.unsubscribe();
        }
    });
});
