from flask import Flask, render_template, send_from_directory, jsonify
from app import app
from random_temperature import rand_temp

@app.route('/_random_temperature', methods= ['GET','POST'])
def stuff():
    temperature=round(rand_temp(),3)
    return jsonify(temperature=temperature)

@app.route('/')
@app.route('/index')
def index(chartID = 'chart_ID', chart_type = 'spline', chart_height = 350):

	chart = {"renderTo": chartID, "type": chart_type, "height": chart_height,}
	series = [{"name": 'Label1', "data": [1,2,3]}, {"name": 'Label2', "data": [4,5,6]}]
	title = {"text": 'My Title'}
	xAxis = {"categories": ['xAxis Data1', 'xAxis Data2', 'xAxis Data3']}
	yAxis = {"title": {"text": 'yAxis Label'}}
	return render_template('index.html', chartID=chartID, chart=chart, series=series, title=title, xAxis=xAxis, yAxis=yAxis)

@app.route('/images/<path:path>')
def send_img(path):
	return send_from_directory('images', path)
