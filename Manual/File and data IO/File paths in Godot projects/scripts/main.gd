extends Node

var pos = Vector2(10, 10)
var show_label = true
var label_scale = Vector2(0.7, 0.7)
var sep = '======================================================================='

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var name = "Integral"
	var health = 1234

	print("{0} health is {1}".format([name, health]))

	# Raíz do projeto.
	var x = "res://"
	
	# Join de caminhos.
	var y = x.path_join("scenes/node.tscn")
	print("path = {0}".format([y]))
	
	# Extrai o nome do arquivo no caminho.
	var z = y.get_file()
	print("get_file = {0}".format([z]))
	
	# Extrai a primeira pasta no caminho.
	z = y.get_base_dir()
	print("get_base_dir = {0}".format([z]))
	
	# Extrai o caminho completo até a última pasta antes do arquivo.
	z = y.get_basename()
	print("get_basename = {0}".format([z]))
	
	# Simlariadde de strings. 0 = nenhuma, 1 = idênticas
	z = x.similarity(y)
	print("similarity ({0}, {1}) = {2}".format([x, y, z]))
	
	# Faz split por uma substring.
	z = y.split("scenes")
	print("split = {0}".format([z]))
	
	# Replace de substring.
	z = y.replace("res", "abc")
	print("replace = {0}".format([z]))
	
	# Converte string para float. Também tem conversões análogas para outros tipos de variável.
	z = "123.45".to_float()
	print("to_float = {0}".format([z]))
	
	# Extrai o caminho absoluto em relação ao sistema operacional. 
	z = ProjectSettings.globalize_path(y)
	print("ProjectSettings.globalize_path = {0}".format([z]))
	
	# Extrai todas as pastas dentro de uma pasta.
	z = DirAccess.open("scenes")    # objeto
	z = z.get_directories()    # lista de strings
	print("get_directories = {0}".format([z]))
	
	# Extrai todos os arquivos dentro de uma pasta.
	z = DirAccess.open("scenes")    # objeto
	z = z.get_files()    # lista de strings
	print("get_files = {0}".format([z]))
	
	# Faz um varredura completa em todos os arquivos e pastas do projeto.
	print()
	add_label(ProjectSettings.globalize_path("res://"))
	add_label(sep)
	varredura("res://")
	
	# Faz um varredura completa em todos os arquivos e pastas do usuário (relativo ao projeto).
	pos = Vector2(550, 10)
	print()
	add_label(ProjectSettings.globalize_path("user://"))
	add_label(sep)
	varredura("user://")

func varredura(path_folder, space=''):
	var f = DirAccess.open(path_folder)    
	
	if f != null:
		var folders = f.get_directories()    
		var files = f.get_files()
	
		for folder in folders:
			if '.godot' not in folder:
				add_label(space + folder)
				varredura(path_folder.path_join(folder), space + '|   ')
			
		for file in files:
			if '.import' not in file and '.uid' not in file:
				add_label(space + '|----' + file)
		
	return 
	
func add_label(msg):
	if show_label:
		var lbl = Label.new()
		lbl.text = msg
		#lbl.scale = label_scale
		lbl.add_theme_font_size_override("font_size", 13)
		lbl.position = pos
		add_child(lbl)
		pos.y += 14
		
	print(msg)
		
	return
	
	
