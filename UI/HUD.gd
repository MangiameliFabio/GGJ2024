extends Control

@export var banana_scene: PackedScene

var banana: Array[Node]
var gibbi: Gibbi

func change_kill_count():
	$HBoxContainer2/Label.text = str(gibbi.kill_count)

func remove_banana():
	banana.pop_back()

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	gibbi = Gibbi.Instance
	
	for i in gibbi.health:
		var banana = banana_scene.instantiate()
		$HBoxContainer.add_child(banana)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gibbi_enemy_killed():
	change_kill_count()
