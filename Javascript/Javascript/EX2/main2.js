const eventName = "Music Show";

const eventDate = "20-06-2026";

let seats = 100;

document.body.innerHTML += `
<h2>Event: ${eventName}</h2>
<p>Date: ${eventDate}</p>
<p>Seats: ${seats}</p>
`;

seats--;

document.body.innerHTML += `
<p>Seats Left: ${seats}</p>
`;