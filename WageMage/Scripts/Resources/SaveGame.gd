class_name SaveGame


# [!!!TODO] Fazer o salvamento/carregamento acontecer em parelelo ao jogo usando threads.
# [!!!TODO] Mudar o nome de SaveGame para SaveLoad.


const SAVE_DIRECTORY : String = 'user://savegame'
const GAME_FILE_NANE : String = 'game.save'
const PLAYTHROUGH_FILE_NAME : String = 'playthrough.save'
const SECURITY_KEY : String = '84RK477H3M00N'


# Ready ========================================================================
func _ready() -> void:
	verify_save_directory(SAVE_DIRECTORY)


# Configurations ===============================================================

# Verify save directory --------------------------------------------------------
func verify_save_directory(path:String) -> void:
	DirAccess.make_dir_absolute(path)


# Load =========================================================================

# Load game data ---------------------------------------------------------------
func load_game_data() -> GameData:
	var loaded_data : Dictionary =  load_data("%s%s" % [SAVE_DIRECTORY, GAME_FILE_NANE])
	var game_data : GameData = GameData.new(loaded_data)
	return game_data


# Load playthrough data --------------------------------------------------------
func load_playthrough_data(playthrough_slot:OptionsHandler.PlaythroughSlot) -> PlaythroughData:
	var loaded_data : Dictionary = load_data("%s%s" % [SAVE_DIRECTORY, PLAYTHROUGH_FILE_NAME])
	var slot_key : String = "%d" % [playthrough_slot]
	var playthrough_data : PlaythroughData = PlaythroughData.new(loaded_data[slot_key] if loaded_data.has(slot_key) else {})
	return playthrough_data


# Load data --------------------------------------------------------------------
func load_data(path:String) -> Dictionary:
	var data : Dictionary = {}
	if FileAccess.file_exists(path):
		var save_file : FileAccess = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if not save_file:
			printerr(FileAccess.get_open_error())
		else:
			var content : String = save_file.get_as_text()
			save_file.close()
			data = JSON.parse_string(content)
			if not data:
				printerr("Cannot parse %s as a json_string: (%s)" % [path, content])
	else:
		printerr("Cannot open non-existent file at %s!" % [path])
	return data


# Save =========================================================================

# Save game data ---------------------------------------------------------------
func save_game_data(data:Dictionary) -> bool:
	return save_data("%s%s" % [SAVE_DIRECTORY, GAME_FILE_NANE], data)


# Save playthrough data --------------------------------------------------------
func save_playthrough_data(playthrough_slot:OptionsHandler.PlaythroughSlot, slot_data:Dictionary) -> bool:
	var loaded_data : Dictionary = load_data("%s%s" % [SAVE_DIRECTORY, PLAYTHROUGH_FILE_NAME])
	var data : Dictionary = {}
	var slot_key : String = ""
	for slot : int in OptionsHandler.PlaythroughSlot.values():
		slot_key = "%d" % [slot]
		if slot == playthrough_slot:
			data[slot_key] = slot_data
		else:
			data[slot_key] = loaded_data[slot_key] if loaded_data.has(slot_key) else {}
	return save_data("%s%s" % [SAVE_DIRECTORY, PLAYTHROUGH_FILE_NAME], data)


# Save data --------------------------------------------------------------------
func save_data(path:String, data:Dictionary) -> bool:
	var success : bool = true
	var save_file : FileAccess = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if save_file == null:
		success = false
		printerr(FileAccess.get_open_error())
	else:
		var content : String = JSON.stringify(data, "\t")
		save_file.store_string(content)
		save_file.close()
	return success
