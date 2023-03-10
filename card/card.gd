extends Node2D

@onready var label = $Label
@onready var sprite = $Sprite2D

var cardVal: int
# Called when the node enters the scene tree for the first time.
func _ready():
#	label.text = "3"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_card_value(value: int):
	cardVal = value
	sprite.frame = value


func set_destination(dest: Vector2):
	position = dest
	

