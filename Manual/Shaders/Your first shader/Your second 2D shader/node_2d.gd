extends Node2D


var params = {}
var labels = {}
var effects = [
	"frequency",
	"amplitude",
	"speed",
	"falloff_strength",
	"highlight_intensity",
	"highlight_sharpness",
	"threshold",
	"rgb_offset",
	"pixel_size",
	"scanline_frequency",
	"outline_thickness",
]

@onready var sprite1 := $Image1
@onready var sprite2 := $Image2
@onready var sprite3 := $Image3
@onready var sprite4 := $Image4
@onready var frequency := $HUD/Parameters/Frequency
@onready var frequency_label := $HUD/Parameters/FrequencyLabel
@onready var amplitude := $HUD/Parameters/Amplitude
@onready var amplitude_label := $HUD/Parameters/AmplitudeLabel
@onready var speed := $HUD/Parameters/Speed
@onready var speed_label := $HUD/Parameters/SpeedLabel
@onready var falloff_strength := $HUD/Parameters/FalloffStrength
@onready var falloff_strength_label := $HUD/Parameters/FalloffStrengthLabel
@onready var highlight_intensity := $HUD/Parameters/HighlightIntensity
@onready var highlight_intensity_label := $HUD/Parameters/HighlightIntensityLabel
@onready var highlight_sharpness := $HUD/Parameters/HighlightSharpness
@onready var highlight_sharpness_label := $HUD/Parameters/HighlightSharpnessLabel
@onready var threshold := $HUD/Parameters/Threshold
@onready var threshold_label := $HUD/Parameters/ThresholdLabel
@onready var rgb_offset := $HUD/Parameters/RGBOffset
@onready var rgb_offset_label := $HUD/Parameters/RGBOffsetLabel
@onready var pixel_size := $HUD/Parameters/PixelSize
@onready var pixel_size_label := $HUD/Parameters/PixelSizeLabel
@onready var scanline_frequency := $HUD/Parameters/ScanlineFrequency
@onready var scanline_frequency_label := $HUD/Parameters/ScanlineFrequencyLabel
@onready var outline_thickness := $HUD/Parameters/OutlineThickness
@onready var outline_thickness_label := $HUD/Parameters/OutlineThicknessLabel

func _ready() -> void:
	frequency_label.text = "Frequency " + str(frequency.value)
	amplitude_label.text = "Amplitude " + str(amplitude.value)
	speed_label.text = "Speed " + str(speed.value)
	falloff_strength_label.text = "Falloff Strength " + str(falloff_strength.value)
	highlight_intensity_label.text = "Highlight Intensity " + str(highlight_intensity.value)
	threshold_label.text = "Threshold " + str(threshold.value)
	rgb_offset_label.text = "RGB Offset " + str(rgb_offset.value)
	pixel_size_label.text = "Pixel Size " + str(pixel_size.value)
	scanline_frequency_label.text = "Scanline Frequency " + str(scanline_frequency.value)
	outline_thickness_label.text = "Outline Thickness " + str(outline_thickness.value)
	
	params = {
		"frequency": frequency,
		"amplitude": amplitude,
		"speed": speed,
		"falloff_strength": falloff_strength,
		"highlight_intensity": highlight_intensity,
		"highlight_sharpness": highlight_sharpness,
		"threshold": threshold,
		"rgb_offset": rgb_offset,
		"pixel_size": pixel_size,
		"scanline_frequency": scanline_frequency,
		"outline_thickness": outline_thickness,
	}
	
	labels = {
		"frequency": frequency_label,
		"amplitude": amplitude_label,
		"speed": speed_label,
		"falloff_strength": falloff_strength_label,
		"highlight_intensity": highlight_intensity_label,
		"highlight_sharpness": highlight_sharpness_label,
		"threshold": threshold_label,
		"rgb_offset": rgb_offset_label,
		"pixel_size": pixel_size_label,
		"scanline_frequency": scanline_frequency_label,
		"outline_thickness": outline_thickness_label,
	}
	
	sprite1.show()
	sprite2.hide()
	sprite3.hide()
	sprite4.hide()
	item_hide()

