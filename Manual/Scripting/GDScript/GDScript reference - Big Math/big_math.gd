class_name BigMath

const BASE: int = 10000
const BASE_DIGITS: int = 4


class NumberParts:
	var sign: int = 1
	var digits: String = "0"
	var scale: int = 0

	func _init(_sign: int = 1, _digits: String = "0", _scale: int = 0) -> void:
		sign = _sign
		digits = _digits
		scale = _scale


# Quantas casas decimais a divisão deve gerar.
var division_precision: int = 500

# -1 = não limita a saída.
# 0 ou mais = corta o resultado final para essa quantidade de casas.
var max_output_decimals: int = -1


# ------------------------
# API pública
# ------------------------

func add(a: String, b: String, limit_decimals: int = -1) -> String:
	var pa: NumberParts = _parse_number(a)
	var pb: NumberParts = _parse_number(b)

	if pa.digits == "0":
		return _apply_output_policy(_format_number(pb.sign, pb.digits, pb.scale), limit_decimals)
	if pb.digits == "0":
		return _apply_output_policy(_format_number(pa.sign, pa.digits, pa.scale), limit_decimals)

	var common_scale: int = maxi(pa.scale, pb.scale)
	var ad: PackedInt64Array = _scaled_digits_blocks_fast(pa, common_scale)
	var bd: PackedInt64Array = _scaled_digits_blocks_fast(pb, common_scale)

	if pa.sign == pb.sign:
		var sum_blocks: PackedInt64Array = _add_block_arrays(ad, bd)
		return _apply_output_policy(
			_format_number(pa.sign, _block_array_to_digits_string(sum_blocks), common_scale),
			limit_decimals
		)

	var cmp: int = _compare_block_arrays(ad, bd)
	if cmp == 0:
		return "0"

	if cmp > 0:
		var diff_a: PackedInt64Array = _subtract_block_arrays(ad, bd)
		return _apply_output_policy(
			_format_number(pa.sign, _block_array_to_digits_string(diff_a), common_scale),
			limit_decimals
		)
	else:
		var diff_b: PackedInt64Array = _subtract_block_arrays(bd, ad)
		return _apply_output_policy(
			_format_number(pb.sign, _block_array_to_digits_string(diff_b), common_scale),
			limit_decimals
		)

func subtract(a: String, b: String, limit_decimals: int = -1) -> String:
	var pb: NumberParts = _parse_number(b)
	pb.sign *= -1
	return add(a, _format_number(pb.sign, pb.digits, pb.scale), limit_decimals)


func multiply(a: String, b: String, limit_decimals: int = -1) -> String:
	var pa: NumberParts = _parse_number(a)
	var pb: NumberParts = _parse_number(b)

	if pa.digits == "0" or pb.digits == "0":
		return "0"

	var result_sign: int = pa.sign * pb.sign
	var ad: PackedInt64Array = _digits_string_to_block_array(pa.digits)
	var bd: PackedInt64Array = _digits_string_to_block_array(pb.digits)
	var result_blocks: PackedInt64Array = _multiply_block_arrays(ad, bd)
	var result_digits: String = _block_array_to_digits_string(result_blocks)
	var result_scale: int = pa.scale + pb.scale

	return _apply_output_policy(_format_number(result_sign, result_digits, result_scale), limit_decimals)


func divide(a: String, b: String, limit_decimals: int = -1) -> String:
	var pa: NumberParts = _parse_number(a)
	var pb: NumberParts = _parse_number(b)

	if pb.digits == "0":
		push_error("Division by zero")
		return ""

	if pa.digits == "0":
		return "0"

	var result_sign: int = pa.sign * pb.sign

	var dividend_digits: String = pa.digits + "0".repeat(pb.scale + division_precision)
	var divisor_digits: String = pb.digits + "0".repeat(pa.scale)

	var dividend_blocks: PackedInt64Array = _digits_string_to_block_array(dividend_digits)
	var divisor_blocks: PackedInt64Array = _digits_string_to_block_array(divisor_digits)

	var quotient_blocks: PackedInt64Array = _divide_block_arrays(dividend_blocks, divisor_blocks)
	var quotient: String = _block_array_to_digits_string(quotient_blocks)

	var formatted: String
	if division_precision > 0:
		if quotient.length() <= division_precision:
			quotient = quotient.lpad(division_precision + 1, "0")

		var split_at: int = quotient.length() - division_precision
		formatted = quotient.substr(0, split_at) + "." + quotient.substr(split_at)
	else:
		formatted = quotient

	if result_sign < 0 and formatted != "0":
		formatted = "-" + formatted

	return _apply_output_policy(formatted, limit_decimals)


