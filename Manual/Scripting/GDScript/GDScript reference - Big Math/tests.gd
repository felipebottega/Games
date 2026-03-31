extends Node2D


var answer
var symbol = '+'
var number1 = '0'
var number2 = '0'
var number1_new = '0'
var number2_new = '0'
var symbol_new = '+'


func _ready() -> void:
	var sep = "==================================================================================\n"
	
	# Carrega a classe.
	var bm = BigMath.new()
	
	# Quantas casas decimais a divisão deve gerar.
	bm.division_precision = 515

	# -1 = não limita a saída.
	# 0 ou mais = corta o resultado final para essa quantidade de casas.
	bm.max_output_decimals = -1
	
	var a = "1.234567890"
	var b =  "1.234567890987654321012345678909876543210"
	var apb =  "2.46913578098765432101234567890987654321"
	var amb = "-0.00000000098765432101234567890987654321"
	var atb = "1.5241578762383784111415942687623837841112635269"
	var adb = "0.999999999199999993339999944820999542080996199823148463111321281825744254522564109719024577122678348921040051183405641334056422551734250766043717132736509694052693289309079204324829463003002850881675377687875515300550023117686437633791932130296172296020310735655617383072421172144639554968874094520207588968043347489557718273648537196387281447277951550443125055205158433598383748304533526682644433983003466791192330027065304556739204520664754475949979105178178928219386223169123864021534200047042621740238418534508448"
	var bb = "1.5241578774577047232586495953391251354647157445435451912923228166437789971041"
	var x = bm.add(a, b)
	var y = bm.multiply(a, b)
	var z = bm.divide(a, b)
	var t = bm.subtract(a, b)
	var u = bm.square(b)
	
	print('ADD')
	print(apb)
	print(x)
	print(compare_strings(apb, x))
	print(sep)
	
	print('MULTIPLY')
	print(atb)
	print(y)
	print(compare_strings(atb, y))
	print(sep)
	
	print('DIVIDE')
	print(adb)
	print(z)
	print(compare_strings(adb, z))
	print(sep)
	
	print('SUBTRACT')
	print(amb)
	print(t)
	print(compare_strings(amb, t))
	print(sep)
	
	print('SQUARE')
	print(bb)
	print(u)
	print(compare_strings(bb, u))
	print(sep)

func compare_strings(a: String, b: String) -> String:
	var min_len: int = min(a.length(), b.length())
	var is_equal: bool = true

	for i in range(min_len):
		if a[i] != b[i]:
			is_equal = false
			break

	var result: String = "true" if is_equal else "false"

	# Verifica sobra
	if a.length() > min_len:
		var remainder: String = a.substr(min_len)
		result += " (" + remainder + ")"
	elif b.length() > min_len:
		var remainder: String = b.substr(min_len)
		result += " (" + remainder + ")"

	return result
	
func _process(_delta: float) -> void:
	number1_new = $TextEdit.text
	number2_new = $TextEdit2.text
	symbol_new = $OptionButton.text
	
	if number1_new != number1 or number2_new != number2 or symbol_new != symbol:
		number1 = number1_new
		number2 = number2_new
		symbol = symbol_new
	
		if '+' in symbol:
			var bm = BigMath.new()
			answer = bm.add(number1, number2)
		elif '-' in symbol:
			var bm = BigMath.new()
			answer = bm.subtract(number1, number2)
		elif '*' in symbol:
			var bm = BigMath.new()
			answer = bm.multiply(number1, number2)
		elif '/' in symbol:
			var bm = BigMath.new()
			answer = bm.divide(number1, number2)
			
		print([number1, symbol, number2, answer])
			
		if answer != null:
			$TextEdit3.text = str(answer)
