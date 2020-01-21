import json
import os.path

from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/guest', methods=['GET', 'POST'])
def guest():
    if request.method == 'POST':
        user_information = {}
        #
        #     if os.path.exists('user_information.json'):
        #         with open('user_information.json') as informations_file:
        #             user_information = json.load(informations_file)
        #
        #     if request.form['surname'] in user_information.keys():
        #         return redirect(url_for('home'))
        #
        #     if request.form['name'] in user_information.keys():
        #         return redirect(url_for('home'))
        #
        #     if request.form['mail'] in user_information.keys():
        #         return redirect(url_for('home'))
        #
        #     if request.form['company'] in user_information.keys():
        #         return redirect(url_for('home'))
        #
        #     if request.form['contact_person'] in user_information.keys():
        #         return redirect(url_for('home'))
        #
        #     if request.form['number_plate'] in user_information.keys():
        #         return redirect(url_for('home'))

        user_information[request.form['surname']] = {'surname': request.form['surname']}
        user_information[request.form['name']] = {'name': request.form['name']}
        user_information[request.form['mail']] = {'mail': request.form['mail']}
        user_information[request.form['company']] = {'company': request.form['company']}
        user_information[request.form['contact_person']] = {'contact_person': request.form['contact_person']}
        user_information[request.form['number_plate']] = {'number_plate': request.form['number_plate']}
        with open('user_information.json', 'w') as information_file:
            json.dump(user_information, information_file)
        return render_template('guest.html',
                               surname=request.form['surname'],
                               name=request.form['name'],
                               mail=request.form['mail'],
                               company=request.form['company'],
                               contact_person=request.form['contact_person'],
                               number_plate=request.form['number_plate'])
    else:
        return redirect(url_for('home'))


if __name__ == '__main__':
    app.run()
