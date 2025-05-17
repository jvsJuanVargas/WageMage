extends Node2D


# Ready ========================================================================
func _ready() -> void:
	$GameLayer/GameContainer/Keys/Background.visible = false
	$GameLayer/GameContainer/Word/Background.visible = false
	GameManager.finish_loading(OptionsHandler.GameState.HANGMAN)
