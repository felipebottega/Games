extends Node


func _ready() -> void:
	var x = 1
	print('Mensagem do script')
	
	for i in 1000:
		var y = x/(x-i-2.0)
		print(y)
