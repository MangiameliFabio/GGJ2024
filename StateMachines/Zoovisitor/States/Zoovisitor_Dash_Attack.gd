extends ZoovisitorBaseState

@onready var zoovisitor_animation_player = $"../../Zookeeper_Model".get_node("AnimationPlayer")

var is_charging: bool = false

func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	#state_machine.transition_to("Follow_Player")
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	print("Dash")
	character.velocity *= character.DASH_POWER
	character.move_and_slide()
	character.start_dash_cooldown()


func exit() -> void:
	#zoovisitor_animation_player.stop()
	pass
	
func animation_end():
	print("oink")
	state_machine.transition_to("Follow_Player")
