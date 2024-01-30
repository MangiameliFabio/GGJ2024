extends ZoovisitorBaseState

@export var bone: PhysicalBone3D

@onready var damage_trigger = $"../../Damage_Trigger"
@onready var skeleton_3d = $"../../Zookeeper_Model/Armature_001/Skeleton3D"
@onready var world_collision = $"../../World_Collision"


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	character.dead = true
	skeleton_3d.physical_bones_start_simulation()
	var impulse_dir = _msg.damage_direction as Vector3
	impulse_dir.y = 0.5
	world_collision.disabled = true
	damage_trigger.monitoring = false
	bone.apply_central_impulse(impulse_dir.normalized() * 125)
	character.start_despawn_timer()

func exit() -> void:
	pass
