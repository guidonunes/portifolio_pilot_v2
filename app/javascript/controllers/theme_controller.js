import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["icon"]

  connect() {
    // Check for saved theme preference or default to light mode
    const savedTheme = localStorage.getItem("theme") || "light"
    // Set on document first
    document.documentElement.setAttribute("data-theme", savedTheme)
    // Then apply theme (which will update icon)
    this.applyTheme(savedTheme)
  }

  toggle() {
    const currentTheme = document.documentElement.getAttribute("data-theme")
    const newTheme = currentTheme === "dark" ? "light" : "dark"
    this.applyTheme(newTheme)
    localStorage.setItem("theme", newTheme)
  }

  applyTheme(theme) {
    document.documentElement.setAttribute("data-theme", theme)
    
    // Update icon if target exists
    if (this.hasIconTarget) {
      if (theme === "dark") {
        this.iconTarget.classList.remove("fa-moon")
        this.iconTarget.classList.add("fa-sun")
      } else {
        this.iconTarget.classList.remove("fa-sun")
        this.iconTarget.classList.add("fa-moon")
      }
    }
  }
}

