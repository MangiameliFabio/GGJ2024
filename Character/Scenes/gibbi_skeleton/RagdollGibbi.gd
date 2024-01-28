extends Node3D
class_name GibiSkeleton

@onready var skeleton: Skeleton3D = %GeneralSkeleton

@export var dmg_collisions: Array[Area3D]

var r_hand_velocity = Vector3.ZERO
var last_pos_r_hand: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	last_pos_r_hand = get_bone_pos("mixamorig_Hand.R")

func enable_physics_right(enable: bool) -> void:
	if enable:
		skeleton.physical_bones_start_simulation(["mixamorig_Arm.R","mixamorig_ForeArm.R","mixamorig_Hand.R"])
	else:
		skeleton.physical_bones_stop_simulation()
	
func check_for_damage() -> bool:
	for collision in dmg_collisions:
		var overlapping = collision.get_overlapping_bodies()
		for obj in overlapping:
			if obj.is_in_group("enemy"):
				if obj.receive_damage(obj.global_position - collision.global_position):
					return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	r_hand_velocity = (last_pos_r_hand - get_bone_pos("mixamorig_Hand.R")) / delta
	last_pos_r_hand = get_bone_pos("mixamorig_Hand.R")
	
func get_bone_pos(name: String) -> Vector3:
	var bone_index = skeleton.find_bone(name)
	var pose_bone = skeleton.get_bone_global_pose(bone_index)
	return (skeleton.global_transform * pose_bone).origin

