extends Node2D


func _init() -> void:
    print("bugbaya")

func _ready() -> void:
    await get_tree().create_timer(3.0).timeout
    GameManager.change_scene(OptionsHandler.SceneScreen.HANGMAN_SCREEN)