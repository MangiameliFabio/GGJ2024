extends AudioStreamPlayer

var idle_sounds: Array[AudioStream]
var rng = RandomNumberGenerator.new()

var sound_timer = 1
@onready var timer: Timer = $"../IdleSoundTimer"

# Called when the node enters the scene tree for the first time.
func _ready():
	idle_sounds.append(load("res://Sounds/Character/Idle/Idle_Char_1.wav"))
	idle_sounds.append(load("res://Sounds/Character/Idle/Idle_Char_2.wav"))
	idle_sounds.append(load("res://Sounds/Character/Idle/Idle_Char_3.wav"))
	idle_sounds.append(load("res://Sounds/Character/Idle/Idle_Char_4.wav"))
	idle_sounds.append(load("res://Sounds/Character/Idle/Idle_Char_5.wav"))
	idle_sounds.append(load("res://Sounds/Character//Idle/Idle_Char_6.wav"))

func play_ran_idle():
	timer.wait_time = rng.randf_range(3,7)
	set_stream(idle_sounds[rng.randf_range(0, idle_sounds.size())])
	play()
