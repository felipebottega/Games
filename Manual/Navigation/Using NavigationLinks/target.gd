extends Sprite2D


func _ready():
	while true:
		await get_tree().create_timer(5.0).timeout
		global_position = Vector2(randi_range(0, 1000), randi_range(0, 600))
