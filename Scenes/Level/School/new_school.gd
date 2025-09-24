extends Base_Level

func select_random_goal():
	current_goal = locations[randi() % locations.size()].name
	Globals.goal = current_goal
	$"UI_Layer/MarginContainer/Sentence_Box/Sentence Container/Label".text = "My favorite place is the " + current_goal + "."
	
func globals_goal_changed():
	if Globals.changing:
		current_goal = Globals.goal	
		Globals.changing = false
		$"UI_Layer/MarginContainer/Sentence_Box/Sentence Container/Label".text = "This is my favorite place."
