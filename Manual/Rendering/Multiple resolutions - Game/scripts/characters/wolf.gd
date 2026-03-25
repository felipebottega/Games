extends CharacterBody2D


const SPEED = 300.0


func _ready():
	$AudioStreamPlayer.volume_db = GameState.volume + 5.0
	$AudioStreamPlayer.volume_db = GameState.volume + 10.0
	await get_tree().create_timer(15.0).timeout
	queue_free()

func _physics_process(_delta: float) -> void:
	velocity = Vector2.LEFT.rotated(randf()) * SPEED
	move_and_slide()
