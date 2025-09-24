extends Node2D

func _on_og_school_pressed():
	SceneManager.play_click_sfx()
	SceneManager.change_scene("res://Scenes/Level/School/og_school_directions.tscn")


func _on_new_school_pressed():
	SceneManager.play_click_sfx()
	SceneManager.change_scene("res://Scenes/Level/School/this_is_my_favourite_place.tscn")


func _on_menu_pressed():
	Globals.GameStarted = false
	SceneManager.play_click_sfx()
	SceneManager.change_scene("res://Scenes/Level/Menu/start_menu.tscn")


func _input(event):
	if event.is_action_pressed("Menu"):
		SceneManager.play_click_sfx()
		SceneManager.change_scene("res://Scenes/Level/Menu/start_menu.tscn")


func _on_lets_try_map_pressed() -> void:
	SceneManager.play_click_sfx()
	SceneManager.change_scene("res://Scenes/Level/School/new_school.tscn")



### Button Hover Effects ############################################

func _on_school_map_1_mouse_entered() -> void:
	SceneManager.play_hover_sfx()
	%SchoolMap1.scale = Vector2(1.05, 1.05)
func _on_school_map_1_mouse_exited() -> void:
	%SchoolMap1.scale = Vector2(1.0, 1.0)

func _on_school_map_2_mouse_entered() -> void:
	SceneManager.play_hover_sfx()
	%SchoolMap2.scale = Vector2(1.05, 1.05)
func _on_school_map_2_mouse_exited() -> void:
	%SchoolMap2.scale = Vector2(1.0, 1.0)

func _on_school_map_3_mouse_entered() -> void:
	SceneManager.play_hover_sfx()
	%SchoolMap3.scale = Vector2(1.05, 1.05)
func _on_school_map_3_mouse_exited() -> void:
	%SchoolMap3.scale = Vector2(1.0, 1.0)
