import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value"]

  connect() {
    this.originalTexts = this.valueTargets.map((el) => el.textContent)

    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.valueTargets.forEach((el) => {
      const parsed = this.parse(el.textContent)
      el.textContent = parsed.prefix + "0" + parsed.suffix
    })

    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return
          this.animateAll()
          this.observer.disconnect()
        })
      },
      { threshold: 0.15 }
    )

    this.observer.observe(this.element)
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
    this.valueTargets.forEach((el, i) => {
      if (this.originalTexts && this.originalTexts[i]) {
        el.textContent = this.originalTexts[i]
      }
    })
  }

  parse(text) {
    text = text.trim()
    const match = text.match(/^([^0-9]*?)([\d.]+)(.*)$/)
    if (!match) return { prefix: "", number: 0, suffix: text, decimals: 0 }

    const numberStr = match[2]
    const decimals = numberStr.includes(".") ? numberStr.split(".")[1].length : 0

    return {
      prefix: match[1],
      number: parseFloat(numberStr),
      suffix: match[3],
      decimals
    }
  }

  animateAll() {
    const duration = 1500

    this.valueTargets.forEach((el, i) => {
      const parsed = this.parse(this.originalTexts[i])
      const start = performance.now()

      const step = (now) => {
        const elapsed = now - start
        const progress = Math.min(elapsed / duration, 1)
        const eased = 1 - Math.pow(1 - progress, 3)
        const current = parsed.number * eased

        el.textContent = parsed.prefix + current.toFixed(parsed.decimals) + parsed.suffix

        if (progress < 1) {
          requestAnimationFrame(step)
        } else {
          el.textContent = this.originalTexts[i]
        }
      }

      requestAnimationFrame(step)
    })
  }
}
