extends CharacterBody2D

const SPEED = 100.0
var last_notnull_direction = Vector2.DOWN

func _ready() -> void:
	position = Vector2(400, 200)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	
	if direction.x != 0 or direction.y != 0:
		last_notnull_direction = direction
	
	$AnimationTree.set("parameters/StateMachine/Movement/blend_position", last_notnull_direction)
	$AnimationTree.set("parameters/StateMachine/Idle/blend_position", last_notnull_direction)
	
	if global_position.x > 400:
		velocity = direction * SPEED * 2.5
		$AnimationTree.set("parameters/TimeScale/scale", 2.5)
	else:
		$AnimationTree.set("parameters/TimeScale/scale", 1.0)

	move_and_slide()
	