func item_hide():
	for effect in effects:
		params[effect].modulate.a = 0.2
		labels[effect].modulate.a = 0.2

func item_visibility(effects_to_show):
	for effect in effects:
		if effect in effects_to_show:
			params[effect].modulate.a = 1.0
			labels[effect].modulate.a = 1.0

func _on_option_button_item_selected(index: int) -> void:
	item_hide()
	_apply_shader("effect", index)
	var option = $HUD/OptionButton.get_item_text(index)
	
	if option in ["Waves", "Ripple", "Shiny Water", "Glitch", "Heat Distortion"]:
		item_visibility(["frequency", "amplitude", "speed"])
	if option in ["Shiny Water"]:
		item_visibility(["falloff_strength", "highlight_intensity", "highlight_sharpness"])
	if option in ["Glitch"]:
		item_visibility(["threshold"])
	if option in ["RGB Split"]:
		item_visibility(["rgb_offset"])
	if option in ["Pixelation"]:
		item_visibility(["pixel_size"])
	if option in ["Scanlines (CRT)"]:
		item_visibility(["scanline_frequency"])
	if option in ["Outline"]:
		item_visibility(["outline_thickness"])
	if option in ["Zoom Pulse"]:
		item_visibility(["amplitude", "speed"])
	if option in ["Mask"]:
		item_visibility(["frequency", "speed"])

func _on_frequency_value_changed(value: float) -> void:
	frequency_label.text = "Frequency " + str(value)
	_apply_shader("frequency", value)

func _on_amplidute_value_changed(value: float) -> void:
	amplitude_label.text = "Amplitude " + str(value)
	_apply_shader("amplitude", value)

func _on_speed_value_changed(value: float) -> void:
	speed_label.text = "Speed " + str(value)
	_apply_shader("speed", value)

func _on_falloff_strength_value_changed(value: float) -> void:
	falloff_strength_label.text = "Falloff Strength " + str(value)
	_apply_shader("falloff_strength", value)

func _on_highlight_intensity_value_changed(value: float) -> void:
	highlight_intensity_label.text = "Highlight Intensity " + str(value)
	_apply_shader("highlight_intensity", value)

func _on_highlight_sharpness_value_changed(value: float) -> void:
	highlight_sharpness_label.text = "Highlight Sharpness " + str(value)
	_apply_shader("highlight_sharpness", value)

func _on_threshold_value_changed(value: float) -> void:
	threshold_label.text = "Threshold " + str(value)
	_apply_shader("threshold", value)

func _on_rgb_offset_value_changed(value: float) -> void:
	rgb_offset_label.text = "RGB Offset " + str(value)
	_apply_shader("rgb_offset", value)

func _on_pixel_size_value_changed(value: float) -> void:
	pixel_size_label.text = "Pixel Size " + str(value)
	_apply_shader("pixel_size", value)

func _on_scanline_frequency_value_changed(value: float) -> void:
	scanline_frequency_label.text = "Scanline Frequency " + str(value)
	_apply_shader("scanline_frequency", value)

func _on_outline_thickness_value_changed(value: float) -> void:
	outline_thickness_label.text = "Outline Thickness " + str(value)
	_apply_shader("outline_thickness", value)

func _apply_shader(effect, value):
	for sprite in [sprite1, sprite2, sprite3]:
		sprite.material.set_shader_parameter(effect, value)

func _on_image_1_pressed() -> void:
	sprite1.show()
	sprite2.hide()
	sprite3.hide()
	sprite4.hide()

func _on_image_2_pressed() -> void:
	sprite1.hide()
	sprite2.show()
	sprite3.hide()
	sprite4.hide()

func _on_image_3_pressed() -> void:
	sprite1.hide()
	sprite2.hide()
	sprite3.show()
	sprite4.hide()

func _on_image_4_pressed() -> void:
	sprite1.hide()
	sprite2.hide()
	sprite3.hide()
	sprite4.show()
