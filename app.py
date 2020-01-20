from flask import Flask, render_template, request

app = Flask(__name__)


@app.route('/')
def home():
    return render_template('index.html')


@app.route('/guest', methods=['GET', 'POST'])
def guest():
    if request.method == 'POST':
        return render_template('guest.html',
                               surname=request.form['surname'],
                               name=request.form['name'],
                               mail=request.form['mail'],
                               company=request.form['company'],
                               contact_person=request.form['contact_person'],
                               number_plate=request.form['number_plate'])
    else:
        return 'This is not valid.'


if __name__ == '__main__':
    app.run()
