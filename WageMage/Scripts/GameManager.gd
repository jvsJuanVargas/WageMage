extends Node


# ==============================================================================
# ============================ Wage Mage Project ===============================
# ==============================================================================
# 
#  ██╗    ██╗ █████╗  ██████╗ ███████╗    ███╗   ███╗ █████╗  ██████╗ ███████╗
#  ██║    ██║██╔══██╗██╔════╝ ██╔════╝    ████╗ ████║██╔══██╗██╔════╝ ██╔════╝
#  ██║ █╗ ██║███████║██║  ███╗█████╗      ██╔████╔██║███████║██║  ███╗█████╗  
#  ██║███╗██║██╔══██║██║   ██║██╔══╝      ██║╚██╔╝██║██╔══██║██║   ██║██╔══╝  
#  ╚███╔███╔╝██║  ██║╚██████╔╝███████╗    ██║ ╚═╝ ██║██║  ██║╚██████╔╝███████╗
#   ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
# 
# === by Juan Vargas and Flávio Henkes =========================================


# [!!!TODO] Criação do arquivo de localização do jogo (Data/Localization.csv)


signal input_device_changed(input_type:OptionsHandler.InputType)
signal resolution_changed(new_resolution:OptionsHandler.Resolution)
signal locale_changed(new_locale:OptionsHandler.Locale)


const KONAMI_CODE_JOYPAD : Array[String] = ['DirectionUp', 'DirectionUp', 'DirectionDown', 'DirectionDown', 'DirectionLeft', 'DirectionRight', 'DirectionLeft', 'DirectionRight', 'Cancel', 'Confirm', 'Start']
const KONAMI_CODE_KEYBOARD : Array[Key] = [KEY_UP, KEY_UP, KEY_DOWN, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_LEFT, KEY_RIGHT, KEY_B, KEY_A, KEY_ENTER]


var save_load : SaveGame = SaveGame.new()
var game_data : GameData
var playthrough_data : PlaythroughData
var table_path_list : Array[String] = []
var table_path_list_index : int = 0

var input_device_name : String = ''
var input_type : OptionsHandler.InputType = OptionsHandler.InputType.KEYBOARD_AND_MOUSE
var state : OptionsHandler.GameState = OptionsHandler.GameState.INTRO

var konami_code_activated : bool = false
var konami_code_index : int = 0


# Init =========================================================================
func _init() -> void:
	pass


# Ready ========================================================================
func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	start_up()
	if OS.is_debug_build():
		print("Debug Mode")


# Process ======================================================================
func _process(_delta:float) -> void:
	pass


# Physics process ==============================================================
func _physics_process(_delta:float) -> void:
	pass


# Input ========================================================================
func _input(event:InputEvent) -> void:

	# Check which type of input is being used and update the button layout if it differs
	if event is InputEvent and event.is_pressed():
		if event is InputEventJoypadButton:
			if input_device_name != Input.get_joy_name(Input.get_connected_joypads()[event.device]):
				change_input_device_joystick(Input.get_joy_name(Input.get_connected_joypads()[event.device]))
		elif event is InputEventKey or event is InputEventMouseButton:
			if input_device_name != 'Keyboard and mouse':
				change_input_device_to_keyboard_and_mouse()

	# Konami Code
	if event is InputEvent and event.is_pressed():
		if input_type == OptionsHandler.InputType.KEYBOARD_AND_MOUSE:
			if event is InputEventKey:
				if KONAMI_CODE_KEYBOARD[konami_code_index] == event.keycode:
					konami_code_index += 1
				else:
					konami_code_index = 0
		else:
			if event is InputEventJoypadButton:
				if event.is_action_pressed(KONAMI_CODE_JOYPAD[konami_code_index]):
					konami_code_index += 1
				else:
					konami_code_index = 0
		if konami_code_index >= KONAMI_CODE_KEYBOARD.size():
			konami_code_activated = not konami_code_activated
			konami_code_index = 0
			print_rich("[color=%s]Konami Code %s[/color]" % ["#00ff00" if konami_code_activated else "#ff0000", "ativado" if konami_code_activated else "desativado"])

	# Button actions
	if event is InputEventKey or event is InputEventJoypadButton:
		if event.is_action_pressed('ToggleFullScreen'):
			toggle_fullscreen()
		if event.is_action_pressed('ToggleOptions'):
			toggle_options_menu()

	# Debug actions
	if event is InputEventKey:

		# Teste de save / load
		if not event.pressed and event.keycode == KEY_S:
			save_game()
			save_playthrough(game_data.current_playthough_slot)
			print("Informação guardada")
		if not event.pressed and event.keycode == KEY_L:
			load_game()
			load_playthrough(game_data.current_playthough_slot)
			print("Informação carregada")
		
		# Reload current scene
		if not event.pressed and event.keycode == KEY_F5:
			change_scene(OptionsHandler.SceneScreen.HANGMAN_SCREEN)


# Settings =====================================================================

# Screen settings ==============================================================

# Toggle full screen -----------------------------------------------------------
func toggle_fullscreen() -> void:
	change_fullscreen(not game_data.fullscreen)


# Toggle options menu ----------------------------------------------------------
func toggle_options_menu() -> void:
	pass


# Change full screen -----------------------------------------------------------
func change_fullscreen(is_fullscreen:bool) -> void:
	game_data.fullscreen = is_fullscreen
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)


# Change aspect ratio ----------------------------------------------------------
func change_aspect_ratio(new_aspect_ratio:OptionsHandler.AspectRatio) -> void:
	game_data.aspect_ratio = new_aspect_ratio


