from flask import Flask, render_template, request, jsonify
import pickle 
app = Flask(__name__)
model = pickle.load(open('Trained_ML_model.pkl','rb'))
@app.route("/")
def index():
    return "Pet Care System"
@app.route("/predict", methods=['GET','POST'])
def predict():
    if request.method == "POST":
        breed = int(request.form.get("breed"))
        temp = float(request.form.get("temp"))
        age = int(request.form.get("age"))
        heartrate = int(request.form.get("heartrate"))
        weight = int(request.form.get("weight"))
        gender = int(request.form.get("gender"))
        food = int(request.form.get("food"))
        water = int(request.form.get("water"))
        input_cols = [[breed, temp, age, heartrate, weight, gender, food, water]]
        prediction = model.predict(input_cols)
        output = prediction[0]
        if output[1] == 1:
            output_text = "Healthy"
        else: 
            output_text = "Unhealthy"

    return jsonify({'output': output_text, 'risk': output[0]})
if __name__ == "__main__": 
    app.run(debug=True)