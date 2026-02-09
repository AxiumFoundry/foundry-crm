import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.clickCount = 0
    this.resetTimer = null
  }

  disconnect() {
    if (this.resetTimer) {
      clearTimeout(this.resetTimer)
    }
  }

  handleClick() {
    this.clickCount++

    if (this.clickCount >= 3) {
      this.clickCount = 0
      clearTimeout(this.resetTimer)
      window.Turbo.visit("/login")
      return
    }

    clearTimeout(this.resetTimer)
    this.resetTimer = setTimeout(() => {
      this.clickCount = 0
    }, 600)
  }
}
