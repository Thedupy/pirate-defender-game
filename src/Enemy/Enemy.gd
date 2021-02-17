extends Area2D

var speed
var target = false
var velocity

const SunkEffect = preload("res://src/Effect/CrewSunkEffect.tscn")

func start(_position, _speed):
	self.global_position = _position
	self.speed = _speed
	look_at(Utils.center_point)
	self.velocity = Vector2(self.speed, 0).rotated(rotation)

func _process(delta):
	if !target:
		position += self.velocity * delta


func _on_Enemy_body_entered(_body):
	print("j'ai atteint l'ile")
	target = true
	Events.emit_signal("isle_reached")
	print("Event envoyé")


func _on_BulletCollision_area_entered(area):
	print("Une balle m'as touché")
	area.queue_free()
	destroy()


func _on_BulletCollision_body_entered(_body):
	# Player
	print("Joueur m'as touché")
	_body.take_damage(1)
	destroy()

func destroy():
	Events.emit_signal("enemy_killed")
	var number = randi() % 4 + 1
	for i in range(number):	
		var offset = Vector2(rand_range(-20,20), rand_range(-20, 20))
		var effect = SunkEffect.instance()
		effect.global_position = self.global_position + offset
		Utils.inst_on_main_scene(effect)
	queue_free()
