extends Control


@export var body_part : HangmanHandler.BodyPart = HangmanHandler.BodyPart.HEAD


# Ready ========================================================================
func _ready() -> void:
	pass


# Configure ====================================================================
func configure() -> void:
	match body_part:
		HangmanHandler.BodyPart.HEAD:
			pass
		HangmanHandler.BodyPart.TRUNK:
			pass
		HangmanHandler.BodyPart.LEFT_ARM:
			pass
		HangmanHandler.BodyPart.RIGHT_ARM:
			pass
		HangmanHandler.BodyPart.LEFT_LEG:
			pass
		HangmanHandler.BodyPart.RIGHT_LEG:
			pass
	visible = false


# Show part --------------------------------------------------------------------
func show_part() -> void:
	visible = true
