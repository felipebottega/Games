extends Area2D

# This defines a custom signal called "hit" that we will have our player emit (send out) when it 
# collides with an enemy. We will use Area2D to detect the collision. Select the Player node and 
# click the "Node" tab next to the Inspector tab to see the list of signals the player can emit.
signal hit

# Using the export keyword on the first variable speed allows us to set its value in the Inspector. 
# This can be handy for values that you want to be able to adjust just like a node's built-in 
# properties. Click on the Player node and you'll see the property now appears in the Inspector in a 
# new section with the name of the script. Remember, if you change the value here, it will override 
# the value written in the script.
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var dragging = false
var drag_offset = Vector2.ZERO

# The _ready() function is called when a node enters the scene tree, which is a good time to find 
# the size of the game window.
func _ready():
	screen_size = get_viewport_rect().size
	hide()    # the player will be hidden when the game starts

# We start by setting the velocity to (0, 0) - by default, the player should not be moving. Then we 
# check each input and add/subtract from the velocity to obtain a total direction. For example, if 
# you hold right and down at the same time, the resulting velocity vector will be (1, 1). In this 
# case, since we're adding a horizontal and a vertical movement, the player would move faster 
# diagonally than if it just moved horizontally. We can prevent that if we normalize the velocity, 
# which means we set its length to 1, then multiply by the desired speed. This means no more fast 
# diagonal movement. 
# We also check whether the player is moving so we can call play() or stop() on the AnimatedSprite2D.
# $ is shorthand for get_node(). So in the code above, $AnimatedSprite2D.play() is the same as 
# get_node("AnimatedSprite2D").play(). In GDScript, $ returns the node at the relative path from the 
# current node, or returns null if the node is not found. Since AnimatedSprite2D is a child of the 
# current node, we can use $AnimatedSprite2D.
func _process(delta):
	if dragging:
		return  # Ignora o movimento via teclado durante o arraste
		
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	# Now that we have a movement direction, we can update the player's position. We can also use 
	# clamp() to prevent it from leaving the screen. Clamping a value means restricting it to a 
	# given range. 
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Now that the player can move, we need to change which animation the AnimatedSprite2D is 
	# playing based on its direction. We have the "walk" animation, which shows the player walking 
	# to the right. This animation should be flipped horizontally using the flip_h property for left 
	# movement. We also have the "up" animation, which should be flipped vertically with flip_v for 
	# downward movement.
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	
	# Must be deferred as we can't change physics properties on a physics callback. Disabling the 
	# area's collision shape can cause an error if it happens in the middle of the engine's 
	# collision processing. Using set_deferred() tells Godot to wait to disable the shape until 
	# it's safe to do so.
	$CollisionShape2D.set_deferred("disabled", true)
	
# The last piece is to add a function we can call to reset the player when starting a new game.
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			var touch_pos = event.position
			var space_state = get_world_2d().direct_space_state
			var query = PhysicsPointQueryParameters2D.new()
			query.position = touch_pos
			query.collide_with_areas = true
			query.collide_with_bodies = false
			# query.exclude = [self]  # Comentado para funcionar no touch também
			var result = space_state.intersect_point(query)

			if result.size() > 0:
				dragging = true
				drag_offset = touch_pos - position
				get_viewport().set_input_as_handled()  # bloqueia propagação para outros controles
		else:
			dragging = false

	elif (event is InputEventScreenDrag or event is InputEventMouseMotion) and dragging:
		position = event.position - drag_offset
		get_viewport().set_input_as_handled()  # evita conflitos durante arraste
