extends Base_Level


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
							#print(instance.get_child(0).get_shape().size)
							#instance.scale = a.scale
			instance.global_position = pic.global_position + 0.5 * pic.size * pic.scale
			
			$locations.add_child(instance)
			instance.set_owner($".")
					
		#This is not needed in player images levels because the player places their own move markers
		#if "MoveMarker" in pic.name:
		#			var m = preload("res://Scenes/Object/move_marker.tscn")
		#			var mmInstance = m.instantiate()
		#			mmInstance.set_name(pic.name)
		#			mmInstance.get_child(0).get_shape().size.x =(pic.size.x * pic.scale.x)
		#			mmInstance.get_child(0).get_shape().size.y =(pic.size.y * pic.scale.y)
		#			mmInstance.global_position = pic.global_position + 0.5 * pic.size * pic.scale
		#			$MoveMarkers.add_child(mmInstance)
		#			mmInstance.set_owner($".")

	for node in $locations.get_children():
			locations.append(node)
	for node in $MoveMarkers.get_children():
		road_markers.append(node)
	select_random_goal()
	select_random_start_location()
	$WinMessage.hide()
	
func startLocationChanged():
	if Globals.start_location_changing:
		$Player.position = Globals.start_location
		Globals.start_location_changing = false
		get_tree().reload_current_scene()

func globals_goal_changed():
	if Globals.changing:
		current_goal = Globals.goal	
		#print(current_goal)
		Globals.changing = false
		$"Control/VBoxContainer/Sentence Container/Label".text = "Where is the _____?"

func select_random_goal():
	if locations.size() > 0: 
		current_goal = locations[randi() % locations.size()].name
		Globals.goal = current_goal
		$"Control/VBoxContainer/Sentence Container/Label".text = "Where is the " + current_goal + "?"


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
		start_timer = true
		
		if start_timer == true and !Globals.player_moving:
			$WinMessage.show()
			$Timers/WinMessage.start()
			start_timer = false
			Globals.win = false
	if Globals.reset == true:
		$Player.position = start_position
		


func _on_win_message_timeout():
	get_tree().reload_current_scene()

func _process(_delta):
	for node in $"Left Panel".get_children():
		#if "UL" in node.name:
		#	print(node.get_child(0).size)
		if node.was_dropped == true:
			node.queue_free()
	for pic in $"Left Panel".get_children():
		if "MoveMarker" in pic.name:
			if Globals.show_marker == false:
				pic.hide()
			elif Globals.show_marker == true:
				pic.show()
	for pic in $"Left Panel".get_children():
		if "MoveMarker" not in pic.name and pic.get_class() =="Control":
			if Globals.show_location == false:
				#print(pic.get_child(0).texture.self_modulate)
				pic.get_child(0).hide()
			else:
				pic.get_child(0).show()
	globals_goal_changed()
	startLocationChanged()
	check_win()


func _on_move_marker_image_toggled(_toggled_on):
	if Globals.show_marker == true:
		Globals.show_marker = false
	else: Globals.show_marker = true

func _on_menu_pressed():
	Globals.show_marker = true
	Globals.GameStarted = false
	Globals.start_location = null
	get_tree().change_scene_to_file("res://Scenes/Level/Menu/start_menu.tscn")

func _on_location_box_image_toggled(_toggled_on):
	if Globals.show_location == true:
		Globals.show_location = false
	elif Globals.show_location == false:
		Globals.show_location = true
