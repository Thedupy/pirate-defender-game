extends Node2D

onready var enemy_generator = $EnemyGenerator
onready var isle_life_node = $IsleLife

const Powerup = preload("res://src/Powerup/Powerup.tscn")

var isle_life = 10

func _ready():
	randomize()
	Events.connect("isle_reached", self, '_on_isle_reached')
	Events.connect("player_touched", self, '_on_Player_touched')

func _process(delta):
	pass
#	if Input.is_action_just_pressed("click"):
#		generate_power_up()

func _on_isle_reached():
	print("Allo le monde")
	isle_life -= 1
	if isle_life <= 0:
		end_game()
	isle_life_node.text = 'Life : ' + str(isle_life)

func _on_Player_touched(new_life:int):
	$PlayerLife.text = 'Player' + str(new_life)
	
func end_game():
	get_tree().reload_current_scene()
	
func generate_power_up():
	print("Generation de powerup")
	var random_point = Vector2(rand_range(0, Utils.display_width), rand_range(0, Utils.display_height))
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_point(random_point, 1, [], 4, false, true)
	while result != []:
		print(random_point)
		print(result)
		random_point = Vector2(rand_range(0, Utils.display_width), rand_range(0, Utils.display_height))
		result = space_state.intersect_point(random_point, 1, [], 4, false, true)
	var powerup = Powerup.instance()
	add_child(powerup)
	powerup.position = random_point


func _on_PowerupGeneration_timeout():
	generate_power_up()
