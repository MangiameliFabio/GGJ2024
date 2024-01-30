extends CharacterBody3D
class_name Gibbi

static var Instance : Node

const SPEED = 4.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 0.005
const DAMAGE_FLASH_DURATION: float = 0.2

@onready var camera = $Camera3D
@onready var collison = $Collision
@onready var skeleton: GibiSkeleton = $Collision/GibbiSkeleton
@onready var anim_player: AnimationPlayer = $Collision/GibbiSkeleton/AnimationPlayer
@onready var anim_tree: AnimationTree = $Collision/GibbiSkeleton/AnimationTree
@onready var slap_player: AudioStreamPlayer = $SlapPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer
@onready var gibbi_mesh = $Collision/GibbiSkeleton/Armature/GeneralSkeleton/Gibbi


signal enemy_killed
signal damage_recieved

var in_attack = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health = 5
var dead = false
var material: StandardMaterial3D
var original_emission_color: Color

signal running(IsRunning : bool)

func _ready():
	GameManager.kill_count = 0
	Instance = self
	anim_player.play("GibbiIdle")
	
	#code for damage flashing
	var og_material = gibbi_mesh.get_active_material(0) as StandardMaterial3D
	og_material.set_feature(BaseMaterial3D.FEATURE_EMISSION, true)
	material = og_material.duplicate()
	gibbi_mesh.set_surface_override_material(0, material)
	
	original_emission_color = material.emission

func _input(event):
	if not dead:
		if Input.is_action_just_pressed("right_arm"):
			skeleton.enable_physics_right(true)
			in_attack = true
			sfx_player.play_sound("arm_out")
		if Input.is_action_just_released("right_arm"):
			skeleton.enable_physics_right(false)
			in_attack = false
			sfx_player.play_sound("arm_in")
			
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()

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
		if (skeleton.last_pos_r_hand - position).length_squared() >= 2:
			sfx_player.play_swoosh()
		if skeleton.check_for_damage():
			GameManager.kill_count += 1
			enemy_killed.emit()
			slap_player.play_ran_slap()
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
	#health -= 1
	$HitPlayer.play()
	damage_recieved.emit()
	flash_emission()
	if(health <= 0):
		dead = true
		skeleton.skeleton.physical_bones_start_simulation()

		var timer: Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 5
		timer.timeout.connect(func(): TransitionManager.change_scene("res://Scenes/GameOver.tscn"))
		timer.start()

func turn(mouse_pos):
	var global_pos = collison.global_transform.origin
	var rotation_speed = 0.1
	var wtransform = collison.global_transform.looking_at(Vector3(mouse_pos.x,global_pos.y,mouse_pos.z),Vector3(0,1,0))
	var wrotation = Quaternion(collison.global_transform.basis).slerp(Quaternion(wtransform.basis), rotation_speed)

	collison.global_transform = Transform3D(Basis(wrotation), collison.global_transform.origin)


func flash_emission():
	var duration = DAMAGE_FLASH_DURATION
	material.emission = Color.RED
	material.emission_energy = 1.0  # Adjust the emission energy as needed
	await get_tree().create_timer(duration).timeout
	material.emission = original_emission_color
	material.emission_energy = 0

