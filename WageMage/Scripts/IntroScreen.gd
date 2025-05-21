extends Node2D


# Ready ========================================================================
func _ready() -> void:
	# await get_tree().create_timer(3.0).timeout
	GameManager.change_scene(OptionsHandler.SceneScreen.HANGMAN_SCREEN)
