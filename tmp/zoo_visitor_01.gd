extends CharacterBody3D
class_name Zoo_Visitor_01


const SPEED = 2.5


@onready var navigation_agent = $Navigation_Agent
@onready var state_machine = $Zoo_Visitor_01StateMachine


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	#state_machine.transition_to("Follow_Player")
	pass


func _physics_process(delta) -> void:
	pass


func update_target_location(target_location: Vector3) -> void:
	navigation_agent.set_target_position(target_location)


func _on_navigation_agent_target_reached():
	state_machine.transition_to("Attack")
