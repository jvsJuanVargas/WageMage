class_name BillionaireData
extends Resource


var name : String = ""


# Init =========================================================================
func _init(data:Dictionary) -> void:
	set_data(data)


# Set data ---------------------------------------------------------------------
func set_data(data:Dictionary) -> void:
	name = data['name'] if data.has('name') else ""
