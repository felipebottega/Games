extends PathFollow2D


var t = 0
var nome = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_ratio = 0
	nome = get_parent().get_parent().name
	print(get_parent().name, ' ', nome)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if nome == "P1":
		progress_ratio += 0.001
	elif nome == "P2":
		progress_ratio = sin(t)
		
	t += 0.1 * delta
	if t > PI/2:
		t = 0
