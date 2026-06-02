console.log("Form Submission Started");

let user = {

    name: "Alex"
};

console.log(user);

document.body.innerHTML += `
<p>Check Console for Debug Logs</p>
`;

fetch("https://jsonplaceholder.typicode.com/posts", {

    method: "POST",

    body: JSON.stringify(user),

    headers: {

        "Content-Type": "application/json"
    }
})

.then(response => response.json())

.then(data => {

    console.log(data);
});