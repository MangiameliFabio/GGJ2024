extends Zoo_Visitor_01BaseState


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	state_machine.transition_to("Follow_Player")
	#character
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	print("Idle")


func exit() -> void:
	pass

