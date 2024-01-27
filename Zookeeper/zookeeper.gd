extends CharacterBody3D
class_name Zookeeper


const SPEED = 4.0
const ATTACK_TIMEOUT: float = 2.0

@onready var navigation_agent = $Navigation_Agent
@onready var state_machine = $ZookeeperStateMachine

var attack_on_cooldown: bool = false
var dead: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	pass

func receive_damage(damage_direction: Vector3) -> void:
	if !dead:
		state_machine.transition_to("Death", {"damage_direction": damage_direction})

func _physics_process(delta) -> void:
	update_target_location(Gibbi.Instance.global_transform.origin)

func update_target_location(target_location: Vector3) -> void:
	navigation_agent.set_target_position(target_location)


func _on_navigation_agent_target_reached():
	if not attack_on_cooldown and not dead:
		state_machine.transition_to("Attack")
		start_attack_cooldown()


func start_attack_cooldown() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = ATTACK_TIMEOUT
	timer.timeout.connect(_attack_cooldown_timer_done.bind(timer))
	timer.start()
	attack_on_cooldown = true
	print("attack cooldown started")


func _attack_cooldown_timer_done(timer: Timer) -> void:
	attack_on_cooldown = false
	timer.queue_free()
	print("attack cooldown done")
