extends Sprite2D


func _ready() -> void:
	set_new_color()

func _process(delta: float) -> void:
	rotation -= PI * delta 

func set_new_color():
	modulate = Color(0.3, 0.4, 0.5)
	print('Stack')
	print_stack()
	print('------------------------------------------------')
	
