extends Control


signal letter_selected(key:String)

const AVALIABLE_COLOR : Color = Color(1.0, 1.0, 1.0, 1.0)
const CORRECT_COLOR : Color = Color(0.0, 1.0, 0.0, 1.0)
const INCORRECT_COLOR : Color = Color(1.0, 0.0, 0.0, 1.0)
const UNAVAILABLE_COLOR : Color = Color(0.6, 0.6, 0.6, 1.0)

var letter : String = ""
var size_tween : Tween = null
var color_tween : Tween = null
var state : HangmanHandler.KeyState = HangmanHandler.KeyState.AVALIABLE


# Ready ========================================================================
func _ready() -> void:
	pass


# Configure ====================================================================
func configure(new_letter:String) -> void:
	letter = new_letter
	state = HangmanHandler.KeyState.AVALIABLE
	$Container/Background.modulate = AVALIABLE_COLOR
	$Container/Character.text = letter


# Update the key state/color ---------------------------------------------------
func update_key(new_state:HangmanHandler.KeyState) -> void:
	if state != new_state:
		var target_color : Color = AVALIABLE_COLOR
		state = new_state
		match state:
			HangmanHandler.KeyState.AVALIABLE:
				target_color = AVALIABLE_COLOR
			HangmanHandler.KeyState.UNAVAILABLE:
				target_color = UNAVAILABLE_COLOR
			HangmanHandler.KeyState.CORRECT:
				target_color = CORRECT_COLOR
			HangmanHandler.KeyState.INCORRECT:
				target_color = INCORRECT_COLOR
		if color_tween:
			color_tween.kill()
		color_tween = get_tree().create_tween()
		color_tween.tween_property($Container/Background, 'modulate', target_color, 0.1)


# Signals ======================================================================

# When the mouse enters the key area -------------------------------------------
func _on_container_mouse_entered() -> void:
	if state == HangmanHandler.KeyState.AVALIABLE:
		if size_tween:
			size_tween.kill()
		size_tween = get_tree().create_tween()
		size_tween.tween_property($Container/Background, 'size',Vector2(86, 86), 0.05)
		size_tween.parallel().tween_property($Container/Background, 'position',Vector2(0, 0), 0.05)


# When the mouse exits the key area --------------------------------------------
func _on_container_mouse_exited() -> void:
	if size_tween:
		size_tween.kill()
	size_tween = get_tree().create_tween()
	size_tween.tween_property($Container/Background, 'size',Vector2(82, 82), 0.05)
	size_tween.parallel().tween_property($Container/Background, 'position',Vector2(2, 2), 0.05)


# When the key is pressed ------------------------------------------------------
func _on_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_released('LeftClick') and state == HangmanHandler.KeyState.AVALIABLE:
			letter_selected.emit(self)
