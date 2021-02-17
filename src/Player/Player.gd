extends KinematicBody2D

export (float) var SPEED = 100
var velocity = Vector2()
var can_shoot = true
var life = 3

var out_screen = false

const Bullet = preload("res://src/Bullet/Bullet.tscn")

onready var shoot_timer = $ShootDelay
onready var visibility_position = $Visibility

func _ready():
	pass

func _process(delta: float):
	if Input.is_action_pressed("left_move"):
		rotation -= 1.5 * delta
	elif Input.is_action_pressed("right_move"):
		rotation += 1.5 * delta
	
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		update()
	
	
func _physics_process(_delta: float):
	velocity = Vector2(SPEED, 0).rotated(rotation)
	velocity = move_and_slide(velocity)
	check_limit()
	
func check_limit():
	var my_pos = visibility_position.global_position
	if not out_screen:
		if my_pos.x < 0:
			position.x = Utils.display_width + 20
			out_screen = true
		elif my_pos.x > Utils.display_width:
			position.x = -20
			out_screen = true
			
		if my_pos.y < 0:
			position.y = Utils.display_height + 20
			out_screen = true
		elif my_pos.y > Utils.display_height:
			position.y = -20
			out_screen = true
		
	if my_pos.x > 0 and my_pos.x < Utils.display_width and my_pos.y > 0 and my_pos.y < Utils.display_height:
		print('in screen !')
		out_screen = false
	
	
func shoot():
	can_shoot = false
	shoot_timer.start()
	var canonball = Bullet.instance()
	Utils.inst_on_main_scene(canonball)
	canonball.velocity = self.velocity * 4
	canonball.global_position = $Canon/Position2D.global_position

func _on_ShootDelay_timeout():
	can_shoot = true
	
func take_damage(cpt: int):
	life -= 1
	if life <= 0:
		get_tree().reload_current_scene()
	Events.emit_signal("player_touched", life)

#func _draw():
#	var direction = (Utils.center_point - self.global_position) * 2
#	draw_line(self.global_position, self.global_position + direction, Color.yellow, 2)


func _on_Visibility_screen_exited():
	print('salut les nuls')
	if global_position.x < 0:
		global_position.x = Utils.display_width + 20
	elif global_position.x > Utils.display_width:
		global_position.x = -20
		
	if global_position.y < 0:
		global_position.y = Utils.display_height + 20
	elif global_position.y > Utils.display_height:
		global_position.y = -20
	
	print("Wooooosh !")
