extends Node
@export var speeker: Array[AudioStreamPlayer3D]
@export var randomizer: AudioStreamRandomizer
@export var intro: AudioStream

@export var speeker_db = 0

var rng = RandomNumberGenerator.new()
var can_play: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print(speeker)
	print(intro)
	for s in speeker:
		s.max_db = speeker_db
		s.set_stream(intro)
		s.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_speekers():
	if can_play:
		var stream = randomizer.get_stream(rng.randi_range(0, speeker.size() - 1))
		for s in speeker:
			s.set_stream(stream)
			s.play()
		can_play = false

func _on_timer_timeout():
	can_play = true

func _on_speeker_1_finished():
	$Timer.start()
