## Esta classe é incrível!!! 
## Você precisa usar esta classe para entender o seu poder, vai mudar a sua vida!
## @tutorial:             https://example.com/tutorial_1
class_name amazing
extends Node


## Esta constante é incrível.[br]
## O valor 1000 representa muitas coisas.
const VALUE: int = 1000


## Do something for this plugin. Before using the method
## you first have to [method initialize] [MyPlugin].[br]
## [color=yellow]Warning:[/color] Always [method clean] after use.[br]
## [codeblock]
## func _ready():
##     the_plugin.initialize()
##     the_plugin.do_something()
##     the_plugin.clean()
## [/codeblock]
func compute_sum(n: int) -> int:
	var s = n
	
	for i in VALUE+1:
		s += i
		
	return s 
