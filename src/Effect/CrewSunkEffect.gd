extends Sprite

var crew_sprite : Array = [
	"res://assets/crew_1.png",
	"res://assets/crew_2.png",
	"res://assets/crew_3.png",
	"res://assets/crew_4.png"
]

func _ready():
	var choice = randi() % crew_sprite.size()
	self.texture = load(crew_sprite[choice])
	
