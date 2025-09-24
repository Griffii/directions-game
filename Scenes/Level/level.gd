extends Node2D
class_name Base_Level

var current_goal = Globals.goal
var locations = []
var road_markers = []
var start_position: Vector2
var start_timer: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for pic in $"Left Panel".get_children():
		if "Player Image" in pic.name and !Globals.GameStarted:
			continue
		if "Move" not in pic.name:
			#print(pic.scale)
			var l = preload("res://Scenes/Object/location.tscn")
			var instance = l.instantiate()
			if "UL" in pic.name:
				instance.name = pic.name.erase(0,2)
			else :
				instance.set_name(pic.name)
							
			instance.get_child(0).get_shape().size.x =(pic.size.x * pic.scale.x)* 0.9
			instance.get_child(0).get_shape().size.y =(pic.size.y * pic.scale.y)* 0.9
			instance.global_position = pic.global_position + 0.5 * pic.size * pic.scale
			$locations.add_child(instance)
			instance.set_owner($".")
			
			
		if "MoveMarker" in pic.name:
					var m = preload("res://Scenes/Object/move_marker.tscn")
					var mmInstance = m.instantiate()
					mmInstance.set_name(pic.name)
					mmInstance.get_child(0).get_shape().size.x =(pic.size.x * pic.scale.x)
					mmInstance.get_child(0).get_shape().size.y =(pic.size.y * pic.scale.y)
					mmInstance.global_position = pic.global_position + 0.5 * pic.size * pic.scale
					$MoveMarkers.add_child(mmInstance)
					mmInstance.set_owner($".")
	
	
	for node in $locations.get_children():
			locations.append(node)
	for node in $MoveMarkers.get_children():
		road_markers.append(node)
	select_random_goal()
	select_random_start_location()
	

func startLocationChanged():
	if Globals.start_location_changing:
		start_position = Globals.start_location
		$Player.global_position = start_position
		Globals.start_location_changing = false
		#get_tree().reload_current_scene()

func globals_goal_changed():
	if Globals.changing:
		current_goal = Globals.goal	
		Globals.changing = false
		$"UI_Layer/MarginContainer/Sentence_Box/Sentence Container/Label".text = "Where is the _____?"

func select_random_goal():
	if locations.size() > 0: 
		current_goal = locations[randi() % locations.size()].name
		Globals.goal = current_goal
		$"UI_Layer/MarginContainer/Sentence_Box/Sentence Container/Label".text = "Where is the " + current_goal + "?"

func select_random_start_location():
	if Globals.start_location != null:
		start_position = Globals.start_location
		$Player.position = start_position
	else:
		if road_markers.size() > 0:
			start_position = road_markers[randi() % road_markers.size() - 1].position
			$Player.position = start_position
	

func check_win():
	if Globals.win == true:
		Globals.win = false
		%WinMessage.anim_player.play("spawn")
		await get_tree().create_timer(2.0).timeout
		
		# Reset Player + Goal
		select_random_goal()
		select_random_start_location()



func _process(_delta):
	globals_goal_changed()
	check_win()
	startLocationChanged()
	for pic in $"Left Panel".get_children():
		if "MoveMarker" in pic.name:
			if Globals.show_marker == false:
				pic.hide()
			elif Globals.show_marker == true:
				pic.show()


func _on_menu_pressed():
	SceneManager.play_click_sfx()
	Globals.show_marker = true
	Globals.GameStarted = false
	Globals.start_location = null
	Globals.single_player = false
	Globals.step = 0
	Globals.command = null
	SceneManager.change_scene("res://Scenes/Level/Menu/start_menu.tscn")
	Globals.hide = false


func _on_move_marker_image_toggled(_toggled_on):
	if Globals.show_marker == true:
		Globals.show_marker = false
	else: Globals.show_marker = true
