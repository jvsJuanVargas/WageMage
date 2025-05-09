extends CanvasLayer


# [!!!TODO] Se o loading demorar mais do que um segundo, mostra uma animação de loading. Essa animação desaparece junto com a tela de loading (ou um pouco antes).


@export var on_loading_screen : bool = false

var content_path : String
var is_loading : bool = false
var screen_animation : AnimationPlayer
var showing_animated_loading : bool = false


# Ready ========================================================================
func _ready() -> void:
	screen_animation = $Animation


# Process ======================================================================
func _process(_delta:float) -> void:
	if is_loading:
		loader_monitor()


# Manage content ===============================================================

# Change scene -----------------------------------------------------------------
func change_scene(new_content_path:String) -> void:
	content_path = new_content_path
	var loader : int = ResourceLoader.load_threaded_request(content_path)
	if not ResourceLoader.exists(content_path) or loader == null:
		printerr("Cannot load resource: \"%s\"" % [content_path])
		is_loading = false
	else:
		is_loading = true


# Switch scene -----------------------------------------------------------------
# [!!!TODO] Essa função troca apenas uma parte da cena. Se fosse um jogo de ação, manteria HUD, Tempo, Musicas, mudando apenas o cenário sem mostrar uma tela de loading.
func switch_scene() -> void:
	pass


# Loader monitor ---------------------------------------------------------------
func loader_monitor() -> void:
	var load_progress : Array = []
	match ResourceLoader.load_threaded_get_status(content_path, load_progress):
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			is_loading = false
			printerr("Invalid resource \"%s\"" % [content_path])
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print("Loading %f" % [load_progress[0] * 100])
		ResourceLoader.THREAD_LOAD_FAILED:
			is_loading = false
			printerr("Failed at load resource \"%s\"" % [content_path])
			return
		ResourceLoader.THREAD_LOAD_LOADED:
			is_loading = false
			scene_finished_loading(ResourceLoader.load_threaded_get(content_path).instantiate())
			print("Content finished loading")


# Scene has finished loading ---------------------------------------------------
func scene_finished_loading(incoming_scene:Variant) -> void:
	var outgoing_scene : Node = get_tree().current_scene
	outgoing_scene.queue_free()
	get_tree().root.call_deferred('add_child', incoming_scene)
	get_tree().set_deferred('current_scene', incoming_scene)


# Loading Screen ===============================================================

# Show loading screen ----------------------------------------------------------
func open_loading_screen() -> void:
	screen_animation.play('FadeIn')


# Hide loading screen ----------------------------------------------------------
func close_loading_screen() -> void:
	screen_animation.play('FadeOut')
