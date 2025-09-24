extends Node2D

var simon: Array;
var directions: Array = ["Up", "Right", "Left"]
var level: int = 0;
var state = "Simon"
var loop = 0
var guess = "guessy";
var highScore = 0;

func pickInstruction():
	$PlayerTimeout.stop()
	simon.append(directions[randi_range(0, directions.size()-1)])
	var i = 0
	while i < simon.size():
		print("Simon says " + simon[i])
		await get_tree().create_timer(1).timeout
		if simon[i] == "Up":
			pushButton($"CenterContainer/VBoxContainer/CenterContainer/Go straight")
		if simon[i] == "Right":
			pushButton($"CenterContainer/VBoxContainer/GridContainer/Turn right")
		if simon[i] == "Left":
			pushButton($"CenterContainer/VBoxContainer/GridContainer/Turn left")
		i +=1
	
	state = "Player"
	$PlayerTimeout.start()
	
func check():
	if guess == simon[loop]:
		loop += 1
		$PlayerTimeout.start()
	
	elif guess  != simon[loop]:
		print("You pushed " + guess + ". But simon said " + simon[loop])
		state = "Game Over"
		$CenterContainer/ColorRect.show()
		return
	if loop == simon.size():
		state = "Simon"
		level += 1
		loop = 0
		$MarginContainer/VBoxContainer/Score.text = "Score: " + str(level)
		if level > highScore:
			highScore = level
			$MarginContainer/VBoxContainer/HighScore.text = "High Score: " + str(level)
		await get_tree().create_timer(1).timeout
		pickInstruction()

func pushButton(button):
	var time = 0.2
	if state == "Game Over":
		time = 10
	button.toggle_mode = true
	button.button_pressed = true
	if button == $"CenterContainer/VBoxContainer/CenterContainer/Go straight":
		if !$"Go straight audio".playing:
			$"Go straight audio".play()
	await get_tree().create_timer(time).timeout
	button.toggle_mode = false
	button.button_pressed = false

func _input(event: InputEvent) -> void:
	if state == "Simon":
		return
	if state == "Player":
		if event.is_action_released("turn_left") or event.is_action_released("turn_right") or event.is_action_released("go_straight"):
			if event.is_action_released("turn_left"):
				guess = "Left"
				pushButton($"CenterContainer/VBoxContainer/GridContainer/Turn left")
			if event.is_action_released("turn_right"):
				guess = "Right" 
				pushButton($"CenterContainer/VBoxContainer/GridContainer/Turn right")
			if event.is_action_released("go_straight"):
				guess = "Up"
				pushButton($"CenterContainer/VBoxContainer/CenterContainer/Go straight")
			check()
		
func _ready() -> void:
	$MarginContainer/VBoxContainer/Score.text = "Scoer: " + str(level)
	pickInstruction()
	
func _process(_delta: float) -> void:
	if state == "Simon":
		$ColorRect.show()
	else: $ColorRect.hide()
	if state == "Player":
		print($PlayerTimeout.time_left)

func _on_go_straight_button_down() -> void:
	if state == "Player":
		guess = "Up"
		check()


func _on_turn_right_button_down() -> void:
	if state == "Player":
		guess = "Right"
		check()


func _on_turn_left_button_down() -> void:
	if state == "Player":
		guess = "Left"
		check()


func _on_button_pressed() -> void:
	loop = 0;
	level = 0;
	simon = [];
	state = "Simon"
	$MarginContainer/VBoxContainer/Score.text = "Scoer: " + str(level)
	pickInstruction()
	$CenterContainer/ColorRect.hide()


func _on_player_timeout_timeout() -> void:
	$CenterContainer/ColorRect.show()
	state = "Game Over"
