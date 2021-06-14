import { Controller } from 'stimulus'; 

export default class extends Controller {
    unfollow(e) {
        const self = this;
        const url = e.currentTarget.dataset.friendshipPath;
        fetch(url, { method: 'delete' })
            .then((r) => r.text())
            .then((text) => self.context.element.innerHTML = text);
    }

    follow(e) {
        const self = this;
        const { friendshipsPath, memberId, friendId }= e.currentTarget.dataset;
        const options = {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ friendship: { member_id: memberId, friend_id: friendId } })
        };

        fetch(friendshipsPath, options)
            .then((r) => r.text())
            .then((text) => self.context.element.innerHTML = text);
    }
}
