extends Node3D
class_name GibiSkeleton

@onready var skeleton: Skeleton3D = %GeneralSkeleton

# Previous frame's rotation quaternion
var prev_rotation: Quaternion
# Angular velocity vector
var angular_velocity: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize prev_rotation with the current rotation in the first frame
	prev_rotation = transform.basis.get_rotation_quaternion().normalized()

func enable_physics_right(enable: bool) -> void:
	if(enable):
		skeleton.physical_bones_start_simulation(["mixamorig_Arm.R","mixamorig_ForeArm.R","mixamorig_Hand.R"])
	else:
		skeleton.physical_bones_stop_simulation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate the current rotation's quaternion
	var current_rotation = transform.basis.get_rotation_quaternion().normalized()
	# Calculate the difference in rotation (rotation change) as a quaternion
	var rotation_difference = current_rotation * prev_rotation.inverse()
	# Update the previous rotation to the current rotation for the next frame
	prev_rotation = current_rotation

	# Convert rotation difference to Euler angles (in radians)
	var euler_angles = rotation_difference.get_euler()

	# Calculate angular velocity (angle change per second)
	angular_velocity = euler_angles / delta

	# Optionally, print the angular velocity to the console for debugging
	print("Angular velocity: ", angular_velocity)
	
func _physics_process(delta):
	print()
	
