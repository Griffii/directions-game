extends TextureRect


func _get_drag_data(_at_position):
	var preview = TextureRect.new()
	preview.texture = $".".texture
	preview.set_name("MoveMarker")
	set_drag_preview(preview)
	return preview
