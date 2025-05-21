class_name WordData
extends Resource


var fixed : String = ""
var variants : Array[Dictionary] = []


# Init =========================================================================
func _init(data:Dictionary) -> void:
	set_data(data)


# Set data ---------------------------------------------------------------------
func set_data(data:Dictionary) -> void:
	fixed = data['fixed'] if data.has('fixed') else ""
	if data.has('variants'):
		for variant:Dictionary in data['variants']:
			variants.append({'letter': variant['letter'], 'word': variant['word']})


# Remove variant word ----------------------------------------------------------
func remove_variant(letter:String) -> void:
	var old_variants: Array[Dictionary] = variants.duplicate()
	for variant:Dictionary in old_variants:
		if variant['letter'] == letter:
			variants.erase(variant)


# Get correct variant word -----------------------------------------------------
func get_correct_word() -> String:
	variants.shuffle()
	return variants[0]['word']
