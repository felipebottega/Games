extends Node2D


@export var speed: float = 100
@export var bullet_count: int = 100

var BulletScene := preload("res://bullet.tscn")
var texture := preload("res://texture.png")


func _ready():
	for child in $Maze.get_children():
		if child is CollisionShape2D:
			var sprite = Sprite2D.new()
			sprite.texture = texture
			sprite.position = child.position
			sprite.rotation = child.rotation - PI/2
			sprite.scale = Vector2(0.074, 0.037)
			$Maze.add_child(sprite)
	
	for i in range(bullet_count):
		var bullet = BulletScene.instantiate()
		bullet.position = Vector2(10, 10) + Vector2(i * 2, i * 2)
		bullet.direction = speed * Vector2(randf_range(-1, 1), randf_range(-1, 1))
		bullet.modulate = Color(randf(), randf(), randf(), 1.0)
		add_child(bullet)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bullet:
		var l = Label.new()
		l.text = "GAME OVER"
		l.position = get_viewport_rect().size / 2
		l.position.x -= 50
		add_child(l)
		Engine.time_scale = 0.01

func _on_button_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://main.tscn")
