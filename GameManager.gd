extends Node

var kill_count = 0

func start_menu_music():
	$AudioStreamPlayer.play()

func stop_menu_music():
	$AudioStreamPlayer.stop()