func compare(a: String, b: String) -> int:
	var pa: NumberParts = _parse_number(a)
	var pb: NumberParts = _parse_number(b)
	return _compare_parsed(pa, pb)
	

func square(a: String, limit_decimals: int = -1) -> String:
	var p: NumberParts = _parse_number(a)

	if p.digits == "0":
		return "0"

	var blocks: PackedInt64Array = _digits_string_to_block_array(p.digits)
	var result_blocks: PackedInt64Array = _square_block_array_fast(blocks)
	var result_digits: String = _block_array_to_digits_string(result_blocks)

	return _apply_output_policy(
		_format_number(1, result_digits, p.scale * 2),
		limit_decimals
	)


func _scaled_digits_blocks_fast(p: NumberParts, target_scale: int) -> PackedInt64Array:
	var blocks: PackedInt64Array = _digits_string_to_block_array(p.digits)
	var extra: int = target_scale - p.scale
	if extra <= 0:
		return blocks
	return _scale_block_array_by_decimal_digits(blocks, extra)


func _scale_block_array_by_decimal_digits(a: PackedInt64Array, extra_digits: int) -> PackedInt64Array:
	if extra_digits <= 0 or _is_zero_blocks(a):
		return a

	var block_shift: int = extra_digits / BASE_DIGITS
	var rem: int = extra_digits % BASE_DIGITS

	var result: PackedInt64Array = a

	if rem > 0:
		result = _multiply_block_array_by_decimal_power(result, rem)

	if block_shift > 0:
		result = _append_zero_blocks(result, block_shift)

	return result


func _multiply_block_array_by_decimal_power(a: PackedInt64Array, digits: int) -> PackedInt64Array:
	var factor: int = 1
	for _i in range(digits):
		factor *= 10

	if factor == 1 or _is_zero_blocks(a):
		return a

	var result: PackedInt64Array = PackedInt64Array()
	result.resize(a.size() + 1)

	var carry: int = 0
	for i in range(a.size() - 1, -1, -1):
		var prod: int = a[i] * factor + carry
		result[i + 1] = prod % BASE
		carry = prod / BASE

	result[0] = carry
	return _trim_leading_zeros_blocks(result)


func _append_zero_blocks(a: PackedInt64Array, count: int) -> PackedInt64Array:
	if count <= 0 or _is_zero_blocks(a):
		return a

	var result: PackedInt64Array = PackedInt64Array()
	result.resize(a.size() + count)

	for i in range(a.size()):
		result[i] = a[i]

	return result


func _square_block_array_fast(a: PackedInt64Array) -> PackedInt64Array:
	a = _trim_leading_zeros_blocks(a)

	if _is_zero_blocks(a):
		return _make_zero_blocks()

	var n: int = a.size()
	var result: PackedInt64Array = PackedInt64Array()
	result.resize(n * 2)

	# Acumula todas as contribuições sem tentar normalizar carry no meio.
	for i in range(n - 1, -1, -1):
		var ai: int = a[i]
		for j in range(i, -1, -1):
			var idx: int = i + j + 1
			var term: int = ai * a[j]
			if i == j:
				result[idx] += term
			else:
				result[idx] += term * 2

	# Uma única passada de carry da direita para a esquerda.
	var carry: int = 0
	for k in range(result.size() - 1, -1, -1):
		var total: int = result[k] + carry
		result[k] = total % BASE
		carry = total / BASE

	if carry > 0:
		var expanded: PackedInt64Array = PackedInt64Array()
		expanded.resize(result.size() + 1)
		expanded[0] = carry
		for i in range(result.size()):
			expanded[i + 1] = result[i]
		result = expanded

	return _trim_leading_zeros_blocks(result)
	

# ------------------------
# Parsing / formatação
# ------------------------

