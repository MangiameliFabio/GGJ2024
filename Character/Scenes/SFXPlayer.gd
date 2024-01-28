extends AudioStreamPlayer

var arm_out: AudioStream = load("res://Sounds/Character/Arm_Activate.wav")
var arm_in: AudioStream = load("res://Sounds/Character/Arm_Deactivate.wav")
var swoosh: Array[AudioStream]
var swoosh_on_cd = false
var rng = RandomNumberGenerator.new()

@export var swoosh_cd = 1

func _ready():
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char1.wav"))
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char2.wav"))
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char3.wav"))
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char4.wav"))
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char5.wav"))
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char6.wav"))
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char7.wav"))
	swoosh.append(load("res://Sounds/Character/Swoosh/Swoosh_Char8.wav"))

func play_sound(name: String):
	if not playing:
		match name:
			"arm_out":
				set_stream(arm_out)
			"arm_in":
				set_stream(arm_in)
		
		play()

func play_swoosh():
	if not playing and not swoosh_on_cd:
		var timer: Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = swoosh_cd
		timer.timeout.connect(func(): swoosh_on_cd = false)
		timer.start()
		swoosh_on_cd = true
		set_stream(swoosh[rng.randf_range(0, swoosh.size())])
		play()
