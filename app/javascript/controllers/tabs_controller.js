import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "panel"]
  static values = { index: { type: Number, default: 0 } }

  connect() {
    this.showTab(this.indexValue)
  }

  select(event) {
    const index = this.btnTargets.indexOf(event.currentTarget)
    this.showTab(index)
  }

  showTab(index) {
    this.btnTargets.forEach((btn, i) => {
      btn.classList.toggle("border-accent", i === index)
      btn.classList.toggle("text-white", i === index)
      btn.classList.toggle("border-transparent", i !== index)
      btn.classList.toggle("text-gray-400", i !== index)
    })

    this.panelTargets.forEach((panel, i) => {
      panel.classList.toggle("hidden", i !== index)
    })
  }
}