func _parse_number(text: String) -> NumberParts:
	text = text.strip_edges()

	var sign: int = 1
	if text.begins_with("-"):
		sign = -1
		text = text.substr(1)
	elif text.begins_with("+"):
		text = text.substr(1)

	var dot_pos: int = text.find(".")
	var int_part: String = "0"
	var dec_part: String = ""

	if dot_pos == -1:
		int_part = text
	else:
		int_part = text.substr(0, dot_pos)
		dec_part = text.substr(dot_pos + 1)

	int_part = _strip_leading_zeros(int_part)
	dec_part = _strip_trailing_zeros(dec_part)

	if int_part == "":
		int_part = "0"

	var digits: String = int_part + dec_part
	digits = _strip_leading_zeros(digits)
	if digits == "":
		digits = "0"

	if digits == "0":
		sign = 1

	return NumberParts.new(sign, digits, dec_part.length())


func _format_number(sign: int, digits: String, scale: int) -> String:
	digits = _strip_leading_zeros(digits)
	if digits == "" or digits == "0":
		return "0"

	var out: String = digits

	if scale > 0:
		if out.length() <= scale:
			out = out.lpad(scale + 1, "0")

		var split_at: int = out.length() - scale
		var int_part: String = out.substr(0, split_at)
		var dec_part: String = out.substr(split_at)

		dec_part = _strip_trailing_zeros(dec_part)
		if dec_part == "":
			out = _strip_leading_zeros(int_part)
		else:
			out = _strip_leading_zeros(int_part) + "." + dec_part

	if sign < 0 and out != "0":
		return "-" + out

	return out


func _apply_output_policy(text: String, limit_decimals: int = -1) -> String:
	text = _normalize_text(text)

	var effective_limit: int = limit_decimals if limit_decimals >= 0 else max_output_decimals
	if effective_limit < 0:
		return text

	var dot_pos: int = text.find(".")
	if dot_pos == -1:
		return text

	var int_part: String = text.substr(0, dot_pos)
	var dec_part: String = text.substr(dot_pos + 1)

	if dec_part.length() > effective_limit:
		dec_part = dec_part.substr(0, effective_limit)

	if dec_part == "":
		return _normalize_text(int_part)

	return _normalize_text(int_part + "." + dec_part)


func _normalize_text(text: String) -> String:
	text = text.strip_edges()

	var sign_prefix: String = ""
	if text.begins_with("-"):
		sign_prefix = "-"
		text = text.substr(1)
	elif text.begins_with("+"):
		text = text.substr(1)

	var dot_pos: int = text.find(".")
	if dot_pos != -1:
		var int_part: String = _strip_leading_zeros(text.substr(0, dot_pos))
		var dec_part: String = _strip_trailing_zeros(text.substr(dot_pos + 1))

		if int_part == "":
			int_part = "0"

		if dec_part == "":
			return int_part if int_part != "0" else "0"

		return sign_prefix + int_part + "." + dec_part

	text = _strip_leading_zeros(text)
	if text == "":
		text = "0"

	return sign_prefix + text if text != "0" else "0"


# ------------------------
# Comparação
# ------------------------

func _compare_parsed(a: NumberParts, b: NumberParts) -> int:
	if a.sign != b.sign:
		return 1 if a.sign > b.sign else -1

	var cmp: int = _compare_abs(a, b)
	if a.sign < 0:
		cmp *= -1

	return cmp


func _compare_abs(a: NumberParts, b: NumberParts) -> int:
	var common_scale: int = maxi(a.scale, b.scale)
	var ad: PackedInt64Array = _scaled_digits_blocks(a, common_scale)
	var bd: PackedInt64Array = _scaled_digits_blocks(b, common_scale)
	return _compare_block_arrays(ad, bd)


func _compare_block_arrays(a: PackedInt64Array, b: PackedInt64Array) -> int:
	a = _trim_leading_zeros_blocks(a)
	b = _trim_leading_zeros_blocks(b)

	if a.size() > b.size():
		return 1
	if a.size() < b.size():
		return -1

	for i in range(a.size()):
		if a[i] > b[i]:
			return 1
		if a[i] < b[i]:
			return -1

	return 0


# ------------------------
# Aritmética com blocos
# ------------------------

func _add_block_arrays(a: PackedInt64Array, b: PackedInt64Array) -> PackedInt64Array:
	var ia: int = a.size() - 1
	var ib: int = b.size() - 1
	var carry: int = 0

	var result: PackedInt64Array = PackedInt64Array()
	result.resize(maxi(a.size(), b.size()) + 1)

	var k: int = result.size() - 1
	while ia >= 0 or ib >= 0 or carry > 0:
		var sum: int = carry
		if ia >= 0:
			sum += a[ia]
		if ib >= 0:
			sum += b[ib]

		result[k] = sum % BASE
		carry = sum / BASE

		ia -= 1
		ib -= 1
		k -= 1

	return _trim_leading_zeros_blocks(result)


