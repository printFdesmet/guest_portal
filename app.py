import json

from flask import Flask, render_template, request, redirect, url_for
from flask_mail import Mail
from pypsrp.powershell import PowerShell, RunspacePool
from pypsrp.wsman import WSMan

app = Flask(__name__)
mail = Mail(app)


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/guest', methods=['GET', 'POST'])
def guest():
    if request.method == 'POST':
        user_information = {}

        user_information[request.form['surname']] = {'surname': request.form['surname']}
        user_information[request.form['name']] = {'name': request.form['name']}
        user_information[request.form['mail']] = {'mail': request.form['mail']}
        user_information[request.form['company']] = {'company': request.form['company']}
        user_information[request.form['contact_person']] = {'contact_person': request.form['contact_person']}
        user_information[request.form['number_plate']] = {'number_plate': request.form['number_plate']}

        with open('user_information.json', 'w') as information_file:
            json.dump(user_information, information_file)

        with open('password.txt', 'r') as file:
            admin_password = file.read()

        wsman = WSMan("SRV-DC-VS-01", username="administrator", password=str(admin_password), cert_validation=False)

        with RunspacePool(wsman) as pool:
            ps = PowerShell(pool)

        return render_template('guest.html')
    else:
        return redirect(url_for('home'))


if __name__ == '__main__':
    app.run()
