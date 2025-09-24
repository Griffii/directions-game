extends Control

var location = "user"
signal set_goal(goal)
var was_dropped = false


func _get_drag_data(_at_position):
	if !Globals.GameStarted:
		was_dropped = true
		var userLocation = preload("res://Scenes/Object/user_location.tscn")
		var uL = userLocation.instantiate()	
		var pic = uL.get_child(0)
		print(pic)
		uL.set_name("UL")
		uL.size.x = Globals.selected_x_length
		uL.size.y = Globals.selected_y_length
		uL.scale = Globals.selected_size
		var c = Control.new()
		c.add_child(uL)
		uL.position = -0.5 * uL.size * uL.scale
		
		set_drag_preview(c)
		return uL 



func _process(_delta):
	#$"Visable Box".scale = $".".scale 
	$"Visable Box".size = $".".size
	$Node/LineEdit.position = $".".position
	if Globals.selected != self:
		$"Visable Box".self_modulate = Color(1, 1, 1, 0.3)	
	if Globals.GameStarted:
		#$"Visable Box".self_modulate = Color(1, 1, 1, 0.3)
		$Node/LineEdit.hide()

func _on_line_edit_text_changed(new_text):
	$".".name = "UL" + new_text



func _on_gui_input(event):
	if event.is_action_released("click") and Globals.GameStarted:
		Globals.changing = true
		Globals.goal = self.name.erase(0,2)
		set_goal.emit(Globals.goal)
	
	if event.is_action_released("click") and !Globals.GameStarted:
		Globals.selected = self
		$"Visable Box".self_modulate = Color(1, 1, 0, 1)	
