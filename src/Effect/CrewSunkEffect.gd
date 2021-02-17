extends Sprite

func _ready():
	var choice = randi() % 9
	self.frame = choice
	
