class_name GameData
extends Resource


# Options
var aspect_ratio : OptionsHandler.AspectRatio = OptionsHandler.AspectRatio.ASPECT_RATIO_16_9
var fullscreen : bool = false
var locale : OptionsHandler.Locale = OptionsHandler.get_os_locale()
var resolution : OptionsHandler.Resolution = OptionsHandler.Resolution.RESOLUTION_960_540
var volume_master : float = 1.0
var volume_music : float = 0.8
var volume_ambience : float = 0.8
var volume_voice : float = 1.0
var volume_sfx : float = 0.8
var volume_gui : float = 0.6

# Playthrough
var current_playthough_slot : OptionsHandler.PlaythroughSlot = OptionsHandler.PlaythroughSlot.SLOT_1

# Statistics
var defeats : int = 0
var draws : int = 0
var victories : int = 0


# Init =========================================================================
func _init(data:Dictionary) -> void:
	set_data(data)


# Data =========================================================================

# Get data ---------------------------------------------------------------------
func get_data() -> Dictionary:
	return {
		'aspect_ratio': aspect_ratio,
		'fullscreen': fullscreen,
		'locale': locale,
		'resolution': resolution,
		'current_playthough_slot': current_playthough_slot,
		'volume_master': volume_master,
		'volume_music': volume_music,
		'volume_ambience': volume_ambience,
		'volume_voice': volume_voice,
		'volume_sfx': volume_sfx,
		'volume_gui': volume_gui,
	}


# Set data ---------------------------------------------------------------------
func set_data(data:Dictionary) -> void:
	aspect_ratio = data['aspect_ratio'] if data.has('aspect_ratio') else OptionsHandler.AspectRatio.ASPECT_RATIO_16_9
	fullscreen = data['fullscreen'] if data.has('fullscreen') else false
	locale = data['locale'] if data.has('locale') else OptionsHandler.get_os_locale()
	resolution = data['resolution'] if data.has('resolution') else OptionsHandler.Resolution.RESOLUTION_960_540
	volume_master = data['volume_master'] if data.has('volume_master') else  1.0
	volume_music = data['volume_music'] if data.has('volume_music') else  0.8
	volume_ambience = data['volume_ambience'] if data.has('volume_ambience') else  0.8
	volume_voice = data['volume_voice'] if data.has('volume_voice') else  1.0
	volume_sfx = data['volume_sfx'] if data.has('volume_sfx') else  0.8
	volume_gui = data['volume_gui'] if data.has('volume_gui') else  0.6
