extends CharacterBody2D

var query_parameters := NavigationPathQueryParameters2D.new()
var query_result := NavigationPathQueryResult2D.new()
var path: PackedVector2Array = PackedVector2Array()
var regions_orig = []

@export var speed = 0
@export var pathfinding_algorithm = NavigationPathQueryParameters2D.PATHFINDING_ALGORITHM_ASTAR
@export_enum("CORRIDORFUNNEL", "EDGECENTERED", "NONE") var path_postprocessing = 0
@export var simplify_path = false
@export var simplify_epsilon = 0.0
@export var path_return_max_length = 0.0
@export var path_return_max_radius = 0.0
@export var path_search_max_distance = 0.0
@export var path_search_max_polygons = 0
@export var navigation_layers = 1
@export var included_regions = []
@export var excluded_regions = []
@export_enum("None", "Types", "RIDs", "Owners", "All") var metadata_flags = 0

var line_path: Line2D

var dragging = false
var drag_offset = Vector2.ZERO


func _ready() -> void:
	await get_tree().process_frame
	var map: RID = get_world_2d().get_navigation_map()

	for region_rid in NavigationServer2D.map_get_regions(map):
		regions_orig.append(region_rid)

func _physics_process(_delta):
	query_parameters.start_position = global_position
	query_parameters.target_position = $"../Target".global_position
	query_parameters.pathfinding_algorithm = pathfinding_algorithm
	
	if path_postprocessing == 0:
		query_parameters.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_CORRIDORFUNNEL
	elif path_postprocessing == 1:
		query_parameters.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED
	elif path_postprocessing == 2:
		query_parameters.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_NONE
		
	query_parameters.simplify_path = simplify_path
	query_parameters.simplify_epsilon = simplify_epsilon
	query_parameters.path_return_max_length = path_return_max_length
	query_parameters.path_return_max_radius = path_return_max_radius
	query_parameters.path_search_max_distance = path_search_max_distance
	query_parameters.path_search_max_polygons = path_search_max_polygons
	query_parameters.navigation_layers = navigation_layers
	query_parameters.included_regions = included_regions
	query_parameters.excluded_regions = excluded_regions
	
	if metadata_flags == 0:
		query_parameters.metadata_flags = NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_NONE
	elif metadata_flags == 1:
		query_parameters.metadata_flags = NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_TYPES
	elif metadata_flags == 2:
		query_parameters.metadata_flags = NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_RIDS
	elif metadata_flags == 3:
		query_parameters.metadata_flags = NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_OWNERS
	elif metadata_flags == 4:
		query_parameters.metadata_flags = NavigationPathQueryParameters2D.PATH_METADATA_INCLUDE_ALL

	path = query_path()
	follow_path()
	plot_path()
	
func follow_path():
	if path.size() < 2:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var next_point = path[1]
	velocity = global_position.direction_to(next_point) * speed
	move_and_slide()
	
func plot_path():
	if path.size() >= 2:
		$"../Line2D".points = path
		queue_redraw()
	else:
		$"../Line2D".clear_points()
		
func _draw():
	for p in path:
		draw_circle(to_local(p), 15.0, Color.BLUE)
		
func _input(event: InputEvent):
	# Input para fazer o NPC seguir o caminho.
	if event is InputEventKey and event.pressed and event.keycode == KEY_D:
		speed = 100
	else:
		speed = 0

func query_path():
	# Obtém o RID (identificador interno) do navigation map do World2D atual. 
	var map: RID = get_world_2d().get_navigation_map()

	# Se o iteration_id for 0, ainda não existem polígonos/regiões válidos para pathfinding.
	if NavigationServer2D.map_get_iteration_id(map) == 0:
		return PackedVector2Array()

	# Define em qual navigation map a consulta será feita.
	query_parameters.map = map

	# Executa a query. O resultado é escrito dentro de query_result. Repare que query_result é
	# reutilizado, ele é sobrescrito a cada chamada.
	NavigationServer2D.query_path(query_parameters, query_result)

	# Extrai o caminho final como uma lista (PackedVector2Array) de pontos. Se nenhum caminho
	# existir, o array pode vir vazio.
	path = query_result.get_path()

	return path
	
func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = global_position - event.position
		else:
			dragging = false
