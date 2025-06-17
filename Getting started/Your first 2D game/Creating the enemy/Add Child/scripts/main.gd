extends Node2D


var mob_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mob_scene = preload("res://scenes/mob.tscn")  # Isso é um PackedScene

func _on_timer_timeout() -> void:
	# Choose a random location on Path2D.
	var mob_spawn_location = $MobSpawn/Path2D/PathFollow2D
	mob_spawn_location.progress_ratio = randf()

	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.global_position
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI/2
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(0, 100), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
