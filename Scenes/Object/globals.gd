extends Node

var changing: bool = false
var goal: String
var win: bool = false
var reset:bool = false
var player_moving: bool = false
var GameStarted = false
var selected
var selected_x_length = 200
var selected_y_length = 150
var selected_size = Vector2(1, 1)
var start_location = null
var start_location_changing = false
var show_marker: bool = true
var show_location: bool = true
var hide = false


var command = null
var step = 0
var single_player: bool = false
