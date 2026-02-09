import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close(event) {
    // Only close if clicking the backdrop or close button
    if (event.target === event.currentTarget || event.target.closest('[data-modal-close]')) {
      event.preventDefault()
      this.element.remove()
    }
  }

  stopPropagation(event) {
    event.stopPropagation()
  }
}
