extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/MarginContainer2/Label2.text = "Your Score: " + str(GameManager.kill_count)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	TransitionManager.change_scene("res://Scenes/Main.tscn")


func _on_main_menu_pressed():
	TransitionManager.change_scene("res://Scenes/MainMenu.tscn")


func _on_quit_pressed():
	get_tree().quit()
