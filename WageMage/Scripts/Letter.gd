extends Control


# Ready ========================================================================
func _ready() -> void:
	pass


# Configure ====================================================================
func configure() -> void:
	$Character.text = ""


# Set letter -------------------------------------------------------------------
func set_letter(new_letter:String, letter_type:HangmanHandler.LetterType) -> void:
	$Character.text = new_letter
	match letter_type:
		HangmanHandler.LetterType.CORRECT:
			$Character.set("theme_override_colors/font_color", Color(1.0, 1.0, 1.0, 1.0))
		HangmanHandler.LetterType.INCORRECT:
			$Character.set("theme_override_colors/font_color", Color(1.0, 0.0, 0.0, 1.0))
