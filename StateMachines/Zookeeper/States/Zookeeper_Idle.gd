extends ZookeeperBaseState


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	state_machine.transition_to("Follow_Player")


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	print("Idle zookeeper")


func exit() -> void:
	pass
