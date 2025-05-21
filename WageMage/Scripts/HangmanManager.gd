extends Node


const KEY : PackedScene = preload('res://Scenes/GUI/Key.tscn')
const LETTER : PackedScene = preload('res://Scenes/GUI/Letter.tscn')
const LETTERS : Array[String] = [
	"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
	"A", "S", "D", "F", "G", "H", "J", "K", "L",
	"Z", "X", "C", "V", "B", "N", "M",
]

var gallows : Control = null
var keys : Array[Control] = []
var keys_line_1 : HBoxContainer = null
var keys_line_2 : HBoxContainer = null
var keys_line_3 : HBoxContainer = null
var letter_list : HBoxContainer = null
var library : Library = null
var state : HangmanHandler.HangmanState = HangmanHandler.HangmanState.SETTING
var word_data : WordData = null
var word : Array[Control] = []


# Ready ========================================================================
func _ready() -> void:
	gallows = get_node('../GameLayer/GameContainer/Gallows')
	gallows.billionaire_died.connect(_on_billionaire_died)
	keys_line_1 = get_node('../GameLayer/GameContainer/Keys/Lines/Line_1')
	keys_line_2 = get_node('../GameLayer/GameContainer/Keys/Lines/Line_2')
	keys_line_3 = get_node('../GameLayer/GameContainer/Keys/Lines/Line_3')
	letter_list = get_node('../GameLayer/GameContainer/Word/Letters')
	library = Library.new()
	configure()
	await get_tree().create_timer(0.5).timeout
	var letter_counter : int = 0
	for letter in word:
		letter.wave(letter_counter * 0.1)
		letter_counter += 1


# Configure ====================================================================
func configure() -> void:
	configure_keyboard()
	configure_word()
	configure_gallows()
	state = HangmanHandler.HangmanState.PLAYING


# Match the selected key with the letter ---------------------------------------
func match_letter(selected_key:Control) -> void:
	var is_correct : bool = false
	var letter_counter : int = 0
	var correct_counter : int = 0
	word_data.remove_variant(selected_key.letter)
	for letter in word_data.fixed:
		if letter == selected_key.letter:
			is_correct = true
			word[letter_counter].set_letter(letter, HangmanHandler.LetterType.CORRECT, correct_counter * 0.1)
			correct_counter += 1
		letter_counter += 1
	selected_key.update_key(HangmanHandler.KeyState.CORRECT if is_correct else HangmanHandler.KeyState.INCORRECT)
	if not is_correct:
		gallows.wrong_guess()


# Configure gallows --------------------------------------------------------
func configure_gallows() -> void:
	gallows.configure(library.load_billionaire_data())


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
		keys.append(new_key)
		counter += 1


# Configure the word to guess --------------------------------------------------
func configure_word() -> void:
	word_data = library.load_word_data("pt")
	var counter : int = 0
	while counter < 4:
		var new_letter : Node = LETTER.instantiate()
		new_letter.configure()
		letter_list.add_child(new_letter)
		word.append(new_letter)
		counter += 1


# Signals ======================================================================

# When the letter is selected --------------------------------------------------
func _on_letter_selected(selected_key:Control) -> void:
	match_letter(selected_key)


# When the billionaire dies ----------------------------------------------------
func _on_billionaire_died() -> void:
	state = HangmanHandler.HangmanState.RESULT
	var correct_word : String = word_data.get_correct_word()
	var letter_counter : int = 0
	var incorrect_counter : int = 0
	for letter in word:
		if not letter.current_letter == correct_word[letter_counter]:
			letter.set_letter(correct_word[letter_counter], HangmanHandler.LetterType.INCORRECT, incorrect_counter * 0.2)
			incorrect_counter += 1
		letter_counter += 1
	for key in keys:
		if key.state == HangmanHandler.KeyState.AVALIABLE:
			key.update_key(HangmanHandler.KeyState.UNAVAILABLE)
