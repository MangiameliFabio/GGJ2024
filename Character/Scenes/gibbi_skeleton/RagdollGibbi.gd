extends Node3D
class_name GibiSkeleton

@onready var skeleton: Skeleton3D = %GeneralSkeleton

@export var dmg_collisions: Array[Area3D]

# Called when the node enters the scene tree for the first time.
func _ready():
	skeleton.physical_bones_start_simulation(["mixamorig_Arm.R","mixamorig_ForeArm.R","mixamorig_Hand.R"])

func enable_physics_right(enable: bool) -> void:
	pass
	
func check_for_damage() -> void:
	for collision in dmg_collisions:
		var overlapping = collision.get_overlapping_bodies()
		for obj in overlapping:
			if obj.is_in_group("enemy"):
				obj.receive_damage(obj.global_position - collision.global_position);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

