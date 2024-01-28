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


func exit() -> void:
	pass
