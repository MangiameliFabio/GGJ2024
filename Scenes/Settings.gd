extends Control

@onready var volume_slider = $CenterContainer/VBoxContainer/Margin/VBoxContainer/HSlider


func _on_back_button_pressed():
	TransitionManager.change_scene("res://Scenes/MainMenu.tscn")


func _on_volume_slider_value_changed(value):
	if value <= volume_slider.min_value:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, value)
