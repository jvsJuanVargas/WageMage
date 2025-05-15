extends Control


signal letter_selected(letter:String)


const AVALIABLE_COLOR : Color = Color(1, 1, 1, 1)
const CORRECT_COLOR : Color = Color(0, 1, 0, 1)
const INCORRECT_COLOR : Color = Color(1, 0, 0, 1)


var letter: String = ""
var is_selected: bool = false
var size_tween: Tween = null
var color_tween: Tween = null


# Configure ====================================================================
func configure(new_letter:String) -> void:
	letter = new_letter
	is_selected = false
	$Container/Background.modulate = AVALIABLE_COLOR
	$Container/Letter.text = letter


# Signals ======================================================================

# When the mouse enters the key area -------------------------------------------
func _on_container_mouse_entered() -> void:
	print("Mouse entered key %s area" % [letter])
	if size_tween:
		size_tween.kill()
	size_tween = get_tree().create_tween()
	size_tween.tween_property($Container/Background, 'size',Vector2(86, 86), 0.05)
	size_tween.parallel().tween_property($Container/Background, 'position',Vector2(0, 0), 0.05)


# When the mouse exits the key area --------------------------------------------
func _on_container_mouse_exited() -> void:
	print("Mouse exited key %s area" % [letter])
	if size_tween:
		size_tween.kill()
	size_tween = get_tree().create_tween()
	size_tween.tween_property($Container/Background, 'size',Vector2(82, 82), 0.05)
	size_tween.parallel().tween_property($Container/Background, 'position',Vector2(2, 2), 0.05)


# When the key is pressed ------------------------------------------------------
func _on_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_released('LeftClick') and not is_selected:
			if color_tween:
				color_tween.kill()
			is_selected = true
			letter_selected.emit(letter)
			print("Key %s pressed" % [letter])
			color_tween = get_tree().create_tween()
			color_tween.tween_property($Container/Background, 'modulate', CORRECT_COLOR, 0.1)
