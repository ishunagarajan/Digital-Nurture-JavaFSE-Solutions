let events = [

    { name: "Workshop", seats: 10, active: true },

    { name: "Old Event", seats: 0, active: false }
];

events.forEach(event => {

    if(event.active && event.seats > 0) {

        document.body.innerHTML += `
        <p>${event.name}</p>
        `;
    }

    else {

        document.body.innerHTML += `
        <p>Hidden Event</p>
        `;
    }
});

try {

    let seats = 0;

    if(seats <= 0) {

        throw "No Seats Available";
    }

}

catch(error) {

    document.body.innerHTML += `
    <p>${error}</p>
    `;
}