extends AudioStreamPlayer

var cached_scene: Node = null
var instantiation_ready: bool = false

func preload_and_instantiate(path: String):
	ResourceLoader.load_threaded_request(path)

func check_and_instantiate(path: String):
	var status = ResourceLoader.load_threaded_get_status(path)
	if status == ResourceLoader.THREAD_LOAD_LOADED and not instantiation_ready:
		var scene = ResourceLoader.load_threaded_get(path)
		cached_scene = scene.instantiate()
		instantiation_ready = true
