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
let dropdown_purpose;
let mandatory_user_input_array;

//}

dropdown_purpose = document.getElementById("purpose");


function instantiate_events() {
    dropdown_purpose.addEventListener('change', show_other_field())
}

function show_other_field() {
    if (dropdown_purpose.value === 'Anders') {

    }
}
