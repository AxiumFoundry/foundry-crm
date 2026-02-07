import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["window", "toggle", "messages", "input"]

  connect() {
    this.setupMessageObserver()
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  toggleWidget() {
    if (this.isOpen()) {
      this.closeWidget()
    } else {
      this.openWidget()
    }
  }

  openWidget() {
    this.windowTarget.classList.remove("scale-0", "opacity-0", "pointer-events-none")
    this.windowTarget.classList.add("scale-100", "opacity-100")
    this.scrollToBottom()
    if (this.hasInputTarget) this.inputTarget.focus()
  }

  closeWidget() {
    this.windowTarget.classList.add("scale-0", "opacity-0", "pointer-events-none")
    this.windowTarget.classList.remove("scale-100", "opacity-100")
  }

  isOpen() {
    return this.windowTarget.classList.contains("scale-100")
  }

  submitMessage(event) {
    if (!this.hasInputTarget) return

    const content = this.inputTarget.value.trim()
    if (!content) {
      event.preventDefault()
      return
    }

    this.inputTarget.readOnly = true
  }

  scrollToBottom() {
    if (this.hasMessagesTarget) {
      requestAnimationFrame(() => {
        this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
      })
    }
  }

  setupMessageObserver() {
    const messagesContainer = document.getElementById("messages")
    if (!messagesContainer) return

    this.observer = new MutationObserver(() => {
      this.scrollToBottom()
    })

    this.observer.observe(messagesContainer, { childList: true, subtree: true })
  }
}
