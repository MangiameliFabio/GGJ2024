extends ZoovisitorBaseState

@export var zoovisitor: CharacterBody3D

# TODO: Change this to right model
@onready var zoovisitor_animation_player = $"../../Zookeeper_Model".get_node("AnimationPlayer")


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	# Look at the set target
	zoovisitor.look_at(zoovisitor.navigation_agent.get_target_position())
	zoovisitor.rotate_object_local(Vector3.UP, PI)
	
	# Follow the set target
	var current_location = zoovisitor.global_transform.origin
	var next_location = zoovisitor.navigation_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * zoovisitor.SPEED
	
	zoovisitor.velocity = zoovisitor.velocity.move_toward(new_velocity, 0.25)
	zoovisitor.move_and_slide()


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	print("Follow player zoovisitor")
	zoovisitor_animation_player.play("EnemyWalk")


func exit() -> void:
	zoovisitor_animation_player.stop()
