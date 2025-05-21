extends Control


signal billionaire_died()

const BODY_PART : PackedScene = preload('res://Scenes/GUI/BodyPart.tscn')

var attempts : int = 6
var body : Control = null
var parts : Array[Control] = []


# Ready ========================================================================
func _ready() -> void:
	attempts = 0


# Configure ====================================================================
func configure(_billionaire_data:BillionaireData) -> void:
	parts.clear()
	parts.append($Body/Head)
	parts.append($Body/Trunk)
	parts.append($Body/LeftArm)
	parts.append($Body/RightArm)
	parts.append($Body/LeftLeg)
	parts.append($Body/RightLeg)
	for part in parts:
		part.configure()


# wrong gess -------------------------------------------------------------------
func wrong_guess() -> void:
	parts[attempts].show_part()
	attempts += 1
	if attempts >= parts.size():
		billionaire_died.emit()
