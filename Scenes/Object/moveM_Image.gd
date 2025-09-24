extends TextureRect

var was_dropped = false

func _get_drag_data(_at_position):
	if !Globals.GameStarted:
		was_dropped = true
		var preview = TextureRect.new()
		preview.texture = self.texture
		preview.set_name(self.name)
		set_drag_preview(preview)
		return preview 



func _on_gui_input(event):
	if event.is_action_released("click") and Globals.GameStarted:
		if Globals.start_location == self.position + 1 * self.size * self.scale:
			Globals.start_location = null
		else:
			Globals.start_location = self.position + 1 * self.size * self.scale
			Globals.start_location_changing = true
