extends Path2D

const Enemy = preload("res://src/Enemy/Enemy.tscn")
const ObstacleEnemy = preload("res://src/ObstacleEnemy/ObstacleEnemy.tscn")

onready var timer = $EnemyTimer
onready var enemy_group = $EnemyGroup
onready var gen_position = $GenPosition

export (bool) var activated = true
	

func _process(delta):
	gen_position.offset += 10
	
func create_enemy(_position, _speed):
#	var direction = (Utils.center_point - gen_position.global_position) * 2
	var inst = Enemy.instance()
	enemy_group.add_child(inst)
	inst.start(_position, _speed)
	print("Enemy Created")

func _on_EnemyTimer_timeout():
	if activated:
		create_enemy(gen_position.global_position, 50)
		update()
	else:
		update()
		
#func _draw():
#	var direction = (Utils.center_point - gen_position.global_position) * 2
#	draw_line(gen_position.position, gen_position.position + direction, Color.blueviolet, 3)
