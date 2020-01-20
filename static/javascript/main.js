/*
TODO: add data in function onclick instead of from start.
TODO: make the users input mandatory. exclusive the company.
TODO: put the userdata to a database.
TODO: clear all fields after clicking the button.
TODO: alert when a required field is not filled in.
*/

//instantiate_variables();
instantiate_events();

//function instantiate_variables() {
let surname;
let name;
let mail;
let company;
let contact_person;
let number_plate;
let btn_submit;
let mandatory_user_input_array;

//}

function instantiate_events() {
    btn_submit.addEventListener('click',);
}

function store_user_input() {
    surname = document.getElementById('first_name').innerText;
    name = document.getElementById('last_name').innerText;
    mail = document.getElementById('mail').innerText;
    company = document.getElementById('company').innerText;
    contact_person = document.getElementById('contact_person').innerText;
    number_plate = document.getElementById('number_plate').innerText;

    mandatory_user_input_array = [surname, name, mail, contact_person, number_plate];

    for (let i = 0; i < mandatory_user_input_array.length; i++) {
        if (mandatory_user_input_array[i].innerText === "") {
            alert(`${mandatory_user_input_array[i].name} is empty.\nPlease provide the required information.`);
        }
    }
}