func _subtract_block_arrays(a: PackedInt64Array, b: PackedInt64Array) -> PackedInt64Array:
	# Assume a >= b
	var ia: int = a.size() - 1
	var ib: int = b.size() - 1
	var borrow: int = 0

	var result: PackedInt64Array = PackedInt64Array()
	result.resize(a.size())

	for k in range(a.size() - 1, -1, -1):
		var da: int = a[ia]
		var db: int = b[ib] if ib >= 0 else 0
		var d: int = da - db - borrow

		if d < 0:
			d += BASE
			borrow = 1
		else:
			borrow = 0

		result[k] = d
		ia -= 1
		ib -= 1

	return _trim_leading_zeros_blocks(result)


func _multiply_block_arrays(a: PackedInt64Array, b: PackedInt64Array) -> PackedInt64Array:
	a = _trim_leading_zeros_blocks(a)
	b = _trim_leading_zeros_blocks(b)

	if _is_zero_blocks(a) or _is_zero_blocks(b):
		return _make_zero_blocks()

	var result: PackedInt64Array = PackedInt64Array()
	result.resize(a.size() + b.size())

	for i in range(a.size() - 1, -1, -1):
		var carry: int = 0
		for j in range(b.size() - 1, -1, -1):
			var idx: int = i + j + 1
			var sum: int = result[idx] + a[i] * b[j] + carry
			result[idx] = sum % BASE
			carry = sum / BASE

		var pos: int = i
		while carry > 0 and pos >= 0:
			var sum_left: int = result[pos] + carry
			result[pos] = sum_left % BASE
			carry = sum_left / BASE
			pos -= 1

		if carry > 0:
			var expanded: PackedInt64Array = PackedInt64Array()
			expanded.resize(result.size() + 1)
			expanded[0] = carry
			for k in range(result.size()):
				expanded[k + 1] = result[k]
			result = expanded

	return _trim_leading_zeros_blocks(result)


func _multiply_block_array_by_small_digit(a: PackedInt64Array, digit: int) -> PackedInt64Array:
	if digit == 0:
		return _make_zero_blocks()
	if digit == 1:
		return a

	var result: PackedInt64Array = PackedInt64Array()
	result.resize(a.size() + 1)

	var carry: int = 0
	for i in range(a.size() - 1, -1, -1):
		var prod: int = a[i] * digit + carry
		result[i + 1] = prod % BASE
		carry = prod / BASE

	result[0] = carry
	return _trim_leading_zeros_blocks(result)


func _divide_block_arrays(dividend: PackedInt64Array, divisor: PackedInt64Array) -> PackedInt64Array:
	dividend = _trim_leading_zeros_blocks(dividend)
	divisor = _trim_leading_zeros_blocks(divisor)

	if _is_zero_blocks(divisor):
		push_error("Division by zero")
		return _make_zero_blocks()

	if _compare_block_arrays(dividend, divisor) < 0:
		return _make_zero_blocks()

	var quotient: PackedInt64Array = PackedInt64Array()
	quotient.resize(dividend.size())

	var remainder: PackedInt64Array = _make_zero_blocks()

	for i in range(dividend.size()):
		remainder = _append_block(remainder, dividend[i])
		remainder = _trim_leading_zeros_blocks(remainder)

		if _compare_block_arrays(remainder, divisor) < 0:
			quotient[i] = 0
			continue

		var qdigit: int = _estimate_qdigit(remainder, divisor)
		if qdigit < 1:
			qdigit = 1
		elif qdigit >= BASE:
			qdigit = BASE - 1

		var product: PackedInt64Array = _multiply_block_array_by_small_digit(divisor, qdigit)

		while qdigit > 0 and _compare_block_arrays(product, remainder) > 0:
			qdigit -= 1
			if qdigit == 0:
				product = _make_zero_blocks()
				break
			product = _subtract_block_arrays(product, divisor)

		quotient[i] = qdigit

		if qdigit > 0:
			remainder = _subtract_block_arrays(remainder, product)

	return _trim_leading_zeros_blocks(quotient)


