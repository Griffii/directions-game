extends Node2D


var full_screen: bool = false

func _on_createalevel_pressed():
	SceneManager.play_click_sfx()
	Globals.GameStarted = false
	SceneManager.change_scene("res://Scenes/Level/create_a_level.tscn")


func _on_city_pressed():
	SceneManager.play_click_sfx()
	Globals.GameStarted = true
	SceneManager.change_scene("res://Scenes/Level/Menu/city_menu.tscn")


func _on_school_pressed():
	SceneManager.play_click_sfx()
	Globals.GameStarted = true
	SceneManager.change_scene("res://Scenes/Level/Menu/school_menu.tscn")



func _on_player_made_pressed():
	SceneManager.play_click_sfx()
	Globals.GameStarted = true
	SceneManager.change_scene("user://Player_Created.tscn")



func _on_full_screen_pressed():
	SceneManager.play_click_sfx()
	if full_screen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	full_screen = !full_screen


func _on_single_player_pressed() -> void:
	SceneManager.play_click_sfx()
	Globals.GameStarted = true
	SceneManager.change_scene("res://Scenes/Level/Single Player/new_to_school.tscn")




func on_button_hovered():
	SceneManager.play_hover_sfx()
