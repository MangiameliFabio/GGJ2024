extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.stop_menu_music()
	
func _exit_tree():
	GameManager.start_menu_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
