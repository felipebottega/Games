extends CharacterBody2D

const SPEED = 300.0
var last_nonnull_direction = 0.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Walk
	if direction:
		velocity.x = direction * SPEED
		$AnimationTree.set("parameters/blend_position", Vector2(direction, 0.0))
		last_nonnull_direction = direction
	# Idle
	else:
		velocity.x = 0
		# Watch
		if abs(global_position.x - $"../Scenario/TV1".position.x) < 100:
			$AnimationTree.set("parameters/blend_position", Vector2(0.0, -1.0))
		elif abs(global_position.x - $"../Scenario/TV2".position.x) < 100:
			$AnimationTree.set("parameters/blend_position", Vector2(0.0, -1.0))
		# Idle right
		elif last_nonnull_direction == 1.0:
			$AnimationTree.set("parameters/blend_position", Vector2(0.0, 1.0))
		# Idle left
		else:
			$AnimationTree.set("parameters/blend_position", Vector2(-0.4, 0.6))

	move_and_slide()
