extends ZookeeperBaseState

@onready var animation_player = $"../../Zookeeper_Model/AnimationPlayer"


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	animation_player.play("EnemyAttack_Begin")
	character.start_dash_cooldown()


func exit() -> void:
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "EnemyAttack_Begin":
		state_machine.transition_to("Dash")
