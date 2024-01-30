extends Node

const VISITOR_SPAWN_RATE: float = 0.8

@export var zookeeper_scene: PackedScene
@export var zoovisitor_scene: PackedScene
@export var initial_wave_start_delay: float = 5.0
@export var enemy_wave_timer: float = 5.0

@onready var spawn_points: Array[Node] = self.get_children()
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var spawn_timer = $Spawn_Timer

var enemy_wave_count: int = 1
var tmp_counter: int = 0


func _ready():
	#setup_first_wave()
	pass


func _process(delta):
	if Input.is_action_just_pressed("dash_test"):
		spawn_next_wave()


func setup_first_wave() -> void:
	await get_tree().create_timer(initial_wave_start_delay).timeout
	rng.randomize()
	spawn_next_wave()
	spawn_timer.wait_time = enemy_wave_timer


func generate_enemy() -> CharacterBody3D:
	var random_number = rng.randf()
	var enemy: CharacterBody3D
	if random_number >= VISITOR_SPAWN_RATE:
		enemy = zookeeper_scene.instantiate()
	else:
		enemy = zoovisitor_scene.instantiate()
		
	return enemy


func spawn_next_wave() -> void:
	for index in enemy_wave_count:
		var random_number = rng.randi_range(0, 2)
		var enemy = generate_enemy()
		var test = tmp_counter % 3
		spawn_points[tmp_counter % 3].add_child(enemy)
		
		var random_spawn_offset = 0
		if tmp_counter % 2 == 0:
			random_spawn_offset = rng.randi_range(0, 9)
		else:
			random_spawn_offset = rng.randi_range(10, 19)
		tmp_counter += 1
		enemy.global_position.x = enemy.global_position.x + random_spawn_offset
	
	enemy_wave_count += 1
	spawn_timer.start()


func _on_spawn_timer_finished():
	spawn_next_wave()
