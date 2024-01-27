extends ZoovisitorBaseState

@onready var zoovisitor_animation_player = $"../../Zookeeper_Model".get_node("AnimationPlayer")

func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	#state_machine.transition_to("Follow_Player")
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	print("Attack")
	zoovisitor_animation_player.play("EnemyPetting")
	character.start_attack_cooldown()


func exit() -> void:
	pass


func animation_end() -> void:
	print("done")
	state_machine.transition_to("Follow_Player")
