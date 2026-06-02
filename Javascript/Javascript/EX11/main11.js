document.getElementById("form")

.addEventListener("submit", function(event) {

    event.preventDefault();

    let name =
        this.elements["username"].value;

    if(name === "") {

        document.getElementById("error")

        .innerHTML = "Name Required";
    }

    else {

        document.body.innerHTML += `
        <p>Form Submitted</p>
        `;
    }
});