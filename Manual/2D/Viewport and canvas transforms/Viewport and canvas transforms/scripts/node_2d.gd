extends Node2D

func _ready():
	print(transform)
	print($Sprite2D.transform)
	print(get_global_transform())
	print(get_global_transform() * $Sprite2D.transform)
