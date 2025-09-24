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
	$WinMessage.hide()

	for child in $"Left Panel".get_children():
		if Globals.hide  == true:
			child.hide()
			print($Control/buttonbox/CardImageView.button_pressed)
			$Control/buttonbox/CardImageView.button_pressed = true
		elif Globals.hide  == false:
			child.show()
			print($Control/buttonbox/CardImageView.button_pressed)

func select_random_goal():
	current_goal = locations[randi() % locations.size()].name
	Globals.goal = current_goal
	$"UI_Layer/MarginContainer/Sentence_Box/Sentence Container/Label".text = "My favorite place is the " + current_goal + "."
	
func globals_goal_changed():
	if Globals.changing:
		current_goal = Globals.goal	
		Globals.changing = false
		$"UI_Layer/MarginContainer/Sentence_Box/Sentence Container/Label".text = "This is my favorite place."


func _on_card_image_view_toggled(toggled_on: bool) -> void:
	for child in $"Left Panel".get_children():
		if "MoveMarker" not in child.name:
			if toggled_on:
				Globals.hide = true
			elif !toggled_on:
				Globals.hide = false
			if Globals.hide  == true:
				child.texture.modulate(255,255,255,0)
			elif Globals.hide  == false:
				child.texture.show()
