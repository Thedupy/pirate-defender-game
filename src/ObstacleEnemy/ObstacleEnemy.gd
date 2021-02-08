extends Area2D

var speed
var velocity = Vector2.ZERO
var charge = false
var target_pos = Vector2.ZERO

const SunkEffect = preload("res://src/Effect/CrewSunkEffect.tscn")

func start(_position, _speed, target):
	charge = true	
	self.position = _position
	self.speed = _speed
	target_pos = target
	look_at(self.position + target_pos)
	yield(get_tree().create_timer(3), "timeout")
	charge = false
	self.velocity = Vector2(self.speed, 0).rotated(rotation)

func _process(delta):
	update()
	self.position += self.velocity * delta

func calcul_target_point() -> Vector2:
	var change_x = (Utils.display_width/2) - 40
	var change_y = (Utils.display_height/2) - 40
	var new_x = Utils.center_point.x + rand_range(-change_x, change_x)
	var new_y = Utils.center_point.y + rand_range(-change_y, change_y)
	return Vector2(new_x, new_y)
	
	
func _draw():
	draw_line(self.position, self.position + self.target_pos, Color.greenyellow, 1)

func destroy():
	var number = randi() % 4 + 1
	for i in range(number):	
		var offset = Vector2(rand_range(-20,20), rand_range(-20, 20))
		var effect = SunkEffect.instance()
		effect.global_position = self.global_position + offset
		Utils.inst_on_main_scene(effect)
	queue_free()
