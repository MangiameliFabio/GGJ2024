extends CharacterBody3D
class_name Zoovisitor


const SPEED = 4.0
const ATTACK_COOLDOWN: float = 2.0
const DASH_COOLDOWN: float = 3.0
const DASH_POWER: float = 4.0

@onready var navigation_agent = $Navigation_Agent
@onready var state_machine = $ZoovisitorStateMachine

var attack_on_cooldown: bool = false
var dash_on_cooldown: bool = false
var dead: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	pass


func _physics_process(delta) -> void:
	pass

func _process(delta) -> void:
	pass


func update_target_location(target_location: Vector3) -> void:
	navigation_agent.set_target_position(target_location)


func _on_navigation_agent_target_reached():
	if !attack_on_cooldown and !dead:
		state_machine.transition_to("Attack")


func start_attack_cooldown() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = ATTACK_COOLDOWN
	timer.timeout.connect(_attack_cooldown_timer_done.bind(timer))
	timer.start()
	attack_on_cooldown = true


func _attack_cooldown_timer_done(timer: Timer) -> void:
	attack_on_cooldown = false
	timer.queue_free()


func _on_dash_trigger_entered(body):
	if !dash_on_cooldown and !dead:
		state_machine.transition_to("Dash")

func start_dash_cooldown() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = DASH_COOLDOWN
	timer.timeout.connect(_dash_cooldown_timer_done.bind(timer))
	timer.start()
	dash_on_cooldown = true


func _dash_cooldown_timer_done(timer: Timer) -> void:
	dash_on_cooldown = false
	timer.queue_free()
