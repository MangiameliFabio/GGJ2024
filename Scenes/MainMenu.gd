extends Control
@export var bananna: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	TransitionManager.change_scene("res://Scenes/Main.tscn")


func _on_controls_pressed():
	TransitionManager.change_scene("res://Scenes/Main.tscn")


func _on_quit_pressed():
	get_tree().quit()
