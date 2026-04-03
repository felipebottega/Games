extends Node


func _ready() -> void:
	print('Mensagem do script com print')
	print('------------------------------------------------')
	print_rich('[b]Mensagem do script[/b] com [color=green][i]print_rich[/i][/color]')
	print('------------------------------------------------')
	push_error('Mensagem do script com push_error')
	print('------------------------------------------------')
	push_warning('Mensagem do script com push_warning')
	print('------------------------------------------------')
	print('Stack')
	print_stack()
	print('------------------------------------------------')
	print_tree()
	print('------------------------------------------------')
	print_tree_pretty()
	print('------------------------------------------------')
	
