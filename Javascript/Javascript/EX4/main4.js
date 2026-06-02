function addEvent(name) {

    document.body.innerHTML += `
    <p>${name} Added</p>
    `;
}

function registerUser(user) {

    document.body.innerHTML += `
    <p>${user} Registered</p>
    `;
}

addEvent("Music Event");

registerUser("John");

function counter() {

    let count = 0;

    return function () {

        count++;

        document.body.innerHTML += `
        <p>Total Registrations: ${count}</p>
        `;
    };
}

const track = counter();

track();

track();