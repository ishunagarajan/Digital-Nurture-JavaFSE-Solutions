const eventName = "Workshop";

function showEvent(name = "Music Show") {

    document.body.innerHTML += `
    <p>${name}</p>
    `;
}

showEvent();

const eventObj = {

    title: "Seminar",

    seats: 20
};

const { title, seats } = eventObj;

document.body.innerHTML += `
<p>${title}</p>

<p>${seats}</p>
`;

const events = ["Music", "Sports"];

const copiedEvents = [...events];

document.body.innerHTML += `
<p>${copiedEvents}</p>
`;