extends VideoStreamPlayer

var volume_init
var decay = 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volume_init = volume_db

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var factor = decay * abs($"../Player".position.x - global_position.x - 100)
	volume_db = volume_init - factor 
