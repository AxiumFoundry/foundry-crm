import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    speed: { type: Number, default: 0.3 }
  }

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.ticking = false
    this.enabled = false
    this.boundOnScroll = () => this.onScroll()
    this.boundOnResize = () => this.checkViewport()

    this.checkViewport()
    window.addEventListener("resize", this.boundOnResize)
  }

  disconnect() {
    if (this.boundOnScroll) {
      window.removeEventListener("scroll", this.boundOnScroll)
    }
    if (this.boundOnResize) {
      window.removeEventListener("resize", this.boundOnResize)
    }
  }

  checkViewport() {
    const isDesktop = window.innerWidth >= 768 && !("ontouchstart" in window)

    if (isDesktop && !this.enabled) {
      this.enabled = true
      this.element.classList.add("parallax-element")
      window.addEventListener("scroll", this.boundOnScroll, { passive: true })
      this.update()
    } else if (!isDesktop && this.enabled) {
      this.enabled = false
      this.element.classList.remove("parallax-element")
      this.element.style.transform = ""
      window.removeEventListener("scroll", this.boundOnScroll)
    }
  }

  onScroll() {
    if (!this.ticking) {
      requestAnimationFrame(() => {
        this.update()
        this.ticking = false
      })
      this.ticking = true
    }
  }

  update() {
    const rect = this.element.getBoundingClientRect()
    const viewportHeight = window.innerHeight
    const elementCenter = rect.top + rect.height / 2
    const viewportCenter = viewportHeight / 2
    const offset = (elementCenter - viewportCenter) * this.speedValue

    this.element.style.transform = `translateY(${offset}px)`
  }
}
