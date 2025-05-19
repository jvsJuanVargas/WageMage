extends Control


signal billionaire_died()

var attempts : int = 6


# Ready ========================================================================
func _ready() -> void:
	attempts = 6
	$Attempts.text = "%s" % [attempts]


# Configure ====================================================================
func configure() -> void:
	$Background.visible = false


# wrong gess -------------------------------------------------------------------
func wrong_guess() -> void:
	attempts -= 1
	$Attempts.text = "%s" % [attempts]
	if attempts == 0:
		billionaire_died.emit()
