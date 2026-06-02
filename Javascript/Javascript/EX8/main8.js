function registerUser() {

    alert("Registered");
}

function changeCategory() {

    document.body.innerHTML += `
    <p>Category Changed</p>
    `;
}

document.getElementById("search")

.addEventListener("keydown", function () {

    console.log("Searching...");
});