# Change resolution ------------------------------------------------------------
func change_resolution(new_resolution:OptionsHandler.Resolution) -> void:
	var resolution_data : Dictionary = OptionsHandler.get_resolution_data(new_resolution)
	game_data.aspect_ratio = resolution_data['aspect_ratio']
	game_data.resolution = new_resolution
	DisplayServer.window_set_size(resolution_data['resolution'])
	resolution_changed.emit(resolution_data['resolution'])


# Change locale ----------------------------------------------------------------
func change_locale(new_locale:OptionsHandler.Locale) -> void:
	game_data.locale = new_locale
	TranslationServer.set_locale(OptionsHandler.get_locale_code(game_data.locale))
	locale_changed.emit(new_locale)


# Input settings ===============================================================

# Change input device to some joystick type ------------------------------------
# Godot uses the SDL2 game controller database to determine gamepad names https://github.com/mdqinc/SDL_GameControllerDB
func change_input_device_joystick(new_input_device_name:String) -> void:
	if input_device_name != new_input_device_name:
		input_device_name = new_input_device_name
		var target_input_type : OptionsHandler.InputType = OptionsHandler.InputType.XBOX_360_CONTROLLER
		if input_device_name.find('PS4') != -1:
			target_input_type = OptionsHandler.InputType.PLAYSTATION_4_CONTOLLER
		elif input_device_name.find('PS5') != -1:
			target_input_type = OptionsHandler.InputType.PLAYSTATION_5_CONTOLLER
		elif input_device_name.find('Xbox 360') != -1:
			target_input_type = OptionsHandler.InputType.XBOX_360_CONTROLLER
		elif input_device_name.find('Xbox One') != -1:
			target_input_type = OptionsHandler.InputType.XBOX_ONE_SERIES_CONTROLLER
		elif input_device_name.find('Xbox Series') != -1:
			target_input_type = OptionsHandler.InputType.XBOX_ONE_SERIES_CONTROLLER
		else:
			target_input_type = OptionsHandler.InputType.XBOX_360_CONTROLLER

		if input_type != target_input_type:
			input_type = target_input_type
			input_device_changed.emit(input_type)
		print(input_device_name)


# Change input device to the mouse and keyboard --------------------------------
func change_input_device_to_keyboard_and_mouse() -> void:
	if input_device_name != 'Keyboard and mouse':
		input_device_name = 'Keyboard and mouse'
		input_type = OptionsHandler.InputType.KEYBOARD_AND_MOUSE
		input_device_changed.emit(input_type)
		print(input_device_name)


# Tools ========================================================================

# Start up ---------------------------------------------------------------------
func start_up() -> void:
	load_game()
	change_fullscreen(game_data.fullscreen)
	change_locale(game_data.locale)

	state = OptionsHandler.GameState.INTRO

	# [!!!TODO] Remover o carregamento do playthrough dessa parte. Precisa ser carregado a partir do menu principal.
	load_playthrough(game_data.current_playthough_slot)


# Scenes management ============================================================

# Change scene -----------------------------------------------------------------
# [!!!TODO] Quando não for uma batalha, limpar os dados da batalha (talvez dar um = null ou qeue_free ou o que for melhor)
func change_scene(scene_screen:OptionsHandler.SceneScreen) -> void:
	var path_to_new_scene : String
	state = OptionsHandler.GameState.LOADING
	SceneManager.open_loading_screen()
	await SceneManager.screen_animation.animation_finished
	match scene_screen:
		OptionsHandler.SceneScreen.INTRO_SCREEN:
			path_to_new_scene = 'res://Scenes/Screens/IntroScreen.tscn'
		OptionsHandler.SceneScreen.TITLE_SCREEN:
			path_to_new_scene = 'res://Scenes/Screens/TitleScreen.tscn'
		OptionsHandler.SceneScreen.HANGMAN_SCREEN:
			path_to_new_scene = 'res://Scenes/Screens/HangmanScreen.tscn'
	SceneManager.change_scene(path_to_new_scene)


# It's time to start -----------------------------------------------------------
func time_to_start() -> void:
	change_scene(OptionsHandler.SceneScreen.TITLE_SCREEN)


# Finish loading ---------------------------------------------------------------
func finish_loading(new_state:OptionsHandler.GameState) -> void:
	SceneManager.close_loading_screen()
	await SceneManager.screen_animation.animation_finished
	if state != new_state:
		state = new_state


# Save / Load data =============================================================

# Load game --------------------------------------------------------------------
func load_game() -> void:
	game_data = save_load.load_game_data()


# Load playthrough -------------------------------------------------------------
func load_playthrough(playthrough_slot:OptionsHandler.PlaythroughSlot) -> void:
	playthrough_data = save_load.load_playthrough_data(playthrough_slot)


# Save game --------------------------------------------------------------------
func save_game() -> void:
	var _success : bool = save_load.save_game_data(game_data.get_data())


# Save playthrough -------------------------------------------------------------
func save_playthrough(playthrough_slot:OptionsHandler.PlaythroughSlot) -> void:
	var _success : bool = save_load.save_playthrough_data(playthrough_slot, playthrough_data.get_data())


# Signals ======================================================================

# When the joy connection is changed -------------------------------------------
func _on_joy_connection_changed(device_id:int, connected:bool) -> void:
	if connected:
		change_input_device_joystick(Input.get_joy_name(Input.get_connected_joypads()[device_id]))
	else:
		change_input_device_to_keyboard_and_mouse()
