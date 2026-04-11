extends CanvasLayer


func _ready() -> void:
	# Using get_node
	#var label = get_node("Button1/Label") # path
	#var label = get_node("%Label") # unique name
	
	# Using shortcut
	#var label = $Button1/Label # path
	var label = %Label # unique name
	
	label.text = "123456!"
