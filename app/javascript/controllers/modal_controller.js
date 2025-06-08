import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    // Add click outside listener
    document.addEventListener("click", this.handleClickOutside.bind(this))
  }

  disconnect() {
    // Remove click outside listener
    document.removeEventListener("click", this.handleClickOutside.bind(this))
  }

  open() {
    this.containerTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.containerTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
  }

  handleClickOutside(event) {
    if (this.containerTarget.classList.contains("hidden")) return
    
    const modalContent = this.containerTarget.querySelector("div > div > div")
    if (!modalContent.contains(event.target)) {
      this.close()
    }
  }
} 