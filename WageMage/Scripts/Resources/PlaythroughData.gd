class_name PlaythroughData
extends Node


var gold : int = 0


# Init =========================================================================
func _init(data:Dictionary) -> void:
	set_data(data)


# Data =========================================================================

# Get data ---------------------------------------------------------------------
func get_data() -> Dictionary:
	return {
		'gold': gold,
	}


# Set data ---------------------------------------------------------------------
func set_data(data:Dictionary) -> void:
	gold = data['gold'] if data.has('gold') else 0
