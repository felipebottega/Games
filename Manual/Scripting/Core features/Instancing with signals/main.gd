extends Node2D


func _on_player_shoot(rock, direction, location):
	var spawned_rock = rock.instantiate()
	add_child(spawned_rock)
	spawned_rock.rotation = direction
	spawned_rock.position = location
	spawned_rock.velocity = spawned_rock.velocity.rotated(direction)
