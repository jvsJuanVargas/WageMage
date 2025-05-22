extends Control


@export var body_part : HangmanHandler.BodyPart = HangmanHandler.BodyPart.HEAD


# Ready ========================================================================
func _ready() -> void:
	pass


# Configure ====================================================================
func configure(billionaire_data:BillionaireData) -> void:
	$Background.visible = false
	match body_part:
		HangmanHandler.BodyPart.HEAD:
			$Sprite.texture = billionaire_data.head
			$Sprite.position = Vector2(143, 143)
			$Sprite.flip_h = false
		HangmanHandler.BodyPart.TRUNK:
			$Sprite.texture = billionaire_data.trunk
			$Sprite.position = Vector2(112, 112)
			$Sprite.flip_h = false
		HangmanHandler.BodyPart.LEFT_ARM:
			$Sprite.texture = billionaire_data.arm
			$Sprite.position = Vector2(80, 80)
			$Sprite.flip_h = false
		HangmanHandler.BodyPart.RIGHT_ARM:
			$Sprite.texture = billionaire_data.arm
			$Sprite.position = Vector2(80, 80)
			$Sprite.flip_h = true
		HangmanHandler.BodyPart.LEFT_LEG:
			$Sprite.texture = billionaire_data.leg
			$Sprite.position = Vector2(80, 80)
			$Sprite.flip_h = false
		HangmanHandler.BodyPart.RIGHT_LEG:
			$Sprite.texture = billionaire_data.leg
			$Sprite.position = Vector2(80, 80)
			$Sprite.flip_h = true
	visible = false


# Show part --------------------------------------------------------------------
func show_part() -> void:
	visible = true
