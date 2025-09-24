extends Base_Level

var sentence_box = null
var direction = null

func _ready() -> void:
	sentence_box = $"UI_Layer/MarginContainer/Sentence_Box/Sentence Container/Label"
	Globals.GameStarted = true
	Globals.single_player = true
	Globals.start_location = $"Left Panel/MoveMarker".position + 1 * $"Left Panel/MoveMarker".size * $"Left Panel/MoveMarker".scale
	start_position = Globals.start_location
	$Player.position = start_position
	current_goal = $"Left Panel/Classroom".name
	Globals.goal = current_goal
	sentence_box.text = "Where is the classroom?"
	$"where is the classroom".play()
	
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

func instructions():
	if Globals.step == 0:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn right"
		sentence_box.text = "Turn Right"
	
	if Globals.step == 1:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 2:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 3:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 4:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 5:
		direction = "Turn right"
		sentence_box.text = direction
		
	if Globals.step == 6:
		direction = null
		sentence_box.text = "Here is the classroom!"
		$"Left Panel/Classroom".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 7
	if Globals.step == 7:
		sentence_box.text = "Where is the gym?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 8
	if Globals.step == 8:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 9:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 10:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 11:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 12:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 13:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 14:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 15:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 16:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 17:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 18:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 19:
		direction = null
		sentence_box.text = "Here is the gym!"
		$"Left Panel/Gym".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 20
	if Globals.step == 20:
		sentence_box.text = "Where is the music room?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 21
	if Globals.step == 21:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 22:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 23:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 24:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 25:
		direction = null
		sentence_box.text = "Here is the music room!"
		$"Left Panel/Music room".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 26
	if Globals.step == 26:
		sentence_box.text = "Where is the school principal's office?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 27
	if Globals.step == 27:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 28:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 29:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 30:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 31:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 32:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 33:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 34:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 35:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 36:
		direction = null
		sentence_box.text = "Here is the school principal's office!"
		$"Left Panel/Principal's office".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 37
	if Globals.step == 37:
		sentence_box.text = "Where is the library?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 38
	if Globals.step == 38:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 39:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 40:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 41:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 42:
		direction = null
		sentence_box.text = "Here is the library!"
		$"Left Panel/Library".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 43
	if Globals.step == 43:
		sentence_box.text = "Where is the computer room?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 44
	if Globals.step == 44:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 45:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 46:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 47:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 48:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 49:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 50:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 51:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 52:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 53:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 54:
		direction = null
		sentence_box.text = "Here is the computer room!"
		$"Left Panel/Computer room".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 55
	if Globals.step == 55:
		sentence_box.text = "Look, the restroom."
		await get_tree().create_timer(1.0).timeout
		Globals.step = 56
	if Globals.step == 56:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 57:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 58:
		direction = null
		sentence_box.text = "It's the restroom!"
		$"Left Panel/Restroom".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 59
	if Globals.step == 59:
		sentence_box.text = "Where is the english room?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 60
	if Globals.step == 60:
		direction = null
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 61:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 62:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 63:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 64:
		direction = null
		sentence_box.text = "Here is the English room!"
		$"Left Panel/English room".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 65
	if Globals.step == 65:
		sentence_box.text = "Where is the science room?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 66
	if Globals.step == 66:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 67:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 68:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 69:
		direction = null
		sentence_box.text = "Here is the science room!"
		$"Left Panel/Science Room".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 70
	if Globals.step == 70:
		sentence_box.text = "Where is the arts and crafts room?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 71
	if Globals.step == 71:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 72:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 73:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 74:
		direction = null
		sentence_box.text = "Here is the arts and crafts room!"
		$"Left Panel/Arts and Crafts room".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 75
	if Globals.step == 75:
		sentence_box.text = "Where is the cooking room?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 76
	if Globals.step == 76:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 77:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 78:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 79:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 80:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 81:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 82:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 83:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 84:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 85:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 86:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 87:
		direction = null
		sentence_box.text = "Here is the cooking room!"
		$"Left Panel/Cooking room".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 88
	if Globals.step == 88:
		sentence_box.text = "Where is the lunch room?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 89
	if Globals.step == 89:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 90:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 91:
		direction = null
		sentence_box.text = "Here is the lunch room!"
		$"Left Panel/Lunch room".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 92
	if Globals.step == 92:
		sentence_box.text = "Where is the teachers office?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 93
	if Globals.step == 93:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 94:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 95:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 96:
		direction = null
		sentence_box.text = "Here is the teachers office!"
		$"Left Panel/Teachers office".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 97
	if Globals.step == 97:
		sentence_box.text = "Where is the school nurse's office?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 98
	if Globals.step == 98:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 99:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 100:
		direction = "Turn left"
		sentence_box.text = direction
	if Globals.step == 101:
		direction = null
		sentence_box.text = "Here is the school nures's office!"
		$"Left Panel/School nurse's office".show()
		await get_tree().create_timer(1.0).timeout
		Globals.step = 102
	if Globals.step == 102:
		sentence_box.text = "Where is the playground?"
		await get_tree().create_timer(1.0).timeout
		Globals.step = 103
	if Globals.step == 103:
		await get_tree().create_timer(3.0).timeout
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 104:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 105:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 106:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 107:
		direction = "Turn right"
		sentence_box.text = direction
	if Globals.step == 108:
		direction = "Go straight"
		sentence_box.text = direction
	if Globals.step == 109:
		direction = null
		sentence_box.text = "Here is the playground!"
		$"Left Panel/Playground".show()
		await get_tree().create_timer(2.0).timeout
		Globals.step = 110
	if Globals.step == 110:
		sentence_box.text = "The playground is my favorite place!"

func audio():
	var time = 0.5
	if direction == "Go straight":
		if !$"go straight".playing:
			$"go straight".play()
			await get_tree().create_timer(time).timeout
	if direction == "Turn left":
		if !$"turn left".playing:
			$"turn left".play()
			await get_tree().create_timer(time).timeout
	if direction == "Turn right":
		if !$"turn right".playing:
			$"turn right".play()
			await get_tree().create_timer(time).timeout
	if sentence_box.text == "Where is the gym?":
		if !$"Where is the gym".playing:
			$"Where is the gym".play()
			await get_tree().create_timer(time).timeout

func check_direction():
	match direction:
		"Turn right": Globals.command = "turn_right"
		"Turn left": Globals.command = "turn_left"
		"Go straight": Globals.command = "go_straight"
		null: Globals.command = null

func _process(_delta: float) -> void:
	check_direction()
	instructions()
	audio()
	
