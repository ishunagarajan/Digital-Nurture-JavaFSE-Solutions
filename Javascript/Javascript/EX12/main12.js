let user = {

    name: "John",

    event: "Workshop"
};

setTimeout(() => {

    fetch("https://jsonplaceholder.typicode.com/posts", {

        method: "POST",

        body: JSON.stringify(user),

        headers: {

            "Content-Type": "application/json"
        }
    })

    .then(response => response.json())

    .then(data => {

        document.body.innerHTML += `
        <p>Registration Successful</p>
        `;
    })

    .catch(error => {

        document.body.innerHTML += `
        <p>Registration Failed</p>
        `;
    });

}, 2000);