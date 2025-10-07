extends PointLight2D

var position_orig
var scale_orig

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position_orig = position
	scale_orig = scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if randf() > 0.9:
		position = position_orig + Vector2(randf_range(-1, 1), randf_range(-1, 1))
		scale = scale_orig * randf_range(0.98, 1.02)
