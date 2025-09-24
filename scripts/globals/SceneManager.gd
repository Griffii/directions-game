extends Node


var current_scene: Node = null
var transition: Node = null
var audio: Node = null


func _ready() -> void:
	await get_tree().process_frame
	
	if get_tree().root.has_node("StartMenu"):
		current_scene = get_tree().root.get_node("StartMenu")
	
	# Load in the scene transition manager
	transition = preload("res://Scenes/ui/scene_transition.tscn").instantiate()
	get_tree().root.add_child(transition)
	
	# Load in the audio overlay
	audio = preload("res://Scenes/ui/AudioManager.tscn").instantiate()
	get_tree().root.add_child(audio)



### SCENE MANAGEMENT ###########################################
func change_scene(scene: String):
	await transition.play_fade_in()
	
	# Free the old scene
	if current_scene:
		current_scene.queue_free()
	
	# Load the new scene
	var new_scene = load(scene).instantiate()
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	
	await transition.play_fade_out()



### GLOBAL AUDIO FUNCS ###############################################
func play_hover_sfx():
	audio.hover_sfx.play()

func play_click_sfx():
	audio.click_sfx.play()
