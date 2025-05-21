class_name Library


const LIBRARY_DATA_PATH = 'res://Data/Library.json'

var library_data : Variant


# Init =========================================================================
func _init() -> void:
	if FileAccess.file_exists(LIBRARY_DATA_PATH):
		var library_file : FileAccess = FileAccess.open(LIBRARY_DATA_PATH, FileAccess.READ)
		library_data = JSON.parse_string(library_file.get_as_text())


# Load billionaire data --------------------------------------------------------
func load_billionaire_data() -> BillionaireData:
	var billionaire_data : Dictionary = library_data['billionaires'][randi_range(0, library_data['billionaires'].size() - 1)]
	return BillionaireData.new({
		'name': billionaire_data['name'],
	})


# Load word data ---------------------------------------------------------------
func load_word_data(language:String) -> WordData:
	var word_data : Dictionary = library_data['words'][language][randi_range(0, library_data['words'][language].size() - 1)]
	return WordData.new({
		'fixed': word_data['fixed'],
		'variants': word_data['variants'],
	})
