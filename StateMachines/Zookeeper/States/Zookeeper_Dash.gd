extends ZookeeperBaseState

@onready var animation_player = $"../../Zookeeper_Model/AnimationPlayer"


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	character.move_and_slide()


func enter(_msg := {}) -> void:
	#character.start_dash_cooldown()
	animation_player.play("EnemyAttack_End")


func exit() -> void:
	character.is_invincible = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "EnemyAttack_End":
		#print("distance: " + str(Gibbi.Instance.position.distance_squared_to(character.position)))
		#if Gibbi.Instance.position.distance_squared_to(character.position) <= 1.75:
		var overlapping_bodies = character.get_node("Damage_Trigger").get_overlapping_bodies()
		if overlapping_bodies.has(Gibbi.Instance):
			state_machine.transition_to("Attack")
		else:
			state_machine.transition_to("Follow_Player")
