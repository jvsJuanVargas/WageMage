class_name WordData
extends Resource


var fixed : String = ""


# Init =========================================================================
func _init(data:Dictionary) -> void:
	set_data(data)


# Set data ---------------------------------------------------------------------
func set_data(data:Dictionary) -> void:
	fixed = data['fixed'] if data.has('fixed') else ""
