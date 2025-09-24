extends CharacterBody2D

@export var speed = 200
var target = destination
var can_move_forward: bool = false
var destination: Vector2
var faceing: int = 0
var shortest_distance = INF

#small change
var animationToPlay = "WalkDown"

func rotation(input):
	if input == "right":
		faceing +=1
	if input == "left":
		faceing -=1
	if faceing > 3:
		faceing = 0
	if faceing < 0:
		faceing = 3
	#facing Down
	if faceing == 0:
		$Sprite2D.frame = 0
		animationToPlay = "WalkDown"
	#facing Left
	if faceing == 1:
		$Sprite2D.frame = 6
		animationToPlay = "Walk_Left"
	#facing up
	if faceing == 2:
		$Sprite2D.frame = 3
		animationToPlay = "Walk_Up"
	#facing right
	if faceing == 3:
		$Sprite2D.frame = 9
		animationToPlay = "Walk_right"

func _input(event):
	if Globals.GameStarted:
		if event.is_action_pressed("Menu"):
			Globals.GameStarted = false
			Globals.single_player = false
			get_tree().change_scene_to_file("res://Scenes/Level/Menu/start_menu.tscn")
		if Globals.single_player and  Globals.command != null and event.is_action_released(Globals.command) and !Globals.player_moving:
			if event.is_action_released("turn_right") and !Globals.player_moving:
				$view.rotate(1.57)
				rotation("right")
				can_move_forward = false
			if event.is_action_released("turn_left") and !Globals.player_moving:
				$view.rotate(-1.57)
				rotation("left")
				can_move_forward = false
			if event.is_action_released("go_straight"):
				if can_move_forward and !Globals.player_moving:
					Globals.reset = false
					target = destination
					velocity = position.direction_to(target) * speed
					$AnimationPlayer.play(animationToPlay)
					Globals.player_moving = true
			Globals.step += 1
			print(Globals.step)
			#print(Globals.command)
		elif !Globals.single_player:
			if event.is_action_released("turn_right") and !Globals.player_moving:
				$view.rotate(1.57)
				rotation("right")
				can_move_forward = false
			if event.is_action_released("turn_left") and !Globals.player_moving:
				$view.rotate(-1.57)
				rotation("left")
				can_move_forward = false
			if event.is_action_released("go_straight"):
				if can_move_forward and !Globals.player_moving:
					Globals.reset = false
					target = destination
					velocity = position.direction_to(target) * speed
					$AnimationPlayer.play(animationToPlay)
					Globals.player_moving = true

func _on_view_area_entered(area):
	destination = area.position
	shortest_distance = INF
	can_move_forward = true


func _physics_process(_delta):
	if position.distance_to(target) > 2 and !Globals.reset and !Globals.start_location_changing:
		move_and_slide()
	if $view.get_overlapping_areas().size() > 0:
		can_move_forward = true
		for element in $view.get_overlapping_areas():
			var distance = position.distance_to(element.position)
			if distance < shortest_distance and destination !=element.position:
				shortest_distance = distance
				destination = element.position
				

func _on_body_collision_area_entered(area):
	$AnimationPlayer.stop()
	Globals.player_moving = false
	
	if "MoveMarker" not in area.name:
		can_move_forward = false
		Globals.reset = true
	#can_move_forward = true
	

#region Buttons

func _on_go_straight_pressed():
	var goStraight = InputEventAction.new()
	goStraight.action = "go_straight"
	Input.parse_input_event(goStraight)


func _on_turn_left_pressed():
	var turn_left = InputEventAction.new()
	turn_left.action = "turn_left"
	Input.parse_input_event(turn_left)



func _on_turn_right_pressed():
	var turn_right = InputEventAction.new()
	turn_right.action = "turn_right"
	Input.parse_input_event(turn_right)

#endregion


func _on_view_area_exited(_area):
	can_move_forward = false
	shortest_distance = INF
	
