extends ZoovisitorBaseState

@export var bone: PhysicalBone3D

func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	character.dead = true
	$"../../Zookeeper_Model/Armature_001/Skeleton3D".physical_bones_start_simulation()
	var impulse_dir = _msg.damage_direction as Vector3
	impulse_dir.y = 0.5
	
	bone.apply_central_impulse(impulse_dir.normalized() * 125)

func exit() -> void:
	pass