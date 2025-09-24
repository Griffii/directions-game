extends Node2D



func _on_city_v_1_pressed():
	SceneManager.change_scene("res://Scenes/Level/city_og.tscn")

func _on_city_v_2_pressed():
	SceneManager.change_scene("res://Scenes/Level/City/cityV2.tscn")


func _input(event):
	if event.is_action_pressed("Menu"):
		Globals.GameStarted = false
		SceneManager.change_scene("res://Scenes/Level/Menu/start_menu.tscn")

func _on_button_pressed():
	Globals.GameStarted = false
	SceneManager.change_scene("res://Scenes/Level/Menu/start_menu.tscn")


### Button Hover Effects ############################################

func _on_city_map_1_mouse_entered() -> void:
	SceneManager.play_hover_sfx()
	%CityMap1.scale = Vector2(1.05, 1.05)
func _on_city_map_1_mouse_exited() -> void:
	%CityMap1.scale = Vector2(1.0, 1.0)

func _on_city_map_2_mouse_entered() -> void:
	SceneManager.play_hover_sfx()
	%CityMap2.scale = Vector2(1.05, 1.05)
func _on_city_map_2_mouse_exited() -> void:
	%CityMap2.scale = Vector2(1.0, 1.0)
