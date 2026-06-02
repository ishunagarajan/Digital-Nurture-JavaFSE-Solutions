let events = [];

events.push("Music Event");

events.push("Workshop");

let musicEvents = events.filter(event =>
    event.includes("Music")
);

musicEvents.forEach(event => {

    document.body.innerHTML += `
    <p>${event}</p>
    `;
});

let cards = events.map(event =>
    `Workshop on ${event}`
);

cards.forEach(card => {

    document.body.innerHTML += `
    <p>${card}</p>
    `;
});