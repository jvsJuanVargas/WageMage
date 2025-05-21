extends Control


var current_letter : String = ""


# Ready ========================================================================
func _ready() -> void:
	pass


# Configure ====================================================================
func configure() -> void:
	current_letter = ""
	$Character.text = current_letter


# Wave -------------------------------------------------------------------------
func wave(delay:float) -> void:
	await get_tree().create_timer(delay).timeout
	$Animation.play('Start')


# Set letter -------------------------------------------------------------------
func set_letter(new_letter:String, letter_type:HangmanHandler.LetterType, delay:float) -> void:
	current_letter = new_letter
	$Character.text = current_letter
	await get_tree().create_timer(delay).timeout
	match letter_type:
		HangmanHandler.LetterType.CORRECT:
			$Character.set("theme_override_colors/font_color", Color(1.0, 1.0, 1.0, 1.0))
			$Animation.play('Correct')
		HangmanHandler.LetterType.INCORRECT:
			$Character.set("theme_override_colors/font_color", Color(1.0, 0.0, 0.0, 1.0))
			$Animation.play('Incorrect')
