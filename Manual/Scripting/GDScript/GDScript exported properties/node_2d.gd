extends Node2D


@export var sprite_color: Color = Color(1.0, 1.0, 1.0, 1.0)

@export_file var path: String
@export_dir var folder: String
@export_global_file var abs_path
@export_global_dir var abs_folder

@export_range(-20, 20) var i
@export_range(-10, 20, 0.2) var j
@export_range(-20, 20, 5) var k: int
@export_range(0, 100000, 0.01, "exp") var exponential
@export_range(0, 1000, 0.01, "hide_slider") var no_slider
@export_range(0, 100, 1, "suffix:meters") var m
@export_range(0, 360, 0.1, "radians_as_degrees") var angle

@export var col: Color
@export_color_no_alpha var col2: Color

@export var mynode: Node
@export var some_button: Button

@export var rsc: Resource
@export var rsc2: AnimationNode

@export_enum("WARRIOR", "MAGICIAN", "THIEF") var character_class = "THIEF"

@export var a = [1, 2, 3]
@export var b: Array
@export var c: Array[int] = [1, 2, 3]
@export var d: Array[PackedScene]
@export var e = PackedVector3Array()


func _ready() -> void:
	print(path)
	print(folder)
	print(abs_path)
	print(abs_folder)
	print(character_class)

func _process(_delta: float) -> void:
	$Sprite2D.modulate = sprite_color
