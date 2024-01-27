extends ZookeeperBaseState

@onready var animation_player = $"../../Zookeeper_Model/AnimationPlayer"


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	character.velocity *= character.DASH_POWER
	character.move_and_slide()
	character.start_dash_cooldown()
	animation_player.play("EnemyAttack_End")


func exit() -> void:
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "EnemyAttack_End":
		state_machine.transition_to("Follow_Player")
