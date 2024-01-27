extends CharacterBody3D
class_name Gibbi

static var Instance : Node

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 0.005

@onready var camera = $Camera3D
@onready var collison = $Collision
@onready var skeleton: GibiSkeleton = $Collision/GibbiSkeleton
@onready var anim_player: AnimationPlayer = $Collision/GibbiSkeleton/AnimationPlayer
@onready var anim_tree: AnimationTree = $Collision/GibbiSkeleton/AnimationTree
var in_attack = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var health = 5
var dead = false

signal running(IsRunning : bool)

func _ready():
	Instance = self
	anim_player.play("GibbiIdle")

func _input(event):
	if not dead:
		if Input.is_action_just_pressed("right_arm"):
			skeleton.enable_physics_right(true)
			in_attack = true
		if Input.is_action_just_released("right_arm"):
			skeleton.enable_physics_right(false)
			in_attack = false

func get_click_world_position() -> Vector3:
	var mouse_position = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_position)
	var direction = camera.project_ray_normal(mouse_position)
	
	if direction.y == 0:
		return Vector3.ZERO

	var distance = (-ray_origin.y + position.y) / direction.y
	return ray_origin + direction * distance

func _physics_process(delta):
	if in_attack and (skeleton.r_hand_velocity.length_squared() > 10):
		skeleton.check_for_damage()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	var look_pos = get_click_world_position()
	
	if look_pos:
		turn(look_pos)
		
	if not dead and Input.is_action_pressed("walk_forward"):
		running.emit(true)
		velocity = -collison.get_global_transform().basis.z * SPEED
	else:
		running.emit(false)
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func recieve_damage():
	health -= 1
	if(health <= 0):
		dead = true
		skeleton.physical_bones_start_simulation()

func turn(mouse_pos):
	var global_pos = collison.global_transform.origin
	var rotation_speed = 0.1
	var wtransform = collison.global_transform.looking_at(Vector3(mouse_pos.x,global_pos.y,mouse_pos.z),Vector3(0,1,0))
	var wrotation = Quaternion(collison.global_transform.basis).slerp(Quaternion(wtransform.basis), rotation_speed)

	collison.global_transform = Transform3D(Basis(wrotation), collison.global_transform.origin)
