extends Node

var message

func _ready() -> void:
	print(OS.get_locale_language())
	
	message = tr("{character} picked up the {weapon}").format({character="OGRE", weapon="SWORD"})
	print(message)
	
	TranslationServer.set_locale("es")
	message = tr("{character} picked up the {weapon}").format({character=tr("OGRE"), weapon=tr("SWORD")})
	print(message)
	
	TranslationServer.set_locale("ja")
	message = tr("{character} picked up the {weapon}").format({character=tr("OGRE"), weapon=tr("SWORD")})
	print(message)
