import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { key: String, model: String, recordId: Number, field: String }

  connect() {
    this.originalText = this.element.textContent
    this.handleDeactivate = () => this.cancel()
    document.addEventListener("edit-mode:deactivate", this.handleDeactivate)
  }

  disconnect() {
    document.removeEventListener("edit-mode:deactivate", this.handleDeactivate)
  }

  edit(event) {
    if (!document.body.classList.contains("editing")) return
    event.preventDefault()
    event.stopPropagation()

    if (this.element.classList.contains("editable-text--active")) return

    this.originalText = this.element.textContent
    this.element.classList.add("editable-text--active")

    const isMultiline = this.originalText.includes("\n") || this.originalText.length > 80

    const input = isMultiline
      ? document.createElement("textarea")
      : document.createElement("input")

    input.value = this.originalText
    input.className = isMultiline ? "inline-edit-textarea" : "inline-edit-input"

    if (isMultiline) {
      input.rows = Math.max(2, this.originalText.split("\n").length)
    }

    input.addEventListener("keydown", (e) => {
      if (e.key === "Escape") {
        this.cancel()
      } else if (e.key === "Enter" && !isMultiline) {
        e.preventDefault()
        this.save(input.value)
      }
    })

    const actions = document.createElement("div")
    actions.className = "inline-edit-actions"

    const saveBtn = document.createElement("button")
    saveBtn.textContent = "Save"
    saveBtn.className = "inline-edit-save"
    saveBtn.type = "button"
    saveBtn.addEventListener("click", (e) => {
      e.preventDefault()
      e.stopPropagation()
      this.save(input.value)
    })

    const cancelBtn = document.createElement("button")
    cancelBtn.textContent = "Cancel"
    cancelBtn.className = "inline-edit-cancel"
    cancelBtn.type = "button"
    cancelBtn.addEventListener("click", (e) => {
      e.preventDefault()
      e.stopPropagation()
      this.cancel()
    })

    if (this.hasKeyValue) {
      const resetBtn = document.createElement("button")
      resetBtn.textContent = "Reset"
      resetBtn.className = "inline-edit-reset"
      resetBtn.type = "button"
      resetBtn.addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()
        this.reset()
      })
      actions.appendChild(resetBtn)
    }

    actions.appendChild(saveBtn)
    actions.appendChild(cancelBtn)

    this.element.textContent = ""
    this.element.appendChild(input)
    this.element.appendChild(actions)
    input.focus()
    input.select()
  }

  async save(newValue) {
    if (newValue === this.originalText) {
      this.cancel()
      return
    }

    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
    const headers = { "Content-Type": "application/json", "X-CSRF-Token": csrfToken }

    try {
      let response

      if (this.hasKeyValue) {
        response = await fetch("/admin/content_update", {
          method: "PATCH",
          headers,
          body: JSON.stringify({ key: this.keyValue, value: newValue })
        })
      } else {
        response = await fetch("/admin/inline_update", {
          method: "PATCH",
          headers,
          body: JSON.stringify({
            model: this.modelValue,
            id: this.recordIdValue,
            field: this.fieldValue,
            value: newValue
          })
        })
      }

      if (!response.ok) throw new Error("Save failed")

      this.originalText = newValue
      this.restoreText(newValue)
      this.flash("editable-text--saved")
    } catch {
      this.restoreText(this.originalText)
      this.flash("editable-text--error")
    }
  }

  async reset() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content

    try {
      const response = await fetch("/admin/content_update", {
        method: "PATCH",
        headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken },
        body: JSON.stringify({ key: this.keyValue, reset: true })
      })

      if (!response.ok) throw new Error("Reset failed")

      const { value } = await response.json()
      this.originalText = value
      this.restoreText(value)
      this.flash("editable-text--saved")
    } catch {
      this.restoreText(this.originalText)
      this.flash("editable-text--error")
    }
  }

  cancel() {
    this.restoreText(this.originalText)
  }

  restoreText(text) {
    this.element.textContent = text
    this.element.classList.remove("editable-text--active")
  }

  flash(className) {
    this.element.classList.add(className)
    setTimeout(() => this.element.classList.remove(className), 1500)
  }
}
