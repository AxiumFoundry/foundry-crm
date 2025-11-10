import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit"]

  connect() {
    if (this.hasSubmitTarget) {
      this.validateForm()
    }
  }

  validateForm() {
    const form = this.element

    form.addEventListener("input", () => {
      if (form.checkValidity()) {
        this.submitTarget.disabled = false
        this.submitTarget.classList.remove("opacity-50", "cursor-not-allowed")
      } else {
        this.submitTarget.disabled = false // Allow HTML5 validation to show
      }
    })
  }
}
