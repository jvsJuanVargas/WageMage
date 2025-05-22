class_name BillionaireData
extends Resource


var name : String = ""
var head : Resource = null
var trunk : Resource = null
var arm : Resource = null
var leg : Resource = null


# Init =========================================================================
func _init(data:Dictionary) -> void:
	set_data(data)


# Set data ---------------------------------------------------------------------
func set_data(data:Dictionary) -> void:
	name = data['name'] if data.has('name') else ""
	head = data['head'] if data.has('head') else null
	trunk = data['trunk'] if data.has('trunk') else null
	arm = data['arm'] if data.has('arm') else null
	leg = data['leg'] if data.has('leg') else null
