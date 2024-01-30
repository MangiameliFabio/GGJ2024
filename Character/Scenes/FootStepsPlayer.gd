extends AudioStreamPlayer

var step_sounds: Array[AudioStream]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	step_sounds.append(load("res://Sounds/Character/FS/FS_Char (01).wav"))
	step_sounds.append(load("res://Sounds/Character/FS/FS_Char (02).wav"))
	step_sounds.append(load("res://Sounds/Character/FS/FS_Char (03).wav"))
	step_sounds.append(load("res://Sounds/Character/FS/FS_Char (04).wav"))
	step_sounds.append(load("res://Sounds/Character/FS/FS_Char (05).wav"))
	step_sounds.append(load("res://Sounds/Character/FS/FS_Char (06).wav"))
	step_sounds.append(load("res://Sounds/Character/FS/FS_Char (07).wav"))

func play_ran_step():
	pitch_scale = rng.randf_range(0.8, 1.2)
	set_stream(step_sounds[rng.randf_range(0, step_sounds.size())])
	play()
