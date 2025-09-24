extends Control

var movemarkerCounter = 0
var mouse_hover: bool = false
signal set_goal(goal)

func _can_drop_data(_at_position, _data):
	return true
	
func _drop_data(_at_position, data):
	#location = preload("res://Scenes/Object/location.tscn")
	#var instance = location.instantiate()
	if "UL" in data.name:
		var userLocation = preload("res://Scenes/Object/user_location.tscn")
		var pic = userLocation.instantiate()	
		pic.name = data.name
		#pic.get_child(0).texture = data.texture
		pic.size.x = data.size.x
		pic.size.y = data.size.y
		pic.scale = data.scale
		pic.position = _at_position - 0.5 * pic.size * pic.scale
		#for node in pic.get_child(1).get_children():
		#	print(node)
		$".".add_child(pic)
	elif  "MoveMarker" in data.name:
		var texture = preload("res://Scenes/Object/move_m_image.tscn")
		var mm = texture.instantiate()
		mm.position = _at_position
		mm.texture = data.texture
		mm.name = "MoveMarker"
		if movemarkerCounter > 0:
			mm.name = "MoveMarker" + str(movemarkerCounter)
		#mm.scale = Vector2(1.8, 2.3)
		$".".add_child(mm)
		movemarkerCounter += 1
	else:
		var exists = false
		for pics in self.get_children():
			if pics.name in data.name:
				exists = true
		if !exists:
			var texture = preload("res://Scenes/Object/pic_create_a_level.tscn")
			var pic = texture.instantiate()
			pic.name = data.name
			pic.texture = data.texture
			pic.size.x = Globals.selected_x_length
			pic.size.y = Globals.selected_y_length
			pic.scale = Globals.selected_size
			pic.position = _at_position - 0.5 * pic.size * pic.scale
			$".".add_child(pic)
	
	#instance.position = pic.position + 0.5 * pic.size*2
	#$"../locations".add_child(instance)
