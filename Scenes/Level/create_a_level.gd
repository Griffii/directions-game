extends Node2D

var PlayerImageLevel 
var blankCity
var bTownV2
var finished_level 
var levelScene
var Player_map

func _ready():
	levelScene = PackedScene.new()
	blankCity = preload("res://Scenes/Level/BlankCity01.tscn")
	PlayerImageLevel = preload("res://Scenes/Level/player_image_level.tscn")
	bTownV2 = preload("res://Scenes/Level/BtownV2.tscn")
	get_tree().get_root().files_dropped.connect(_on_files_dropped)

func _on_button_pressed():
	#Get the "map"
	finished_level = $mapPanel.get_child(0)
	#Get the locations node in the map
	#var Ls = finished_level.get_child(4)
	var Mmarker = finished_level.get_child(3)
	#loop through the maps children in order to set the owner for saving
	for c in finished_level.get_children():
		#for each texture rect instantiate a location, add it to the location node, and set its owner
		if c.name == "Left Panel":
			for a in c.get_children():
				if "MoveMarker" in a.name:
					var m = preload("res://Scenes/Object/move_marker.tscn")
					var mmInstance = m.instantiate()
					mmInstance.set_name(a.name)
					mmInstance.position = a.position + 0.5 * a.size*2
					mmInstance.get_child(0).get_shape().size = a.size - 0.15 * a.size
					#mmInstance.position.x += 5
					Mmarker.add_child(mmInstance)
					mmInstance.set_owner(finished_level)
					
		#Player needs to be unhidden and the owner not set to the level/map
		if c.name == "Player":
			c.show()
			continue
		c.set_owner(finished_level)
		#unhide everything else except the win message
		if c.name != "WinMessage":
			c.show()
		#The player view needs its owner set to the player
		for a in c.get_children():
			if a.name == "view":
				a.set_owner(c)
			else:
				a.set_owner(finished_level)
	
	levelScene.pack(finished_level)
	Globals.GameStarted = true
	ResourceSaver.save(levelScene, "user://Player_Created.tscn")
	ResourceSaver.save(levelScene, "res://Player_Created.tscn")
	get_tree().change_scene_to_file.bind("user://Player_Created.tscn").call_deferred()
	



#File dialogue - does not work atm with web exports
#func _on_load_pic_pressed():
#	var instance = PlayerImageLevel.instantiate()
#	#check if an instance exists so we dont add mulitple
#	$mapPanel.get_child(0).queue_free()
#	if $mapPanel.get_children().size() == 0:
#		$mapPanel.add_child(instance)
#		Player_map = instance.get_child(1)
#	$FileDialog.popup()


func _on_file_dialog_file_selected(path):
	if Player_map.texture != null:
		Player_map.texture = null
	var image = Image.new()
	image.load(path)
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	#Scale image to fit the left panel
	Player_map.scale.x = $mapPanel.size.x / image_texture.get_width()
	Player_map.scale.y = $mapPanel.size.y / image_texture.get_height()
	#add image to the level
	Player_map.texture = image_texture
	$"RightPanel/CenterContainer/VBoxContainer/TabContainer/Pick a Map/MarginContainer/VBoxContainer/HBoxContainer".show()

func _input(event):
	if event.is_action_pressed("Menu"):
		get_tree().change_scene_to_file("res://Scenes/Level/Menu/start_menu.tscn")

func _on_esc_button_pressed():
	Globals.GameStarted = false
	get_tree().change_scene_to_file("res://Scenes/Level/Menu/start_menu.tscn")

func _process(_delta):
	if $mapPanel.get_children().size() > 0:
		$"Esc button".hide()

func _on_files_dropped(files):
	Globals.show_marker = true
	if $mapPanel.get_children().size() > 0:
		$mapPanel.get_child(0).queue_free()
	if Player_map != null:
		Player_map = null
	
	var path = files[0]
	
	var image =Image.new()
	image.load(path)
	
	var texture = ImageTexture.new()
	texture.set_image(image)
	
	var instance = PlayerImageLevel.instantiate()
	
	$mapPanel.add_child(instance)
	Player_map = instance.get_child(1)
	
	if Player_map != null:	
		Player_map.scale.x = $mapPanel.size.x / texture.get_width()
		Player_map.scale.y = $mapPanel.size.y / texture.get_height()
		#add image to the level
		Player_map.texture = texture
	$"RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/Unique Location".show()
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/mm.show()
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/Instructions.text = "Click and drag a location or move marker into the map!"


func _on_texture_button_pressed():
	if $mapPanel.get_children().size() > 0:
		var player = $mapPanel.get_child(0).get_child(2)
		if !player.visible:
			player.show()
		else:
			player.hide()


func _on_smaller_pressed():
	if $mapPanel.get_children().size() > 0:
		var player = $mapPanel.get_child(0).get_child(2)
		if player.visible and player.scale > Vector2(0.3, 0.3):
				player.scale -= Vector2(0.1, 0.1)


func _on_bigger_pressed():
	if $mapPanel.get_children().size() > 0:
		var player = $mapPanel.get_child(0).get_child(2)
		if player.visible and player.scale < Vector2(2, 2):
			player.scale += Vector2(0.1, 0.1)


func _on_location_smaller_pressed():
	var increment = 0.1
	if !Globals.GameStarted and Globals.selected != null and is_instance_valid(Globals.selected):
		if Globals.selected.scale > Vector2(0.1, 0.1):
				Globals.selected.scale -= Vector2(increment, increment)
				Globals.selected_size = Globals.selected.scale

func _on_location_bigger_pressed():
	var increment = 0.1
	if !Globals.GameStarted and Globals.selected != null and is_instance_valid(Globals.selected):
		if Globals.selected.scale < Vector2(3, 3):
				Globals.selected.scale += Vector2(increment, increment)
				Globals.selected_size = Globals.selected.scale

func _on_blankmap_button_button_up():
	var instance = blankCity.instantiate()
	if $mapPanel.get_children().size() > 0:
		$mapPanel.get_child(0).queue_free()
	$mapPanel.add_child(instance)
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/mm.hide()
	$"RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/Unique Location".hide()
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations.show()
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/Instructions.text = "Click and drag a location into the map!"

func _on_blank_v_2_pressed():
	var instance = bTownV2.instantiate()
	if $mapPanel.get_children().size() > 0:
		$mapPanel.get_child(0).queue_free()
	$mapPanel.add_child(instance)
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/mm.hide()
	$"RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/Unique Location".hide()
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations.show()
	$RightPanel/CenterContainer/VBoxContainer/TabContainer/Locations/MarginContainer2/VBoxContainer2/Instructions.text = "Click and drag a location into the map!"
