import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "form"]

  show() {
    this.toggleTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
  }

  hide() {
    this.formTarget.classList.add("hidden")
    this.toggleTarget.classList.remove("hidden")
  }
}
