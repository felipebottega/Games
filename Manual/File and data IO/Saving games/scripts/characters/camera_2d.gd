extends Camera2D

var global_x
var global_y

func _ready() -> void:
	limit_left = -50
	limit_top = -1000000    # virtualmente sem limites

func _physics_process(_delta: float) -> void:
	global_x = global_position.x
	global_y = global_position.y
	
	# Limites na floresta.
	if 0 < global_x and global_x < 600 and -4200 < global_y and global_y < 600:
		limit_right = 650
		limit_bottom = 600
	# Limites no topo da floresta. Agora limit_right tem que ser função da altura, sendo 650 quando 
	# y=-4200 e 1300 quando y=-5000.
	elif 0 < global_x and global_x < 600 and -4200 > global_y:
		limit_right = - 0.8125 * global_y - 2762.5
	# Limites fora da floresta.
	else:
		limit_right = 1000000    # virtualmente sem limites
		limit_bottom = -700
