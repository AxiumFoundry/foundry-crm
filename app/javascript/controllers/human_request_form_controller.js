import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["chatForm", "form"]

  show() {
    this.chatFormTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
  }

  hide() {
    this.formTarget.classList.add("hidden")
    this.chatFormTarget.classList.remove("hidden")
  }
}
