let surname;
let name;
let mail;
let company;
let contact_person;
let number_plate;


function send_mail() {
    let link = "mailto:me@example.com"
        + "?cc=myCCaddress@example.com"
        + "&subject=" + escape("This is my subject")
        + "&body=" + escape(document.getElementById('myText').value)
    ;

    window.location.href = link;
}