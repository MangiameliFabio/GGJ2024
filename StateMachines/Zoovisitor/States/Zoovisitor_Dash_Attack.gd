extends ZoovisitorBaseState

var is_charging: bool = false

func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	state_machine.transition_to("Follow_Player")
	#pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	if !is_charging:
		var timer: Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 2.0
		timer.timeout.connect(_dash_charge_done.bind(timer))
		timer.start()
		print("Charge dash...")
		is_charging = true


func exit() -> void:
	pass


func _dash_charge_done(timer: Timer) -> void:
	timer.queue_free()
	print("Dash")
	character.velocity *= character.DASH_POWER
	character.move_and_slide()
	character.start_dash_cooldown()
	is_charging = false
