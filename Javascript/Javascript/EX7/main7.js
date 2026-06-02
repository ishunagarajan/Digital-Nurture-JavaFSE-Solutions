const card = document.createElement("div");

card.innerHTML = `
<h2>Workshop Event</h2>

<p>Registration Open</p>
`;

document.body.appendChild(card);

function register() {

    card.innerHTML += `
    <p>Registered Successfully</p>
    `;
}

register();