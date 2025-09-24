extends TextureRect

func _get_drag_data(_at_position):
	var preview = TextureRect.new()
	preview.texture = $".".texture
	preview.set_name(self.name)
	#preview.scale = Vector2(1.8, 2.3)
	preview.size.x = Globals.selected_x_length
	preview.size.y = Globals.selected_y_length
	preview.scale = Globals.selected_size
	var c = Control.new()
	c.add_child(preview)
	preview.position = -0.5 * preview.size * preview.scale
	set_drag_preview(c)
	return preview
