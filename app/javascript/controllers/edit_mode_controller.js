import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    if (sessionStorage.getItem("editMode") === "true") {
      this.activate()
    }
  }

  toggle() {
    if (document.body.classList.contains("editing")) {
      this.deactivate()
    } else {
      this.activate()
    }
  }

  activate() {
    document.body.classList.add("editing")
    sessionStorage.setItem("editMode", "true")
    this.buttonTarget.textContent = "Stop Editing"
  }

  deactivate() {
    document.dispatchEvent(new CustomEvent("edit-mode:deactivate"))
    document.body.classList.remove("editing")
    sessionStorage.setItem("editMode", "false")
    this.buttonTarget.textContent = "Edit Content"
  }
}
