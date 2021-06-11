import { Controller } from 'stimulus'; 

export default class extends Controller {

    static targets = ["topic", "results"]
    static values = { searchUrl: String }

    connect() {
        console.log("connected search controller")
    }

    search(e) {
        let self = this;
        e.preventDefault()
        fetch(`${this.searchUrlValue}?search[topic]=${this.topicTarget.value}`)
            .then((r) => r.text())
            .then((html) => self.resultsTarget.innerHTML = html);

    }
}
