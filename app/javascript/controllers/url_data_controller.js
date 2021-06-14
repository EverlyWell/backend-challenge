import { Controller } from 'stimulus'; 

export default class extends Controller {
    static targets = ['stateLabel'];
    static values = { url: String, state: String }

    connect() {
        const self = this;

        if(this.stateValue == 'processing_url') {
            this.load();
            this.timer = setInterval(() => {
                this.load()
            }, 1000);
        }

        console.log("connected url data controller")
    }

    disconnect() {
        this.stopTimer()
    }

    load() {
        const self = this;
        fetch(this.urlValue)
            .then((r) => r.json())
            .then((json) => {
                self.element.innerHTML = json.html
                if(json.state == 'success' || json.state == 'error_processing_url') {
                    this.stopTimer();
                }
            })
    }

    stopTimer() {
        if(this.timer) {
            clearInterval(this.timer)
        }
    }
}
