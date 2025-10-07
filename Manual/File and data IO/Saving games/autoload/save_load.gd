extends Node

func save_game():
	var save_file = FileAccess.open("user://gafanhoto_savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Save") + get_tree().get_nodes_in_group("SaveAutoload")
	
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
		print("node '%s' saved successfully" % node.name)
		
	return
	
func load_game():
	if not FileAccess.file_exists("user://gafanhoto_savegame.save"):
		return

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	if len(get_tree().get_nodes_in_group("Save")) == 0:
		return
	
	for node in get_tree().get_nodes_in_group("Save"):
		node.queue_free()
		
	# Wait for the end of the frame to ensure nodes are removed.
	await get_tree().process_frame
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://gafanhoto_savegame.save", FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data
		print('load_game: node_data: ', node_data)

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		
		# By default it puts new_object as the last child of the parent.
		get_node(node_data["parent"]).add_child(new_object)
		await get_tree().process_frame
		get_node(node_data["parent"]).move_child(new_object, node_data["index"])
		
		# Positional variables called 'pos_x' and 'pos_y', if they exist.
		if "pos_x" in node_data and "pos_y" in node_data:
			new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		for node in node_data.keys():
			if node not in ["filename", "parent", "pos_x", "pos_y", "index"]:
				new_object.set(node, node_data[node])
			
	return
	
func load_game_autoload():
	if not FileAccess.file_exists("user://gafanhoto_savegame.save"):
		return

	# Autoload: do NOT delete nodes, only update existing ones
	# Autoload nodes are in the group "SaveAutoload"
	# This preserves singleton managers and other autoload scenes
	# that should not be removed during load.
	var save_file = FileAccess.open("user://gafanhoto_savegame.save", FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data
		print("load_game_autoload: node_data: ", node_data)

		# Update existing nodes in the SaveAutoload group
		for node in get_tree().get_nodes_in_group("SaveAutoload"):
			for i in node_data.keys():
				if i not in ["filename", "parent", "pos_x", "pos_y", "index"]:
					# Only set if the node actually has that property
					if node.has_method("set") or node.has_meta(i) or node.has_variable(i):
						node.set(i, node_data[i])
				
	return

func load_file():
	if not FileAccess.file_exists("user://gafanhoto_savegame.save"):
		return {"state": -1}
		
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://gafanhoto_savegame.save", FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data
		print('load_file: node_data: ', node_data)
		
		return node_data
