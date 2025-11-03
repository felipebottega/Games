extends Node2D

func _ready() -> void:
	_set_text_in_label()

func _set_text_in_label():
	var message := "This text is being translated through script: \n"
	message += tr("KEY_TEXT")
	$TextLabel.text = message

func _on_english_pressed() -> void:
	TranslationServer.set_locale("en")

func _on_spanish_pressed() -> void:
	TranslationServer.set_locale("es")

func _on_japanese_pressed() -> void:
	TranslationServer.set_locale("ja")

func _on_play_audio_pressed() -> void:
	$Audio.play()

func _notification(what):
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		_set_text_in_label()
