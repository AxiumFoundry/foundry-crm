import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  static values = {
    threshold: { type: Number, default: 0.15 },
    stagger: { type: Number, default: 100 },
    root: { type: Boolean, default: false }
  }

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      this.revealAll()
      return
    }

    this.observer = new IntersectionObserver(
      (entries) => this.handleIntersection(entries),
      { threshold: this.thresholdValue }
    )

    if (this.rootValue) {
      this.observer.observe(this.element)
    } else {
      this.itemTargets.forEach((item) => this.observer.observe(item))
    }
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
  }

  handleIntersection(entries) {
    entries.forEach((entry) => {
      if (!entry.isIntersecting) return

      if (this.rootValue) {
        this.reveal(entry.target)
        this.observer.unobserve(entry.target)
      } else {
        this.revealStaggered()
        this.itemTargets.forEach((item) => this.observer.unobserve(item))
      }
    })
  }

  revealStaggered() {
    this.itemTargets.forEach((item, index) => {
      setTimeout(() => this.reveal(item), index * this.staggerValue)
    })
  }

  reveal(element) {
    element.classList.remove("reveal-hidden")
    element.classList.add("reveal-visible")
  }

  revealAll() {
    if (this.rootValue) {
      this.reveal(this.element)
    } else {
      this.itemTargets.forEach((item) => this.reveal(item))
    }
  }
}
