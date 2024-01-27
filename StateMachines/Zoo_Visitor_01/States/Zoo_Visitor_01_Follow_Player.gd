extends Zoo_Visitor_01BaseState

@export var zoo_visitor_01: CharacterBody3D


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	# Look at the set target
	zoo_visitor_01.look_at(zoo_visitor_01.navigation_agent.get_target_position())
	zoo_visitor_01.rotate_object_local(Vector3.UP, PI)
	
	# Follow the set target
	var current_location = zoo_visitor_01.global_transform.origin
	var next_location = zoo_visitor_01.navigation_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * zoo_visitor_01.SPEED
	
	zoo_visitor_01.velocity = zoo_visitor_01.velocity.move_toward(new_velocity, 0.25)
	zoo_visitor_01.move_and_slide()


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	print("Follow Player Visitor")


func exit() -> void:
	pass
