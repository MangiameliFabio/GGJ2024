extends ZookeeperBaseState

@export var zookeeper: CharacterBody3D

@onready var zookeeper_animation_player = $"../../Zookeeper_Model".get_node("AnimationPlayer")



func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	if !character.dash_on_cooldown:
		var overlapping_bodies = character.get_node("Dash_Trigger").get_overlapping_bodies()
		for body in overlapping_bodies:
			if body == Gibbi.Instance:
				print("follow trigger")
				state_machine.transition_to("Charge_Dash")
	
	# Look at the set target
	zookeeper.look_at(zookeeper.navigation_agent.get_target_position())
	zookeeper.rotate_object_local(Vector3.UP, PI)
	
	# Follow the set target
	var current_location = zookeeper.global_transform.origin
	var next_location = zookeeper.navigation_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * zookeeper.SPEED
	
	zookeeper.velocity = zookeeper.velocity.move_toward(new_velocity, 0.25)
	zookeeper.move_and_slide()


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	zookeeper_animation_player.play("EnemyWalk")


func exit() -> void:
	zookeeper_animation_player.stop()
