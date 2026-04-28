extends Node2D


func _on_rich_text_label_3_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
