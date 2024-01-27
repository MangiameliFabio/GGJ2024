extends ZoovisitorBaseState


# TODO: Change this to right model
@onready var zoovisitor_animation_player = $"../../Zookeeper_Model/AnimationPlayer"


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	#if !character.dash_on_cooldown:
		#var overlapping_bodies = character.get_node("Dash_Trigger").get_overlapping_bodies()
		#for body in overlapping_bodies:
			#if body.name == "Player":
				#state_machine.transition_to("Charge_Dash")
	
	# Look at the set target
	character.look_at(character.navigation_agent.get_target_position())
	character.rotate_object_local(Vector3.UP, PI)
	
	# Follow the set target
	var current_location = character.global_transform.origin
	var next_location = character.navigation_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * character.SPEED
	
	character.velocity = character.velocity.move_toward(new_velocity, 0.25)
	character.move_and_slide()


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	print("Follow player zoovisitor")
	zoovisitor_animation_player.play("EnemyWalk")


func exit() -> void:
	zoovisitor_animation_player.stop()
