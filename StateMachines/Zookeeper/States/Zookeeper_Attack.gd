extends ZookeeperBaseState


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	# TODO:
	state_machine.transition_to("Follow_Player")
	print("Attack")
	state_machine.emit_attack()


func exit() -> void:
	pass
