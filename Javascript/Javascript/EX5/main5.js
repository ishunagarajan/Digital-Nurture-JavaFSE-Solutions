function Event(name, seats) {

    this.name = name;

    this.seats = seats;
}

Event.prototype.checkAvailability = function () {

    return this.seats > 0;
};

let event1 = new Event("Workshop", 20);

document.body.innerHTML += `
<p>Event: ${event1.name}</p>

<p>Available: ${event1.checkAvailability()}</p>
`;

Object.entries(event1).forEach(item => {

    document.body.innerHTML += `
    <p>${item[0]} : ${item[1]}</p>
    `;
});