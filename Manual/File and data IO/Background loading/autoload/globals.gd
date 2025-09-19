extends Node

var inicio: int = Time.get_ticks_usec()

func log_delta() -> String:
	var agora = Time.get_ticks_usec()
	var delta_us = agora - inicio  # diferença em microssegundos
	var segundos = int(delta_us / 1_000_000)
	var milis = int((delta_us % 1_000_000) / 1000)
	var tempo = "%d.%03d" % [segundos, milis]
	return tempo
