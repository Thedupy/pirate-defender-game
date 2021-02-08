extends KinematicBody2D

const SPEED = 100
var velocity = Vector2()
var can_shoot = true

const Bullet = preload("res://src/Bullet/Bullet.tscn")

onready var shoot_timer = $ShootDelay

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
	
func shoot():
	can_shoot = false
	shoot_timer.start()
	var canonball = Bullet.instance()
	Utils.inst_on_main_scene(canonball)
	canonball.velocity = self.velocity * 4
	canonball.global_position = $Canon/Position2D.global_position

func _on_ShootDelay_timeout():
	can_shoot = true

func _draw():
	var direction = (Utils.center_point - self.global_position) * 2
	draw_line(self.global_position, self.global_position + direction, Color.yellow, 2)
