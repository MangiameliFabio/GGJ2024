extends Node3D
class_name GibiSkeleton

@onready var skeleton: Skeleton3D = %GeneralSkeleton

# Called when the node enters the scene tree for the first time.
func _ready():
	skeleton.physical_bones_start_simulation(["mixamorig_Arm.R","mixamorig_ForeArm.R","mixamorig_Hand.R"])

func enable_physics_right(enable: bool) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

