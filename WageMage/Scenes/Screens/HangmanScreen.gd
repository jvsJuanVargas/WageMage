extends Node2D

const KEY : PackedScene = preload("res://Scenes/GUI/Key.tscn")
const LETTERS : Array[String] = [
	"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
	"A", "S", "D", "F", "G", "H", "J", "K", "L",
	"Z", "X", "C", "V", "B", "N", "M",
]

var keys_line_1 : HBoxContainer
var keys_line_2 : HBoxContainer
var keys_line_3 : HBoxContainer = null


# Ready ========================================================================
func _ready() -> void:
	GameManager.finish_loading(OptionsHandler.GameState.HANGMAN)
	keys_line_1 = $GameLayer/GameContainer/Keys/Lines/Line_1
	keys_line_2 = $GameLayer/GameContainer/Keys/Lines/Line_2
	keys_line_3 = $GameLayer/GameContainer/Keys/Lines/Line_3
	$GameLayer/GameContainer/Keys/BackgroundColor.visible = false
	configure()


# Configure ====================================================================
func configure() -> void:
	var counter : int = 0
	for letter in LETTERS:
		var key : Node = KEY.instantiate()
		key.configure(letter)
		if counter < 10:
			keys_line_1.add_child(key)
		elif counter < 19:
			keys_line_2.add_child(key)
		else:
			keys_line_3.add_child(key)
		counter += 1
