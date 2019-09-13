extends Node

const appID = "b9821f6cea52e996944eb54382b85f9d"
var cidade = "Teresina"
var tempo
var temperatura

func _ready():
	pass # Replace with function body.


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var resultado = json.result
	if response_code == 404:
		get_node("CanvasLayer/Tempo").set_text("Error")
		get_node("CanvasLayer/Temperatura").set_text("404")
	else:
		extract(resultado)
		update()


func _on_Button_pressed():
	print("apertei")
	$HTTPRequest.request("http://api.openweathermap.org/data/2.5/weather?q=" + cidade + "&appid=" + appID)


func _on_Cidade_text_changed(new_text):
	cidade = new_text


func extract(resultado):
	var clima = resultado['weather']
	print(clima)
	tempo = clima[0]['main']
	var temp = resultado['main']
	temperatura = int(float(temp['temp']) - 273.15)
	
func update():
	get_node("CanvasLayer/Tempo").set_text(tempo)
	get_node("CanvasLayer/Temperatura").set_text(str(temperatura) + "°C")