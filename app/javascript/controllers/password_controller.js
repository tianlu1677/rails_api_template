import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['input', 'toggle']

  toggle() {
    const showing = this.inputTarget.type === 'text'
    this.inputTarget.type = showing ? 'password' : 'text'
    this.toggleTarget.textContent = showing ? 'Show' : 'Hide'
    this.toggleTarget.setAttribute('aria-pressed', String(!showing))
  }
}