func _estimate_qdigit(remainder: PackedInt64Array, divisor: PackedInt64Array) -> int:
	var r0: int = remainder[0]
	var r1: int = 0
	if remainder.size() > 1:
		r1 = remainder[1]

	var d0: int = divisor[0]
	if d0 <= 0:
		return BASE - 1

	var estimate: int = (r0 * BASE + r1) / d0
	if estimate < 0:
		return 0
	if estimate >= BASE:
		return BASE - 1

	return estimate


# ------------------------
# Conversão entre string e blocos
# ------------------------

func _digits_string_to_block_array(text: String) -> PackedInt64Array:
	text = _strip_leading_zeros(text)
	if text == "0":
		return _make_zero_blocks()

	var n: int = text.length()
	var first_chunk: int = n % BASE_DIGITS
	if first_chunk == 0:
		first_chunk = BASE_DIGITS

	var count: int = (n + BASE_DIGITS - 1) / BASE_DIGITS
	var arr: PackedInt64Array = PackedInt64Array()
	arr.resize(count)

	var pos: int = 0
	var idx: int = 0

	while pos < n:
		var chunk_len: int = first_chunk if idx == 0 else BASE_DIGITS
		var value: int = 0

		for j in range(chunk_len):
			value = value * 10 + (text.unicode_at(pos + j) - 48)

		arr[idx] = value
		pos += chunk_len
		idx += 1

	return arr


func _block_array_to_digits_string(arr: PackedInt64Array) -> String:
	arr = _trim_leading_zeros_blocks(arr)
	if _is_zero_blocks(arr):
		return "0"

	var out: String = str(arr[0])

	for i in range(1, arr.size()):
		var chunk: String = str(arr[i])
		var pad: int = BASE_DIGITS - chunk.length()
		if pad > 0:
			out += "0".repeat(pad)
		out += chunk

	return out


func _scaled_digits_blocks(p: NumberParts, target_scale: int) -> PackedInt64Array:
	var extra: int = target_scale - p.scale
	if extra > 0:
		return _digits_string_to_block_array(p.digits + "0".repeat(extra))
	return _digits_string_to_block_array(p.digits)


# ------------------------
# Utilitários de blocos
# ------------------------

func _compare_int_strings(a: String, b: String) -> int:
	a = _strip_leading_zeros(a)
	b = _strip_leading_zeros(b)

	if a.length() > b.length():
		return 1
	if a.length() < b.length():
		return -1

	if a > b:
		return 1
	if a < b:
		return -1

	return 0


func _trim_leading_zeros_blocks(arr: PackedInt64Array) -> PackedInt64Array:
	if arr.size() <= 1:
		return arr

	var i: int = 0
	while i < arr.size() - 1 and arr[i] == 0:
		i += 1

	if i == 0:
		return arr

	var out: PackedInt64Array = PackedInt64Array()
	out.resize(arr.size() - i)

	for j in range(out.size()):
		out[j] = arr[i + j]

	return out


func _is_zero_blocks(arr: PackedInt64Array) -> bool:
	return arr.size() == 1 and arr[0] == 0


func _make_zero_blocks() -> PackedInt64Array:
	var arr: PackedInt64Array = PackedInt64Array()
	arr.resize(1)
	arr[0] = 0
	return arr


func _append_block(arr: PackedInt64Array, block: int) -> PackedInt64Array:
	if _is_zero_blocks(arr):
		if block == 0:
			return arr
		arr[0] = block
		return arr

	var old_size: int = arr.size()
	arr.resize(old_size + 1)
	arr[old_size] = block
	return arr


# ------------------------
# Strings auxiliares
# ------------------------

func _strip_leading_zeros(text: String) -> String:
	if text.is_empty():
		return "0"

	var i: int = 0
	var n: int = text.length()
	while i < n and text.unicode_at(i) == 48:
		i += 1

	if i >= n:
		return "0"

	return text.substr(i)


func _strip_trailing_zeros(text: String) -> String:
	if text.is_empty():
		return ""

	var i: int = text.length() - 1
	while i >= 0 and text.unicode_at(i) == 48:
		i -= 1

	if i < 0:
		return ""

	return text.substr(0, i + 1)


func _repeat_char(ch: String, count: int) -> String:
	if count <= 0:
		return ""
	return ch.repeat(count)
