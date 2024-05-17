import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room_messages"
export default class extends Controller {
  static targets = ["container", "input_form"];
  connect() {
    console.log(this.containerTarget);
    console.log("Last Message:", lastMessage);
    this.resetScroll();
    this.scrollToBottom();

    this.containerTarget.addEventListener("DOMNodeInserted", () => {
      this.resetScroll();
      this.scrollToBottom();
    });
  }

  resetScroll(){
    const scrollHeight = this.containerTarget.scrollHeight;
    this.containerTarget.scrollTo(0, scrollHeight);
  }

    scrollToBottom() {
        const lastMessage = this.containerTarget.lastElementChild;
        if (lastMessage) {
            lastMessage.scrollIntoView({ behavior: 'smooth' });
        }
    }
}