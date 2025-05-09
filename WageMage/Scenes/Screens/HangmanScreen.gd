extends Node2D


# Ready ========================================================================
func _ready() -> void:
    GameManager.finish_loading(OptionsHandler.GameState.HANGMAN)