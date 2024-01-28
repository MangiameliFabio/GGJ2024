extends AudioStreamPlayer

var slap_sounds: Array[AudioStream]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 1.wav"))
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 2.wav"))
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 3.wav"))
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 4.wav"))
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 5.wav"))
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 6.wav"))
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 7.wav"))
	slap_sounds.append(load("res://Sounds/Character/Slap/Slap 8.wav"))

func play_ran_slap():
	set_stream(slap_sounds[rng.randf_range(0, slap_sounds.size())])
	play()
