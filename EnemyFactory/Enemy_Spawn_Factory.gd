extends Node

@export var zookeeper_scene: PackedScene
@export var zoovisitor_scene: PackedScene

@onready var spawn_points: Array[Node] = self.get_children()
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var enemy_wave_count: int = 1

func _ready():
	rng.randomize()
	spawn_next_wave()


# mehr besucher als zookeper

func _process(delta):
	if Input.is_action_just_pressed("dash_test"):
		spawn_next_wave()

func generate_enemy() -> CharacterBody3D:
	var number = rng.randf()
	var enemy: CharacterBody3D
	if number >= 0.8:
		enemy = zookeeper_scene.instantiate()
	else:
		enemy = zoovisitor_scene.instantiate()
		
	return enemy

func spawn_next_wave() -> void:
	for index in enemy_wave_count:
		print("in spawn")
		var random_number = rng.randi_range(0, 2)
		#var tmp = rng.randi_range(0, 30)
		var enemy = generate_enemy()
		spawn_points[random_number].add_child(enemy)
		#enemy.global_position.x = enemy.global_position.x + tmp
		enemy_wave_count += 1
		#await get_tree().create_timer(1000).timeout
		print("enemies spawned")
