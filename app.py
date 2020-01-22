import json
import os
import os.path

from flask import Flask, render_template, request, redirect, url_for
from flask_mail import Mail

app = Flask(__name__)
mail = Mail(app)


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/guest', methods=['GET', 'POST'])
def guest():
    if request.method == 'POST':
        user_information = {}
        if os.path.exists('user_information.json') and os.stat('user_information.json').st_size != 0:
            with open('user_information.json') as informations_file:
                user_information = json.load(informations_file)

        guest_user = f'{request.form["surname"]} {request.form["name"]}'

        user_information[guest_user] = {'surname': request.form['surname'],
                                        'name': request.form['name'],
                                        'mail': request.form['mail'],
                                        'company': request.form['company'],
                                        'contact_person': request.form['contact_person'],
                                        'number_plate': request.form['number_plate']}

        with open('user_information.json', 'w') as information_file:
            json.dump(user_information, information_file)
        return render_template('guest.html')
    else:
        return redirect(url_for('home'))


if __name__ == '__main__':
    app.run()
