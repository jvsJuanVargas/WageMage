extends Node


const KEY : PackedScene = preload("res://Scenes/GUI/Key.tscn")
const LETTER : PackedScene = preload("res://Scenes/GUI/Letter.tscn")
const LETTERS : Array[String] = [
	"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
	"A", "S", "D", "F", "G", "H", "J", "K", "L",
	"Z", "X", "C", "V", "B", "N", "M",
]
const WORDS_ANIMALS : Array[String] = [
	"VACA", "GATA", "PATA", "RATA", "NAJA", "PACA", "LAMA",
]


var keys_line_1 : HBoxContainer = null
var keys_line_2 : HBoxContainer = null
var keys_line_3 : HBoxContainer = null
var letter_list : HBoxContainer = null
var words : Array[String] = []


# Ready ========================================================================
func _ready() -> void:
	keys_line_1 = get_node('../GameLayer/GameContainer/Keys/Lines/Line_1')
	keys_line_2 = get_node('../GameLayer/GameContainer/Keys/Lines/Line_2')
	keys_line_3 = get_node('../GameLayer/GameContainer/Keys/Lines/Line_3')
	letter_list = get_node('../GameLayer/GameContainer/Word/Letters')
	configure()


# Configure ====================================================================
func configure() -> void:
	configure_keyboard()
	configure_word()


# Match the selected key with the letter ---------------------------------------
func match_letter(selected_key:Control) -> void:
	selected_key.update_key(selected_key.letter == "A")


# Configure the keyboard keys --------------------------------------------------
func configure_keyboard() -> void:
	var counter : int = 0
	for letter in LETTERS:
		var new_key : Node = KEY.instantiate()
		new_key.configure(letter)
		new_key.letter_selected.connect(_on_letter_selected)
		if counter < 10:
			keys_line_1.add_child(new_key)
		elif counter < 19:
			keys_line_2.add_child(new_key)
		else:
			keys_line_3.add_child(new_key)
		counter += 1


# Configure the word to guess --------------------------------------------------
func configure_word() -> void:
	words = WORDS_ANIMALS.duplicate()
	print(words)
	var counter : int = 0
	while counter < 4:
		var new_letter : Node = LETTER.instantiate()
		new_letter.configure()
		letter_list.add_child(new_letter)
		counter += 1


# Signals ======================================================================

func _on_letter_selected(selected_key:Control) -> void:
	match_letter(selected_key)
