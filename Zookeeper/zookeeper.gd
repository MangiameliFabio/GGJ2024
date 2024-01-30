extends CharacterBody3D
class_name Zookeeper


const SPEED = 4.0
const ATTACK_TIMEOUT: float = 2.0
const DASH_COOLDOWN: float = 5.0
const DASH_POWER: float = 4.0
const DESPAWN_TIME: float = 15.0

@onready var navigation_agent = $Navigation_Agent
@onready var state_machine = $ZookeeperStateMachine

var attack_on_cooldown: bool = false
var dash_on_cooldown: bool = false
var is_invincible: bool = false
var dead: bool

signal OnGetHit
signal OnAttack

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	pass

func receive_damage(damage_direction: Vector3) -> bool:
	if !dead and !is_invincible:
		state_machine.transition_to("Death", {"damage_direction": damage_direction})
		OnGetHit.emit()
		return true
	return false

func _physics_process(delta) -> void:
	update_target_location(Gibbi.Instance.global_transform.origin)

func update_target_location(target_location: Vector3) -> void:
	navigation_agent.set_target_position(target_location)


func _on_navigation_agent_target_reached():
	pass


func start_attack_cooldown() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = ATTACK_TIMEOUT
	timer.timeout.connect(_attack_cooldown_timer_done.bind(timer))
	timer.start()
	attack_on_cooldown = true


func _attack_cooldown_timer_done(timer: Timer) -> void:
	attack_on_cooldown = false
	timer.queue_free()


func _on_dash_trigger_entered(body):
	if body == Gibbi.Instance and !dash_on_cooldown:
		state_machine.transition_to("Charge_Dash")


func start_dash_cooldown() -> void:
	dash_on_cooldown = true
	var timer: Timer = Timer.new()
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = DASH_COOLDOWN
	add_child(timer)
	timer.timeout.connect(_dash_cooldown_timer_done.bind(timer))
	#timer.start()


func _dash_cooldown_timer_done(timer: Timer) -> void:
	dash_on_cooldown = false
	timer.queue_free()
	
func emit_attack():
	OnAttack.emit()


func start_despawn_timer() -> void:
	var timer: Timer = Timer.new()
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = DESPAWN_TIME
	add_child(timer)
	timer.timeout.connect(_despawn_timer_done.bind(timer))


func _despawn_timer_done(timer: Timer) -> void:
	timer.queue_free()
	self.queue_free()
